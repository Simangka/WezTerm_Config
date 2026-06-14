# WezTerm Config — sci-fi hacker edition

## Files

| File | Purpose |
|---|---|
| `%USERPROFILE%\.wezterm.lua` | Main config — colors, keys, tab bar, right status, background images |
| `%USERPROFILE%\.config\wezterm\neofetch.ps1` | Fast PowerShell neofetch (registry + WMI, ~0.5s) |
| `%USERPROFILE%\.config\wezterm\neofetch.bat` | Batch launcher for cmd |
| `%USERPROFILE%\.config\wezterm\images\*.jpg` | Background images for cycling |
| `%USERPROFILE%\.config\wezterm\README.md` | This file |
| PowerShell profile | Sources `neofetch` function and sets `$env:ZBRAND` |

## Branding

The brand name (your Windows username by default) appears in three places:

1. **Right status** — `< brand >` in gold
2. **Tab badge** — first letter of brand in gold/dark badge
3. **neofetch header** — brand letters spelled out with color cycle

### Override the brand name

**Option A — hardcode in WezTerm config** (quickest):

Edit `%USERPROFILE%\.wezterm.lua`, line 4:

```lua
local BRAND = "yourname"
```

Then `Ctrl+Shift+R` to reload.

**Option B — system env var** (affects everything permanently):

- Search "Edit environment variables" in Start
- Add a new user variable `ZBRAND` with your desired name
- Restart WezTerm fully

**Option C — PowerShell profile only**:

```powershell
$env:ZBRAND = "yourname"
```

## Background Images

WezTerm loads a random image from `%USERPROFILE%\.config\wezterm\images\` at startup as the terminal background.

### Image cycling

| Action | Key |
|---|---|
| Cycle to next image | `Alt+/` |
| Random image on startup | Automatic |
| New images per tab/window | Random each time config loads |

### Configuration

Edit the `BG` block in `%USERPROFILE%\.wezterm.lua` (lines 7-11):

```lua
local BG = {
    enabled = true,         -- set false to disable background images
    auto_cycle = false,     -- auto-rotate images (off by default)
    cycle_interval = 300,   -- seconds between auto-cycles
}
```

- **`enabled`** — `false` hides background images entirely at startup.
- **`auto_cycle`** — `true` automatically rotates images every `cycle_interval` seconds.
- **`cycle_interval`** — seconds between auto-rotations (default 300 = 5 min).

`Alt+/` always works to cycle the background, even when `enabled = false`.

### Adding your own images

Drop `.jpg`, `.jpeg`, `.png`, `.bmp`, or `.gif` files into:
```
%USERPROFILE%\.config\wezterm\images\
```
Then reload with `Ctrl+Shift+R`.

### Background opacity

Edit the `opacity` value in two places (startup image + cycle override):

- Line 63: `opacity = 0.3` (startup image)
- Line 213: `opacity = 0.3` (cycle override)

Higher = more visible, lower = more transparent/Acrylic shows through.

## Usage

### neofetch

Run `neofetch` in PowerShell or cmd to display system info.

### Keyboard shortcuts

| Keys | Action |
|---|---|
| `Alt+H` | Split horizontally |
| `Alt+V` | Split vertically |
| `Alt+/` | Cycle background image |
| `Ctrl+Shift+W` | Close current pane |
| `Ctrl+Shift+{H,J,K,L}` | Navigate panes (left/down/up/right) |
| `Ctrl+Shift+{H,J,K,L}` (uppercase) | Resize pane by 5 |
| `Ctrl+Shift+T` | New tab |
| `Ctrl+Tab` / `Ctrl+Shift+Tab` | Next/prev tab |
| `Alt+N` / `Alt+P` | Next/prev tab |
| `Ctrl+Shift+C` / `Ctrl+Shift+V` | Copy / paste |
| `Ctrl+Shift+R` | Reload config |
| `Ctrl+Shift+F` | Search |
| `Ctrl+Shift+Space` | Quick select |

## Window Borders

A matching sci-fi border wraps the terminal window. Edit the `BORDER` block in `%USERPROFILE%\.wezterm.lua`:

```lua
local BORDER = {
    enabled = true,         -- set false to disable window borders
    width = "1cell",        -- left/right border thickness
    height = "0.25cell",    -- top/bottom border thickness
    side_color = "#3b4261", -- muted blue-gray (visible against dark bg)
    top_color = "#e0af68",  -- gold (matches "LET'S BUILD")
    bottom_color = "#f7768e", -- coral (matches `< >`)
}
```

- **`enabled`** — `false` removes all window borders.
- **`width`** / **`height`** — border thickness in cell units or pixels (e.g. `"2px"`).
- **`side_color`**, **`top_color`**, **`bottom_color`** — border colors to match the banner.

Reload with `Ctrl+Shift+R` after changes.

### Customization

- **Colors** — edit the `config.colors` table in `.wezterm.lua`
- **Font** — add/remove entries in `config.font` fallback list
- **Window opacity** — change `config.window_background_opacity`
- **Acrylic blur** — set `config.win32_system_backdrop` to `"Acrylic"` or `"Mica"`
- **Window borders** — edit the `BORDER` block (see above)
- **neofetch box width** — edit `$boxW = 48` in `neofetch.ps1`

Reload config with `Ctrl+Shift+R` after editing `.wezterm.lua`.
