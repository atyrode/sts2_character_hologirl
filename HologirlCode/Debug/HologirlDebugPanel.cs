using Godot;
using MegaCrit.Sts2.Core.DevConsole;
using MegaCrit.Sts2.Core.Models;
using MegaCrit.Sts2.Core.Rooms;
using MegaCrit.Sts2.Core.Runs;

namespace Hologirl.HologirlCode.Debug;

public partial class HologirlDebugPanel : Control
{
    private readonly DevConsole _console = new(shouldAllowDebugCommands: true);

    private PanelContainer _panel = null!;
    private OptionButton _actionPicker = null!;
    private OptionButton _roomPicker = null!;
    private OptionButton _encounterPicker = null!;
    private OptionButton _eventPicker = null!;
    private LineEdit _commandPreview = null!;
    private Label _statusLabel = null!;

    public override void _Ready()
    {
        Name = "HologirlDebugPanel";
        ProcessMode = ProcessModeEnum.Always;
        MouseFilter = MouseFilterEnum.Ignore;
        SetAnchorsAndOffsetsPreset(LayoutPreset.FullRect);
        SetProcessInput(true);

        _panel = BuildPanel();
        AddChild(_panel);
        _panel.Visible = false;
        UpdateVisibleControls();
        UpdateCommandPreview();
    }

    public override void _Input(InputEvent @event)
    {
        if (@event is not InputEventKey { Pressed: true, Echo: false, Keycode: Key.F3 })
            return;

        _panel.Visible = !_panel.Visible;
        GetViewport().SetInputAsHandled();
    }

    private PanelContainer BuildPanel()
    {
        PanelContainer panel = new()
        {
            MouseFilter = MouseFilterEnum.Stop,
            Position = new Vector2(24f, 118f),
            CustomMinimumSize = new Vector2(430f, 0f)
        };
        StyleBoxFlat panelStyle = new()
        {
            BgColor = new Color(0.055f, 0.06f, 0.075f, 0.94f),
            BorderColor = new Color(0.46f, 0.50f, 0.82f, 0.95f),
            BorderWidthTop = 2,
            BorderWidthRight = 2,
            BorderWidthBottom = 2,
            BorderWidthLeft = 2,
            CornerRadiusTopLeft = 6,
            CornerRadiusTopRight = 6,
            CornerRadiusBottomRight = 6,
            CornerRadiusBottomLeft = 6
        };
        panel.AddThemeStyleboxOverride("panel", panelStyle);

        MarginContainer margin = new();
        margin.AddThemeConstantOverride("margin_left", 14);
        margin.AddThemeConstantOverride("margin_top", 12);
        margin.AddThemeConstantOverride("margin_right", 14);
        margin.AddThemeConstantOverride("margin_bottom", 12);
        panel.AddChild(margin);

        VBoxContainer root = new();
        root.AddThemeConstantOverride("separation", 8);
        margin.AddChild(root);

        HBoxContainer header = new();
        root.AddChild(header);

        Label title = new()
        {
            Text = "Hologirl Debug",
            SizeFlagsHorizontal = SizeFlags.ExpandFill
        };
        title.AddThemeFontSizeOverride("font_size", 18);
        header.AddChild(title);

        Button close = new() { Text = "Hide" };
        close.Pressed += () => _panel.Visible = false;
        header.AddChild(close);

        _actionPicker = CreateOptionButton(["Room", "Fight", "Event", "Command"]);
        _actionPicker.ItemSelected += _ =>
        {
            UpdateVisibleControls();
            UpdateCommandPreview();
        };
        root.AddChild(LabeledRow("Action", _actionPicker));

        _roomPicker = CreateOptionButton(GetRoomOptions());
        _roomPicker.ItemSelected += _ => UpdateCommandPreview();
        root.AddChild(LabeledRow("Room", _roomPicker));

        _encounterPicker = CreateOptionButton(GetEncounterOptions());
        _encounterPicker.ItemSelected += _ => UpdateCommandPreview();
        root.AddChild(LabeledRow("Encounter", _encounterPicker));

        _eventPicker = CreateOptionButton(GetEventOptions());
        _eventPicker.ItemSelected += _ => UpdateCommandPreview();
        root.AddChild(LabeledRow("Event", _eventPicker));

        FlowContainer quickRooms = new();
        quickRooms.AddThemeConstantOverride("h_separation", 6);
        quickRooms.AddThemeConstantOverride("v_separation", 6);
        foreach (string room in new[] { "Monster", "Elite", "Boss", "Shop", "RestSite", "Treasure", "Event", "Map" })
            quickRooms.AddChild(CreateCommandButton(room, $"room {room}"));
        root.AddChild(quickRooms);

        _commandPreview = new LineEdit
        {
            PlaceholderText = "Console command",
            Text = "room Shop"
        };
        _commandPreview.TextChanged += _ => { };
        root.AddChild(LabeledRow("Command", _commandPreview));

        Button run = new()
        {
            Text = "Run",
            CustomMinimumSize = new Vector2(0f, 38f)
        };
        run.Pressed += () => ExecuteCommand(_commandPreview.Text);
        root.AddChild(run);

        _statusLabel = new()
        {
            Text = "F3 toggles this panel.",
            AutowrapMode = TextServer.AutowrapMode.WordSmart
        };
        _statusLabel.AddThemeColorOverride("font_color", new Color(0.78f, 0.82f, 0.94f));
        root.AddChild(_statusLabel);

        return panel;
    }

    private static HBoxContainer LabeledRow(string labelText, Control control)
    {
        HBoxContainer row = new();
        row.AddThemeConstantOverride("separation", 8);

        Label label = new()
        {
            Text = labelText,
            CustomMinimumSize = new Vector2(82f, 0f),
            VerticalAlignment = VerticalAlignment.Center
        };
        row.AddChild(label);

        control.SizeFlagsHorizontal = SizeFlags.ExpandFill;
        row.AddChild(control);

        return row;
    }

    private static OptionButton CreateOptionButton(IEnumerable<string> items)
    {
        OptionButton optionButton = new()
        {
            FitToLongestItem = false
        };

        foreach (string item in items)
            optionButton.AddItem(item);

        return optionButton;
    }

    private static Button CreateCommandButton(string label, string command)
    {
        Button button = new() { Text = label };
        button.Pressed += () => ExecuteShared(command);
        return button;
    }

    private static IReadOnlyList<string> GetRoomOptions()
    {
        return Enum.GetNames<RoomType>()
            .Where(room => room != nameof(RoomType.Unassigned))
            .ToList();
    }

    private static IReadOnlyList<string> GetEncounterOptions()
    {
        return ModelDb.AllEncounters
            .Select(encounter => encounter.Id.Entry)
            .OrderBy(id => id)
            .ToList();
    }

    private static IReadOnlyList<string> GetEventOptions()
    {
        return ModelDb.AllEvents
            .Concat(ModelDb.AllAncients)
            .Select(eventModel => eventModel.Id.Entry)
            .OrderBy(id => id)
            .ToList();
    }

    private void UpdateVisibleControls()
    {
        int selectedAction = _actionPicker.Selected;
        _roomPicker.GetParent<Control>().Visible = selectedAction == 0;
        _encounterPicker.GetParent<Control>().Visible = selectedAction == 1;
        _eventPicker.GetParent<Control>().Visible = selectedAction == 2;
        _commandPreview.Editable = selectedAction == 3;
    }

    private void UpdateCommandPreview()
    {
        _commandPreview.Text = _actionPicker.Selected switch
        {
            0 => $"room {_roomPicker.GetItemText(_roomPicker.Selected)}",
            1 => $"fight {_encounterPicker.GetItemText(_encounterPicker.Selected)}",
            2 => $"event {_eventPicker.GetItemText(_eventPicker.Selected)}",
            _ => _commandPreview.Text
        };
    }

    private void ExecuteCommand(string command)
    {
        command = command.Trim();
        if (string.IsNullOrEmpty(command))
            return;

        if (!RunManager.Instance.IsInProgress)
        {
            _statusLabel.Text = "Start a run before using run debug commands.";
            return;
        }

        CmdResult result = _console.ProcessCommand(command);
        _statusLabel.Text = result.success ? result.msg : $"Error: {result.msg}";
    }

    private static void ExecuteShared(string command)
    {
        HologirlDebugPanel? panel = NRunPatch.CurrentPanel;
        if (panel == null)
            return;

        panel._commandPreview.Text = command;
        panel.ExecuteCommand(command);
    }
}
