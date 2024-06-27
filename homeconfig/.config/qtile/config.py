#imports
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy

mod = "mod4"
myTerm = "alacritty"

def myfunc(text): 
    for string in [" - Chromium", " LibreWolf"]: 
        text = text.replace(string, "") 
    return text

#key bindings
keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "h", lazy.window.toggle_minimize(), desc="Toggle minimize"),
    Key([mod, "shift"], "Return", lazy.layout.toggle_split(), desc="Toggle between split and unsplit sides of stack"),
    Key([mod], "Return", lazy.spawn(myTerm), desc="Launch terminal"),
    Key([mod], "s", lazy.spawn("flameshot gui"), desc="Take a screenshot"),
    Key([mod], "d", lazy.spawn("dmenu_run -vi"), desc="Run dmenu"),
    Key([mod], "x", lazy.spawn("sh -c 'sleep 1 && xset dpms force off'"), desc="Turn off the screen"),
    # Languages
    Key([mod], "F1", lazy.spawn("setxkbmap us"), desc="Set the keyboard to US layout"),
    Key([mod], "F2", lazy.spawn("setxkbmap mk"), desc="Set the keyboard to MK layout"),
    Key([mod], "F3", lazy.spawn("setxkbmap ru phonetic"), desc="Set the keyboard to RU layout"),
    Key([mod], "F4", lazy.spawn("setxkbmap gr"), desc="Set the keyboard to GR layout"),
    Key([mod], "F5", lazy.spawn("setxkbmap de"), desc="Set the keyboard to DE layout"),
    Key([mod], "F6", lazy.spawn("setxkbmap hr"), desc="Set the keyboard to HR layout"),
    Key([mod], "F7", lazy.spawn("setxkbmap rs"), desc="Set the keyboard to RS layout"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod, "shift"], "c", lazy.window.kill(), desc="Kill focused window"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen on the focused window"),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "shift"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

#groups
groups = []
group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
]

group_labels = [
    "󰆍",
    "󰈹",
    "󰟒",
    "",
    "",
]

group_layouts = [
    "max",
    "max",
    "monadtall",
    "max",
    "zoomy",
]

for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # # mod + shift + group number = move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                desc="move focused window to group {}".format(i.name),
            ),
        ]
    )

# color scheme
colors = [
    ["#f7768e", "#f7768e"],  # 0 This keyword, HTML elements, Regex group symbol, CSS units, Terminal Red
    ["#ff9e64", "#ff9e64"],  # Number and Boolean constants, Language support constants
    ["#e0af68", "#e0af68"],  # Function parameters, Regex character sets, Terminal Yellow
    ["#9ece6a", "#9ece6a"],  # Strings, CSS class names
    ["#73daca", "#73daca"],  # Object literal keys, Markdown links, Terminal Green
    ["#b4f9f8", "#b4f9f8"],  # Regex literal strings
    ["#2ac3de", "#2ac3de"],  # Language support functions, CSS HTML elements
    ["#7dcfff", "#7dcfff"],  # Object properties, Regex quantifiers and flags, Markdown headings, Terminal Cyan, Markdown code, Import/export keywords
    ["#7aa2f7", "#7aa2f7"],  # Function names, CSS property names, Terminal Blue
    ["#bb9af7", "#bb9af7"],  # Control Keywords, Storage Types, Regex symbols and operators, HTML Attributes, Terminal Magenta
    ["#c0caf5", "#c0caf5"],  # Variables, Class names, Terminal White
    ["#a9b1d6", "#a9b1d6"],  # 11 Editor Foreground
    ["#9aa5ce", "#9aa5ce"],  # 12 Markdown Text, HTML Text
    ["#cfc9c2", "#cfc9c2"],  # 13 Parameters inside functions (semantic highlighting only)
    ["#565f89", "#565f89"],  # 14 Comments
    ["#414868", "#414868"],  # 15 Terminal Black
    ["#24283b", "#24283b"],  # 16 Editor Background (Storm)
    ["#1a1b26", "#1a1b26"],  # 17 Editor Background (Night)
]

#layouts
layout_theme = {
    "border_width": 4,
    "margin": 15,
    "border_focus": colors[11],
    "border_normal": colors[17],
}

layouts = [
    layout.Columns(**layout_theme),
    layout.Max(
        border_focus=colors[11], 
        border_normal=colors[17],
    ),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(num_stacks=2),
    # layout.Bsp(),
    layout.Matrix(**layout_theme),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(
        border_focus=colors[11], 
        border_normal=colors[17],
    ),
    layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(),
    layout.Floating(**layout_theme)
]

#widgets
widget_defaults = dict(
    font="Mononoki Nerd Font",
    fontsize=15,
    padding=3,
    background=colors[17],
    foreground=colors[11],
    active=colors[11],
    inactive=colors[15],
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                #widget.Pomodoro(
                #    prefix_inactive='POMODORO!',
                #    prefix_long_break='Long break',
                #    color_active=colors[3],
                #    color_break=colors[2],
                #    color_inactive=colors[0]
                # ),
                widget.GroupBox(
                    margin_y = 3,
                    margin_x = 5,
                    padding_y = 0,
                    padding_x = 1,
                    fontsize = 25,
                    font = "JetBrainsMono Nerd Font Mono",
                    highlight_method = "line",
                    highlight_color = colors[16],
                    this_current_screen_border = colors[11],
                ),
                widget.TextBox(
                 text = '|',
                 font = "Agave Nerd Font",
                 foreground = colors[11],
                 padding = 2,
                 fontsize = 14
                 ),
                widget.CurrentLayoutIcon(
                    scale = 0.8,
                    padding = 4,
                ),
                widget.CurrentLayout(),
                widget.TextBox(
                 text = '|',
                 font = "Agave Nerd Font",
                 foreground = colors[11],
                 padding = 2,
                 fontsize = 14
                 ),
                widget.Prompt(),
                widget.TaskList(
                     theme_mode= "preferred",
                     icon_size = 20,
                     margin = 0,
                     parse_text=myfunc,
                     highlight_method = "block",
                     unfocused_border = colors[17],
                     border = colors[16],
                     urgent_border = colors[0]
                ),
                widget.Systray(),
                widget.Sep(
                    linewidth = 0,
                    padding = 10,
                ),
                widget.KeyboardLayout(
                    font="Agave Nerd Font Bold"
                ),
                widget.BatteryIcon(
                    theme_path="~/.icons/TokyoNight-SE/48x48/status",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('dmenu_run -vi')},
                    padding=0,
                    update_interval=20,
                    ),
                widget.Battery(
                    format="{percent:2.0%}",
                    padding=0,
                    update_interval=20,
                    ),
                widget.Spacer(
                        length=4,
                ),
                widget.Volume(
                    theme_path="~/.icons/TokyoNight-SE/22x22/panel/",
                    #mouse_callbacks add eww here
                    get_volume_command="wpctl get-volume @DEFAULT_SINK@ | awk '/Volume/ {print $2'%'}'",
                    #mute_command="wpctl set-mute @DEFAULT_SINK@ toggle",
                    #volume_down_command="wpctl set-volume @DEFAULT_SINK@ 1%-",
                    #volume_up_command="wpctl set-volume @DEFAULT_SINK@ 1%+",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('pavucontrol')},
                    padding=0
                ),
                widget.Volume(
                    #mouse_callbacks add eww here
                    #get_volume_command='var=$(wpctl get-volume @DEFAULT_SINK@ | cut -d ' ' -f 2); echo $var%%',
                    get_volume_command="var=$(wpctl get-volume @DEFAULT_SINK@ | awk '/Volume/ {print $2}'); echo $var%",
                    mouse_callbacks = {'Button1': lambda: qtile.cmd_spawn('pavucontrol')},
                    foreground=colors[11],
                    padding=0
                ),
                widget.Spacer(
                        length=6,
                ),
                widget.OpenWeather(
                    location="Ohrid, MK",
                    format="{icon}",
                    fontsize=20,
                    padding=0,
                    weather_symbols={
                        "01d": " ",
                        "01n": " ",
                        "02d": " ",
                        "02n": " ",
                        "03d": "󰅣 ",
                        "03n": "󰅣 ",
                        "04d": " ",
                        "04n": " ",
                        "09d": " ",
                        "09n": " ",
                        "10d": " ",
                        "10n": " ",
                        "11d": " ",
                        "11n": " ",
                        "13d": " ",
                        "13n": " ",
                        "50d": " ",
                        "50n": " ",
                        }
                ),
                widget.OpenWeather(
                    location="Ohrid, MK",
                    format="{weather} {temp:.0f}°C",
                    padding=0,
                ),
                 widget.Spacer(
                        length=8,
                ),
                widget.Clock(format="%A, %b %d - %H:%M"),
            ],
            24,
            #border_width = [0,0,0,0],
            #margin = [15,15,0,15],
            border_color = colors[1],
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = False
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(wm_class="viewnior"),
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# xcursor theme (string or None) and size (integer) for Wayland backend
wl_xcursor_theme = None
wl_xcursor_size = 24

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
