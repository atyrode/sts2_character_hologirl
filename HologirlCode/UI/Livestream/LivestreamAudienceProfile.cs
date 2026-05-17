namespace Hologirl.HologirlCode.UI.Livestream;

public readonly record struct LivestreamAudienceProfile(int FanAmount, int Tier, float Intensity)
{
    public static LivestreamAudienceProfile FromFanAmount(int fanAmount)
    {
        return fanAmount switch
        {
            >= 28 => new LivestreamAudienceProfile(fanAmount, 3, 1f),
            >= 14 => new LivestreamAudienceProfile(fanAmount, 2, 0.68f),
            >= 6 => new LivestreamAudienceProfile(fanAmount, 1, 0.44f),
            _ => new LivestreamAudienceProfile(fanAmount, 0, 0.22f)
        };
    }

    public float Chance(float proportion)
    {
        return Math.Clamp(proportion * Intensity, 0f, 1f);
    }

    public bool Roll(float proportion)
    {
        return Random.Shared.NextSingle() < Chance(proportion);
    }

    public int HypeReactionCount()
    {
        var baseline = Tier switch
        {
            >= 3 => 4,
            2 => 3,
            1 => Roll(0.82f) ? 2 : 1,
            _ => 1
        };

        return CountWithVariance(baseline, 1, 5);
    }

    public int CosmeticReactionCount()
    {
        var baseline = Tier switch
        {
            >= 2 => 2,
            1 => Roll(0.38f) ? 2 : 1,
            _ => 1
        };

        return Tier >= 3 && Roll(0.12f)
            ? Math.Min(3, baseline + 1)
            : baseline;
    }

    public int DeathReactionCount()
    {
        var baseline = Tier switch
        {
            >= 3 => 12,
            2 => 10,
            1 => 8,
            _ => 6
        };

        return CountWithVariance(baseline, 5, 14);
    }

    public int VictoryReactionCount()
    {
        var baseline = Tier switch
        {
            >= 3 => 9,
            2 => 7,
            1 => 5,
            _ => 3
        };

        return CountWithVariance(baseline, 3, 11);
    }

    public int StreamStartReactionCount()
    {
        var baseline = Tier switch
        {
            >= 3 => 13,
            2 => 9,
            1 => 6,
            _ => FanAmount <= 0 ? 3 : 4
        };

        return CountWithVariance(baseline, 2, 16);
    }

    public int AmbientMessageCount()
    {
        var baseline = Tier switch
        {
            >= 2 => 2,
            1 => Roll(0.32f) ? 2 : 1,
            _ => 1
        };

        return Tier >= 3 && Roll(0.12f)
            ? Math.Min(3, baseline + 1)
            : baseline;
    }

    public int AmbientDelayTurns()
    {
        return Tier switch
        {
            >= 2 => 1,
            1 => Roll(0.64f) ? 1 : 2,
            _ => Roll(0.28f) ? 1 : 2
        };
    }

    public float IdleDelaySeconds()
    {
        var baseDelay = Tier switch
        {
            >= 3 => 4.4f,
            2 => 5.8f,
            1 => 8.6f,
            _ => 13.5f
        };

        return baseDelay + Random.Shared.NextSingle() * (Tier >= 2 ? 3.2f : 5.4f);
    }

    public int IdleMessageCount()
    {
        return Tier >= 3 && Roll(0.24f) ? 2 : 1;
    }

    public float RepeatedEventChance(float eventProportion, int eventsThisTurn)
    {
        var repeatDampener = eventsThisTurn switch
        {
            <= 1 => 1f,
            2 => 0.65f,
            3 => 0.42f,
            _ => 0.25f
        };

        return Chance(eventProportion) * repeatDampener;
    }

    public float PileOnChance(float baseChance)
    {
        return Math.Clamp(baseChance + Tier switch
        {
            >= 3 => 0.46f,
            2 => 0.28f,
            1 => 0.12f,
            _ => 0f
        }, 0f, 0.92f);
    }

    public float PileOnUseChance()
    {
        return Tier switch
        {
            >= 3 => 0.9f,
            2 => 0.82f,
            1 => 0.74f,
            _ => 0.68f
        };
    }

    public float NeutralFollowupChance()
    {
        return Tier switch
        {
            >= 3 => 0.32f,
            2 => 0.24f,
            1 => 0.12f,
            _ => 0.04f
        };
    }

    public float ExtraReactionChance()
    {
        return Tier switch
        {
            >= 3 => 0.38f,
            2 => 0.22f,
            1 => 0.08f,
            _ => 0.02f
        };
    }

    public int RosterSize()
    {
        return FanAmount switch
        {
            <= 0 => 2,
            <= 4 => 1,
            <= 7 => 2,
            <= 13 => 4,
            <= 27 => 8,
            <= 45 => 14,
            _ => 24
        };
    }

    public int PileOnTargetCount(int reactionCount)
    {
        if (reactionCount <= 1)
            return 0;

        var min = Tier >= 2 ? Math.Min(reactionCount, 2) : 1;
        var max = Tier >= 3 ? reactionCount + 1 : reactionCount;
        return Math.Clamp(Random.Shared.Next(min, max + 1), 1, reactionCount);
    }

    private static int CountWithVariance(int baseline, int min, int max)
    {
        var variance = Random.Shared.NextSingle() switch
        {
            < 0.18f => -1,
            > 0.82f => 1,
            _ => 0
        };

        return Math.Clamp(baseline + variance, min, max);
    }
}
