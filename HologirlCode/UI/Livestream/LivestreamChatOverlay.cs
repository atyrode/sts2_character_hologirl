using Godot;
using Hologirl.HologirlCode;
using System.Threading.Tasks;

namespace Hologirl.HologirlCode.UI.Livestream;

public partial class LivestreamChatOverlay : Control
{
    private const int MaxVisibleMessages = 5;
    private const int MaxBufferedMessages = 7;
    private const float MessageLifetimeSeconds = 10f;
    private const float FadeSeconds = 1.6f;
    private const float NeutralChance = 0.28f;
    private const float PileOnChance = 0.34f;
    private const float ReplyChance = 0.08f;
    private const float StreamStartWindowSeconds = 12f;
    private static readonly Vector2 OverlayPosition = new(430f, 260f);
    private static readonly Vector2 OverlaySize = new(520f, 190f);
    private const float MinRowHeight = 32f;
    private const float MaxRowHeight = 148f;
    private const float RowGap = 3f;
    private static readonly IReadOnlyDictionary<string, string> EmoteImageTags =
        new Dictionary<string, string>(StringComparer.Ordinal)
        {
            ["HoloPog"] = EmoteTag("holo_pog"),
            ["HoloSweat"] = EmoteTag("holo_sweat"),
            ["HoloSmirk"] = EmoteTag("holo_smirk"),
            ["HoloLUL"] = EmoteTag("holo_lul"),
            ["HoloKEK"] = EmoteTag("holo_kek"),
            ["HoloSalute"] = EmoteTag("holo_salute"),
            ["HoloCope"] = EmoteTag("holo_cope"),
            ["HoloQuestion"] = EmoteTag("holo_question"),
            ["HoloPanic"] = EmoteTag("holo_panic"),
            ["HoloClean"] = EmoteTag("holo_clean"),
            ["HoloDisaster"] = EmoteTag("holo_disaster"),
            ["HoloHype"] = EmoteTag("holo_hype"),
            ["HoloEZ"] = EmoteTag("holo_clean"),
            ["HoloOmega"] = EmoteTag("holo_kek")
        };

    private readonly List<MessageView> messages = [];
    private readonly Control messageStack = new();
    private bool initialized;
    private int ambientFanAmount;
    private LivestreamChatMood combatMood = LivestreamChatMood.Stable;
    private int idleScheduleVersion;
    private ulong streamStartWindowUntilMsec;

    public override void _Ready()
    {
        EnsureInitialized();
    }

    public void EnsureInitialized()
    {
        if (initialized)
            return;

        initialized = true;
        
        MainFile.Logger.Info("Initializing Livestream chat overlay synchronously.");
        
        Visible = true;
        MouseFilter = MouseFilterEnum.Ignore;
        ProcessMode = ProcessModeEnum.Always;
        SetProcess(true);
        TopLevel = false;
        Size = OverlaySize;
        CustomMinimumSize = OverlaySize;
        ZIndex = 1;
        SetCombatCanvasPosition();

        messageStack.Visible = true;
        messageStack.MouseFilter = MouseFilterEnum.Ignore;
        messageStack.Position = Vector2.Zero;
        messageStack.Size = OverlaySize;
        messageStack.CustomMinimumSize = OverlaySize;
        messageStack.SizeFlagsHorizontal = SizeFlags.ExpandFill;
        messageStack.SizeFlagsVertical = SizeFlags.ExpandFill;
        AddChild(messageStack);
        
        var viewportSize = IsInsideTree() ? GetViewportRect().Size : Vector2.Zero;
        MainFile.Logger.Info($"Livestream chat overlay initialized at {Position} size={Size} viewport={viewportSize} insideTree={IsInsideTree()}.");
    }

    public void SetCombatCanvasPosition()
    {
        if (IsInsideTree())
            GlobalPosition = OverlayPosition;
        else
            Position = OverlayPosition;
    }

    public void PushEvent(LivestreamChatEvent eventKind, int reactionCount = 1)
    {
        EnsureInitialized();
        ResetIdleTimer();

        if (eventKind == LivestreamChatEvent.Start)
        {
            streamStartWindowUntilMsec = Time.GetTicksMsec() + (ulong)(StreamStartWindowSeconds * 1000f);
            reactionCount = Math.Max(reactionCount, GetStreamStartReactionCount());
        }
        else if (IsStreamStartWindowActive() && IsGenericCosmeticEvent(eventKind))
        {
            MainFile.Logger.Info($"Livestream chat suppressed early generic event during stream start: {eventKind}.");
            return;
        }

        reactionCount = eventKind == LivestreamChatEvent.Start
            ? Math.Clamp(reactionCount, 5, 22)
            : eventKind == LivestreamChatEvent.HologirlDeath
                ? Math.Clamp(reactionCount, 5, 14)
            : Math.Clamp(reactionCount, 1, 5);

        var audience = LivestreamAudienceProfile.FromFanAmount(ambientFanAmount);
        var reactionDelays = CreateReactionDelays(eventKind, reactionCount);
        var pileOnTheme = reactionCount >= 2 && Random.Shared.NextSingle() < audience.PileOnChance(PileOnChance)
            ? LivestreamChatCatalog.GetPileOnTheme(eventKind)
            : null;
        var pileOnTargetCount = pileOnTheme is not null
            ? audience.PileOnTargetCount(reactionCount)
            : 0;
        var pileOnQueued = 0;

        for (var i = 0; i < reactionCount; i++)
        {
            var usePileOn = pileOnTheme is not null &&
                pileOnQueued < pileOnTargetCount &&
                Random.Shared.NextSingle() < audience.PileOnUseChance();
            var line = usePileOn
                ? LivestreamChatCatalog.GetPileOnReaction(pileOnTheme!)
                : LivestreamChatCatalog.GetReaction(eventKind);
            var delay = reactionDelays[i];
            QueueLine(line, delay);
            if (usePileOn)
                pileOnQueued++;
            if (!usePileOn)
                MaybeQueueReply(eventKind, line, delay);
        }

        if (eventKind != LivestreamChatEvent.Start && Random.Shared.NextSingle() < NeutralChance)
        {
            var line = LivestreamChatCatalog.GetNeutral(combatMood);
            var delay = GetLooseDelay(2.6f, 5.4f);
            QueueLine(line, delay);
            MaybeQueueReply(eventKind, line, delay);
        }

        if (eventKind != LivestreamChatEvent.Start && reactionCount >= 3 && Random.Shared.NextSingle() < 0.42f)
        {
            var line = LivestreamChatCatalog.GetReaction(eventKind);
            var delay = GetLooseDelay(5.2f, 8.4f);
            QueueLine(line, delay);
            MaybeQueueReply(eventKind, line, delay);
        }
    }

    public void PushNeutral(int messageCount = 1)
    {
        EnsureInitialized();
        if (IsStreamStartWindowActive())
        {
            MainFile.Logger.Info("Livestream neutral chat suppressed during stream start.");
            return;
        }

        ResetIdleTimer();
        messageCount = Math.Clamp(messageCount, 1, 3);
        for (var i = 0; i < messageCount; i++)
            QueueLine(LivestreamChatCatalog.GetNeutral(combatMood), GetLooseDelay(i * 0.25f, i * 0.25f + 0.9f));
    }

    public void SetAmbientFanAmount(int fanAmount)
    {
        EnsureInitialized();
        var nextFanAmount = Math.Max(0, fanAmount);
        if (ambientFanAmount == nextFanAmount && idleScheduleVersion > 0)
            return;

        ambientFanAmount = nextFanAmount;
        ResetIdleTimer();
    }

    public void SetCombatMood(LivestreamChatMood mood)
    {
        EnsureInitialized();
        combatMood = mood;
    }

    private void PushIdle(int messageCount)
    {
        messageCount = Math.Clamp(messageCount, 1, 3);
        for (var i = 0; i < messageCount; i++)
            QueueLine(LivestreamChatCatalog.GetIdle(combatMood), GetLooseDelay(i * 0.4f, i * 0.4f + 1.4f));
    }

    private void ResetIdleTimer()
    {
        idleScheduleVersion++;
        if (ambientFanAmount <= 0)
            return;

        _ = PushIdleAfterDelay(idleScheduleVersion, LivestreamAudienceProfile.FromFanAmount(ambientFanAmount).IdleDelaySeconds());
    }

    private void PushLine(LivestreamChatLine line)
    {
        var rowHeight = EstimateRowHeight(line);
        var row = new Control
        {
            Visible = true,
            MouseFilter = MouseFilterEnum.Ignore,
            CustomMinimumSize = new Vector2(OverlaySize.X, rowHeight),
            SizeFlagsHorizontal = SizeFlags.ExpandFill,
            Size = new Vector2(OverlaySize.X, rowHeight)
        };

        row.AddChild(CreateChatLabel(line, rowHeight));

        messageStack.AddChild(row);
        var view = new MessageView(row, rowHeight);
        messages.Add(view);
        MarkOverflowForFade();
        LayoutMessagesBottomUp();
        MainFile.Logger.Info($"Livestream chat pushed: {line.Username}: {line.Message}");
        _ = FadeMessageAfterLifetime(view);

        while (messages.Count > MaxBufferedMessages)
        {
            RemoveMessage(messages[0]);
        }
    }

    private void QueueLine(LivestreamChatLine line, float delaySeconds = 0f)
    {
        _ = PushLineAfterDelay(line, Math.Max(0f, delaySeconds));
        MainFile.Logger.Info($"Livestream chat queued: {line.Username}: {line.Message} delay={delaySeconds:0.00}s");
    }

    private void MaybeQueueReply(LivestreamChatEvent eventKind, LivestreamChatLine line, float originalDelay)
    {
        var chance = eventKind == LivestreamChatEvent.Start ? ReplyChance * 1.2f : ReplyChance;
        if (LooksLikeChatPrompt(line.Message))
            chance *= 3.8f;
        else
            chance *= 0.55f;

        if (Random.Shared.NextSingle() >= chance)
            return;

        QueueLine(
            LivestreamChatCatalog.GetReplyTo(line),
            originalDelay + GetLooseDelay(2.0f, 5.2f));

        if (LooksLikeChatPrompt(line.Message) && Random.Shared.NextSingle() < 0.16f)
            QueueReplyPileOn(line, originalDelay + GetLooseDelay(3.6f, 6.4f));
    }

    private static bool LooksLikeChatPrompt(string message)
    {
        return message.Contains('?') ||
            message.Contains("chat", StringComparison.OrdinalIgnoreCase);
    }

    private void QueueReplyPileOn(LivestreamChatLine line, float firstDelay)
    {
        var theme = LivestreamChatCatalog.GetReplyPileOnTheme();
        var count = Random.Shared.Next(2, 5);
        var cursor = firstDelay;
        for (var i = 0; i < count; i++)
        {
            if (i > 0)
                cursor += GetLooseDelay(0.35f, 1.6f);

            QueueLine(LivestreamChatCatalog.GetReplyPileOnReaction(line, theme), cursor);
        }
    }

    private static IReadOnlyList<float> CreateReactionDelays(LivestreamChatEvent eventKind, int reactionCount)
    {
        var delays = new List<float>(reactionCount);
        var cursor = eventKind switch
        {
            LivestreamChatEvent.Start => GetLooseDelay(0.25f, 1.15f),
            LivestreamChatEvent.HologirlDeath => GetLooseDelay(0.45f, 1.35f),
            _ => GetLooseDelay(1.25f, 2.75f)
        };

        for (var i = 0; i < reactionCount; i++)
        {
            if (i > 0)
                cursor += eventKind switch
                {
                    LivestreamChatEvent.Start => GetStreamStartGap(),
                    LivestreamChatEvent.HologirlDeath => GetDeathReactionGap(),
                    _ => GetHumanReactionGap()
                };

            delays.Add(cursor);
        }

        return delays;
    }

    private static int GetStreamStartReactionCount()
    {
        return Random.Shared.NextSingle() switch
        {
            < 0.08f => Random.Shared.Next(5, 8),
            < 0.28f => Random.Shared.Next(8, 11),
            < 0.72f => Random.Shared.Next(11, 15),
            < 0.92f => Random.Shared.Next(15, 19),
            _ => Random.Shared.Next(19, 23)
        };
    }

    private static float GetStreamStartGap()
    {
        return Random.Shared.NextSingle() switch
        {
            < 0.16f => GetLooseDelay(0.12f, 0.45f),
            < 0.62f => GetLooseDelay(0.55f, 1.25f),
            < 0.88f => GetLooseDelay(1.25f, 2.25f),
            _ => GetLooseDelay(2.25f, 3.35f)
        };
    }

    private bool IsStreamStartWindowActive()
    {
        return Time.GetTicksMsec() < streamStartWindowUntilMsec;
    }

    private static bool IsGenericCosmeticEvent(LivestreamChatEvent eventKind)
    {
        return eventKind is LivestreamChatEvent.CardPlayed or
            LivestreamChatEvent.CardDrawn or
            LivestreamChatEvent.CardExhausted or
            LivestreamChatEvent.TurnStart or
            LivestreamChatEvent.TurnEnd;
    }

    private static float GetHumanReactionGap()
    {
        return Random.Shared.NextSingle() switch
        {
            < 0.12f => GetLooseDelay(0.18f, 0.55f),
            < 0.52f => GetLooseDelay(0.9f, 1.8f),
            < 0.84f => GetLooseDelay(1.8f, 3.1f),
            _ => GetLooseDelay(3.1f, 4.8f)
        };
    }

    private static float GetDeathReactionGap()
    {
        return Random.Shared.NextSingle() switch
        {
            < 0.16f => GetLooseDelay(0.22f, 0.65f),
            < 0.58f => GetLooseDelay(0.8f, 1.7f),
            < 0.88f => GetLooseDelay(1.7f, 3.0f),
            _ => GetLooseDelay(3.0f, 4.5f)
        };
    }

    private static float GetLooseDelay(float min, float max)
    {
        return min + Random.Shared.NextSingle() * Math.Max(0f, max - min);
    }

    private void MarkOverflowForFade()
    {
        var overflowCount = messages.Count - MaxVisibleMessages;
        if (overflowCount <= 0)
            return;

        for (var i = 0; i < overflowCount; i++)
            StartFade(messages[i]);
    }

    private async Task PushLineAfterDelay(LivestreamChatLine line, float delaySeconds)
    {
        if (delaySeconds > 0f)
            await WaitSeconds(delaySeconds);

        if (!GodotObject.IsInstanceValid(this) || !IsInsideTree())
            return;

        PushLine(line);
    }

    private async Task PushIdleAfterDelay(int scheduleVersion, float delaySeconds)
    {
        await WaitSeconds(delaySeconds);

        if (!GodotObject.IsInstanceValid(this) ||
            !IsInsideTree() ||
            scheduleVersion != idleScheduleVersion ||
            ambientFanAmount <= 0)
            return;

        PushIdle(LivestreamAudienceProfile.FromFanAmount(ambientFanAmount).IdleMessageCount());
        ResetIdleTimer();
    }

    private async Task FadeMessageAfterLifetime(MessageView message)
    {
        await WaitSeconds(Math.Max(0f, MessageLifetimeSeconds - FadeSeconds));

        if (!GodotObject.IsInstanceValid(this) || !IsInsideTree())
            return;

        StartFade(message);
    }

    private async Task WaitSeconds(float seconds)
    {
        if (seconds <= 0f || !IsInsideTree())
            return;

        await ToSignal(GetTree().CreateTimer(seconds), "timeout");
    }

    private void StartFade(MessageView message)
    {
        if (message.IsFading || !messages.Contains(message) || !GodotObject.IsInstanceValid(message.Row))
            return;

        message.IsFading = true;
        var tween = CreateTween();
        tween.TweenProperty(message.Row, "modulate", new Color(1f, 1f, 1f, 0f), FadeSeconds);
        tween.TweenCallback(Callable.From(() => RemoveMessage(message)));
    }

    private void RemoveMessage(MessageView message)
    {
        if (!messages.Remove(message))
            return;

        if (GodotObject.IsInstanceValid(message.Row))
            message.Row.QueueFree();

        LayoutMessagesBottomUp();
    }

    private void LayoutMessagesBottomUp()
    {
        var y = OverlaySize.Y;
        for (var i = messages.Count - 1; i >= 0; i--)
        {
            y -= messages[i].Height;
            messages[i].Row.Position = new Vector2(0f, y);
            messages[i].Row.Size = new Vector2(OverlaySize.X, messages[i].Height);
            y -= RowGap;
        }
    }

    private static RichTextLabel CreateChatLabel(LivestreamChatLine line, float rowHeight)
    {
        var label = new RichTextLabel
        {
            BbcodeEnabled = true,
            Text = $"[color=#{line.UsernameColor}]{FormatChatText(line.Username)}:[/color] {FormatChatMessage(line.Message)}",
            Visible = true,
            MouseFilter = MouseFilterEnum.Ignore,
            FitContent = false,
            ScrollActive = false,
            ClipContents = false,
            AutowrapMode = TextServer.AutowrapMode.WordSmart,
            CustomMinimumSize = new Vector2(OverlaySize.X, rowHeight),
            Size = new Vector2(OverlaySize.X, rowHeight)
        };
        label.AddThemeFontSizeOverride("font_size", 18);
        label.AddThemeColorOverride("default_color", new Color("f2f4ff"));
        label.AddThemeColorOverride("font_shadow_color", new Color(0f, 0f, 0f, 0.82f));
        label.AddThemeConstantOverride("shadow_offset_x", 1);
        label.AddThemeConstantOverride("shadow_offset_y", 2);
        return label;
    }

    private static float EstimateRowHeight(LivestreamChatLine line)
    {
        var message = FormatChatText(line.Message);
        var emoteCount = EmoteImageTags.Keys.Count(code => message.Contains(code, StringComparison.Ordinal));
        var estimatedWidthChars = Math.Max(1, line.Username.Length + 2 + message.Length + emoteCount * 5);
        var estimatedLines = Math.Max(1, (int)Math.Ceiling(estimatedWidthChars / 52f));
        var height = 6f + estimatedLines * 26f;
        if (emoteCount > 0)
            height = Math.Max(height, 38f);

        return Math.Clamp(height, MinRowHeight, MaxRowHeight);
    }

    private static string FormatChatText(string text)
    {
        return text
            .Replace("\r\n", " ")
            .Replace('\r', ' ')
            .Replace('\n', ' ')
            .Replace("[", "[lb]")
            .Replace("]", "[rb]");
    }

    private static string FormatChatMessage(string message)
    {
        var words = FormatChatText(message).Split(' ', StringSplitOptions.RemoveEmptyEntries);
        for (var i = 0; i < words.Length; i++)
        {
            if (EmoteImageTags.TryGetValue(words[i], out var imageTag))
                words[i] = imageTag;
        }

        return string.Join(' ', words);
    }

    private static string EmoteTag(string filename)
    {
        return $"[img=40x30]res://Hologirl/images/emotes/{filename}.png[/img]";
    }

    private sealed class MessageView(Control row, float height)
    {
        public Control Row { get; } = row;
        public float Height { get; } = height;
        public bool IsFading { get; set; }
    }
}
