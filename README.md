# Creator Studio

**By Twilight Studio** · Version **0.14.0-beta.10** · Linux x64

A native Linux creative workspace where AI agents and manual tools share the same project.
Model in 3D, simulate cloth, format writing, code with an AI agent, drive a live Unity Editor,
edit layered images, and run AI research — all from one desktop application.

> **Using Windows instead?** Download the Windows build here:
> **[CreatorStudio_WindowsOS](https://github.com/Error404-RedRose/CreatorStudio_WindowsOS)**
>
> The Linux and Windows repositories are separate. If you opened this page by mistake,
> the link above takes you to the correct Windows distribution.

> **Quick install:** [Download the one-file Linux installer](https://github.com/Error404-RedRose/CreatorStudio_LinuxOS/releases/latest/download/CreatorStudio-Linux-x64.run)

---

## Install on Linux

### Recommended: one-file installer

This works on every x64 distribution without root access, Git, Git LFS, or a package manager.

1. Open the **[latest Linux release](https://github.com/Error404-RedRose/CreatorStudio_LinuxOS/releases/latest)**.
2. Download **`CreatorStudio-Linux-x64.run`**.
3. Make it executable and run it:

```bash
chmod +x ~/Downloads/CreatorStudio-Linux-x64.run
~/Downloads/CreatorStudio-Linux-x64.run
```

Or mark the file as executable in your file manager and double-click it.

Terminal one-liner instead of downloading the file manually:

```bash
curl -fsSL https://raw.githubusercontent.com/Error404-RedRose/CreatorStudio_LinuxOS/main/install.sh | bash
```

The one-liner downloads the same `.run` installer from the latest release. You can inspect `install.sh` before running it.

The installer:

- installs Creator Studio in `~/.local/opt/creator-studio`
- adds a **Creator Studio** entry to your applications menu
- creates the `creator-studio` command in `~/.local/bin`
- does **not** start a background copy, so it works safely from a terminal or SSH session

No root password or distribution-specific package is required. The same file works on Debian, Ubuntu, Linux Mint, Pop!_OS, Fedora, Arch, openSUSE, NixOS user profiles and other x64 distributions.

Launch Creator Studio from your applications menu, or run:

```bash
creator-studio
```

If `~/.local/bin` is not on your PATH, run `~/.local/opt/creator-studio/creator-studio`.

### Portable archive

Prefer not to install anything? Download **`CreatorStudio-Linux-x64.tar.gz`** from the same release page, extract it anywhere, and run:

```bash
chmod +x creator-studio-launcher creator-studio
./creator-studio-launcher
```

`creator-studio-launcher` automatically falls back to the bundled SwiftShader renderer on NixOS or when `libEGL.so.1` is missing. On a normal desktop with working GPU drivers, running `./creator-studio` directly uses hardware rendering.

Keep the extracted folder intact. The in-app updater replaces that folder in place, so use a writable location such as your home directory.

### Package managers

Creator Studio uses one universal installer because a single package format cannot cover every Linux distribution. The `.run` installer does not require root and creates a normal desktop entry, so it behaves like an installed application. There is no need to add a third-party repository or compile anything.

> **Advanced:** the repository still contains the unpacked build so the in-app updater can replace it. You do not need to clone the repository to install or use Creator Studio.

---

## What gets installed

| Item | Description |
| --- | --- |
| `~/.local/opt/creator-studio/creator-studio` | The application executable. |
| `~/.local/opt/creator-studio/creator-studio-launcher` | Launcher with the software-rendering fallback for NixOS/minimal systems. |
| `~/.local/opt/creator-studio/resources/`, `locales/`, `*.so`, `*.pak` | Required runtime files. Keep them together. |
| `~/.local/share/applications/creator-studio.desktop` | The applications-menu entry. |
| `~/.local/bin/creator-studio` | Terminal launcher. |
| `~/.local/share/icons/hicolor/256x256/apps/creator-studio.png` | Application icon. |

If you use the portable archive instead, keep the extracted folder intact. The executable depends on the shared libraries, `resources.pak`, `locales/`, and the other bundled files beside it.

> This is beta software. Back up important projects and expect interface changes between builds.

---

## System requirements

- **Linux x64** with a recent glibc (Ubuntu 22.04+, Debian 12+, Fedora 38+, or newer recommended)
- **8 GB RAM recommended** (4 GB minimum)
- A GPU and driver with **WebGL 2** support
- **About 1 GB free disk space** for the application, plus room for projects
- **Internet connection** for product activation, AI providers, GitHub, and updates
- **One AI backend**: OpenCode (including Claude models exposed through OpenCode Go/Zen), a local Hermes endpoint, or a Claude-compatible endpoint

The Linux build is unpacked and runs with Chromium's sandbox disabled so it works from any user-owned
folder without root setup. A separate Windows build is available at
**[CreatorStudio_WindowsOS](https://github.com/Error404-RedRose/CreatorStudio_WindowsOS)**.

---

## Run the app

- **One-file installer:** open **Creator Studio** from your applications menu, or run `creator-studio` in a terminal.
- **Portable archive:** run `./creator-studio` from the extracted folder.
- Enter your product key when the activation screen appears.

Creator Studio opens as a proper resizable desktop window with the branded Creator Studio title
bar (Home and window controls) and the applet header underneath. It works on desktop
environments and tiling window managers alike.

Always launch the bundled `creator-studio` executable. Opening the local backend URL in Chrome or
Firefox only shows a browser preview: the browser cannot open native folder dialogs or install
updates. The desktop window is the supported application.

To move the app to another location, copy the **entire folder**, not just the executable. The
in-app updater replaces this folder in place, so keep it in a writable location such as your home
directory. It will refuse to update a read-only folder (for example a NixOS system path) and tell
you where to move it.

### Scale the interface

Open **Settings > Appearance** and use **App scale** to resize the whole interface from 80% to
150%. The setting is saved and applies to panels, dialogs, the launcher and the 3D viewport.
You can also use **Ctrl + =**, **Ctrl + -** and **Ctrl + 0** from any applet. **Text scale** changes
only the workspace text and is useful when the rest of the layout is already comfortable.

For a system-wide scale, use your desktop's display settings:

- **GNOME:** Settings > Displays > Scale
- **KDE Plasma:** System Settings > Display & Monitor > Global Scale
- **XFCE:** Settings > Appearance > Window Scaling

---

## If no window appears

- If an old background copy is stuck, stop it and launch again:

```bash
pkill -f "$HOME/.local/opt/creator-studio/creator-studio" || true
creator-studio
```

- Launch from a terminal to see the Electron output directly:

```bash
$HOME/.local/opt/creator-studio/creator-studio
```

- On Wayland, if the window still does not appear, try:

```bash
$HOME/.local/opt/creator-studio/creator-studio --ozone-platform-hint=auto
```

- On very old GPUs or virtual machines, try:

```bash
$HOME/.local/opt/creator-studio/creator-studio --disable-gpu
```

- On NixOS or minimal systems, the `libEGL.so.1` error is handled automatically by
  `creator-studio-launcher`. The `creator-studio` command and the applications-menu entry already use
  that launcher. To force software rendering explicitly:

```bash
CREATOR_STUDIO_SOFTWARE_GL=1 creator-studio
```

- To force hardware rendering on a system where the automatic detection chose software:

```bash
CREATOR_STUDIO_GPU=1 creator-studio
```

- If the app opens but the 3D, Clothworks or Animator applet reports a WebGL error, try the alternate SwiftShader GL backend:

```bash
CREATOR_STUDIO_GL=swiftshader creator-studio
```

- Electron logs are written to `~/.config/Creator Studio/data/logs/`.

---

## Activation

Creator Studio requires a **product key**.

- Enter the key on the activation screen or in **Settings → License**.
- An internet connection is required to verify the key. The app re-checks it while running.
- A valid key stays unlocked. An expired, revoked, or device-mismatched key returns to the
  activation screen.
- Each key is tied to the device it was first activated on.

Need a key or hit an activation problem? Contact Twilight Studio using the details at the bottom
of this file.

---

## Set up AI (OpenCode, Hermes or Claude)

Creator Studio needs one AI backend. All three choices use the same agents, tools, sessions,
approval flow and per-studio model memory.

- **OpenCode** — install it from [opencode.ai](https://opencode.ai/), then open
  **Settings → OpenCode**. Creator Studio can provision a compatible 1.x runtime automatically.
- **Hermes** — install Hermes from
  [hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com/). Creator Studio reads
  Hermes's authenticated model providers directly (including the BlitzBoy models and Nous free
  when its token is valid), so OpenCode's tools and approvals work normally. If Hermes is installed
  but not signed in, open **Settings → AI backends** and configure it there.
- **Claude** — install Claude from [claude.com/download](https://claude.com/download). Claude Code and
  Claude Desktop are agents, not local model servers: they do not expose an HTTP model endpoint by
  themselves. Run a Claude-compatible proxy, or enter the proxy URL in **Settings → AI backends**.
  Creator Studio scans local ports and auto-fills a running Claude proxy when it finds one.

Use **Test endpoint**, then **Save & reconnect agents**. The header model menu follows the active
backend and shows only that backend's models. Auto-connect uses whichever backend you saved.

When Ollama is running on this PC, Creator Studio also adds an **Ollama (local)** provider with
every installed model. OpenCode Zen, OpenCode Go and Ollama Cloud models stay in the same model
menu, so you can switch between free Zen models, Go models and local models without leaving the app.

**Each workspace remembers its own model.** The model you select for Writing is used for Writing;
the model you select for Coding is used for Coding, and so on. Choose models with tool calling
support for 3D scene editing, coding, and GitHub actions.

You can also configure provider API keys for OpenAI and Gemini in **Settings → Providers** if you
want those providers in Research or Photo.

### Linux microphone engine

The voice feature installs itself automatically on first launch. Creator Studio downloads a
private Python 3.11 runtime into `~/Documents/3D Creator Studio/speech-runtime` and creates its own
speech environment in `~/Documents/3D Creator Studio/speech-venv`. No system Python, `pip`,
PortAudio or distribution package is required. It survives app updates, so it only has to be
installed once.

Linux capture uses PulseAudio/PipeWire through `soundcard`, which is available on every normal
desktop, including NixOS. If a native `wtype`, `ydotool` or `xdotool` typing tool is unavailable,
the finished transcript is inserted directly into the focused Creator Studio text field instead of
being lost. On Wayland, install `wtype` if you also want dictation to type into other applications.

---

## Workspaces

### 3D Studio
Real-time modeling with object and mesh modes, move/rotate/scale gizmos, rectangle and pen tools,
vertex editing, measurement, decimation, smooth/flat shading, and scene presets. Import FBX, GLB,
GLTF, and OBJ; export GLB, OBJ, STL, and FBX. Materials include full PBR maps, procedural
patterns, a Material Lab, UV generation, and a stretch-colored UV viewer. Rigging, blend shapes,
lighting, cameras, and six viewport modes are included.

### Clothworks
A real-time cloth simulator with Curtain, Blanket, Towel, and Pillow presets. Adjust gravity,
wind, stiffness, and damping; switch between sphere and box colliders; toggle wireframe; pause,
play, or reset the simulation.

### Writing
Paste raw text and press **Format** (or `Ctrl`+`Enter`). The app starts a fresh AI session, shows
live progress and elapsed time, and returns clean professional text. **Copy** places rich HTML and
plain text on the clipboard so headings, lists, bold, and links survive when pasted into email or
a document. **Cancel** stops a slow run immediately.

### Coding
A file tree, tabbed editor, dirty-state tracking, search, image attachments, and persistent
sessions. The AI view streams file edits with added/removed line highlights, command output, and
up to four concurrent agent panels. **Follow AI edits** jumps to each completed write. Writes and
commands stay disabled until you explicitly trust the project.

### Unity Live
Connect to an open Unity Editor project. The app shows the project, active scene, and a filterable
hierarchy; focuses objects on double-click; surfaces compile and scene messages; and can refresh
assets, request script compilation, and enter or exit play mode. Install the bundled bridge from
`resources/app/unity/com.twilightstudio.creatorstudio` using **Package Manager → + → Add package
from disk…** (Unity 2021.3 or newer). The bridge listens on loopback only.

### Photo
Layered canvas editing with brush, eraser, rectangle, ellipse, and text. Add, duplicate, reorder,
hide, and blend layers. Import images, save layered `.creatorstudio.json` documents, and export
flattened PNG, JPEG, or WebP. AI output arrives as a new SVG layer instead of replacing the canvas.

### Research
Chat with OpenCode, Hermes, Claude, OpenAI, or Gemini. Search the web through DuckDuckGo, add
results to project references in one click, and optionally include GitHub repository and code
matches as research context for every prompt.

---

## GitHub (optional)

Connect a **fine-grained personal access token** in **Settings → GitHub**.

- The token is stored locally and redacted from logs.
- Browse repositories, branches, and file trees; read files; search code and repositories.
- Create repositories, commit and push text files, and open issues or pull requests.
- Add search matches to the reference library.

Enable **Search GitHub with every prompt** to give the AI related public repositories and code as
context. Binary assets and very large batches should be downloaded rather than pushed; keep
individual pushed files under 25 MB and batches under 50 MB.

---

## Your data

| Data | Location |
| --- | --- |
| Settings, logs, mods, references | `~/Documents/3D Creator Studio` |
| Projects | `~/Documents/3D Creator Studio Projects` |

The project folder is configurable in Settings. Open **Settings → Diagnostics** to browse logs,
open the exact log folder, or download the current log. Logs are JSONL and have API keys and
tokens redacted.

Back up `~/Documents/3D Creator Studio` if you want to keep your settings, references, and learning
notes. Projects should be backed up separately.

---

## Updates

Creator Studio checks the **CreatorStudio_LinuxOS** GitHub repository for a newer published version
when the app starts and whenever **Settings → Updates** is opened. That tab shows the installed
version, the published version, the exact repository being checked, the last check time and the
latest release notes. On Windows the same tab checks **CreatorStudio_WindowsOS**.

The Linux updater downloads the new unpacked build, restores any Git LFS files, verifies the
version and folder layout, keeps a backup named `Creator Studio backup <timestamp>` beside the
application folder, swaps the files and relaunches Creator Studio through `creator-studio-launcher`
so the software-rendering/WebGL environment is preserved. On systemd desktops it runs as a
transient **systemd user service**, which keeps it alive after Creator Studio closes. Update
activity is logged to `~/.local/state/creator-studio/update.log`, and a failed attempt is shown in
Settings > Updates with that log path.

Press **Update now** on the home banner or in Settings → Updates. You do not need to visit GitHub
or run any commands. The application folder must be writable; Creator Studio detects read-only
locations (such as NixOS system folders) and tells you to move the folder into your home directory.

The current release is **0.14.0-beta.10**. If an older beta.4 or beta.5 installation does not offer the
update, install the new `CreatorStudio-Linux-x64.run` once. After that, future releases can be
installed from Settings → Updates.

---

## Troubleshooting

**The app does not open**
- Confirm the executable is still inside this folder with its shared libraries, `resources`, and `locales`.
- Re-extract or re-copy the complete build if files were moved or deleted.
- Run `chmod +x creator-studio chrome-sandbox chrome_crashpad_handler`.
- Start it from a terminal to see the exact library error: `./creator-studio`.

**The updater stops or the folder is not replaced**
- Check `~/.local/state/creator-studio/update.log`.
- Close any file manager or terminal that is sitting inside the application folder.
- Keep the `Creator Studio backup <timestamp>` folder; it is the previous working build.
- If the app says the folder is not writable, move the entire Creator Studio folder into your
  home directory (for example `~/Creator Studio`) and press Update again. NixOS system paths and
  other read-only locations cannot be updated in place.

**The voice engine is still installing**
- First launch downloads the private speech runtime and packages once in the background. This can
  take several minutes on a slower connection.
- Creator Studio does not need system Python, `pip` or PortAudio. If the runtime download is blocked
  by a firewall, allow `github.com` and retry from **Settings > Microphone**.
- If capture still fails, check that PipeWire or PulseAudio is running and that the microphone is
  visible in your desktop sound settings.

**Blank or black window**
- Update your graphics driver.
- Close other GPU-heavy applications.
- If the problem persists, report it with the log file attached.

**AI is offline or no models appear**
- Confirm OpenCode, Hermes or Claude is installed and its local endpoint is running.
- For OpenCode, check the executable path in **Settings → OpenCode**.
- For Hermes or Claude, check **Settings → AI backends**, press **Test endpoint**, and confirm the
  selected backend has a model id and the correct OpenAI/Anthropic API style.
- Use **Test connection** and review the activity console for the exact error.

**AI requests time out**
- Choose a faster model for that workspace. Model choice is saved per workspace.
- Some free or remote models are slow or queue heavily; try another provider.
- In Writing, press **Cancel** and retry with a different model.

**Unity project is not detected**
- Install the bridge package from `resources/app/unity/com.twilightstudio.creatorstudio`.
- Confirm the bridge is running in Unity under **Creator Studio → Unity Bridge**.
- Allow loopback traffic for `127.0.0.1` ports `47823–47843` in your firewall.
- Unity must be open with the project loaded; the bridge does not run in built players.

**Activation fails**
- Confirm the PC is online.
- Check the key for typos and confirm it has not expired or been activated on another device.
- Contact Twilight Studio if the key should be valid.

---

## Uninstall

1. Close Creator Studio.
2. Remove the application:
   - **One-file installer:**
     ```bash
     rm -rf ~/.local/opt/creator-studio
     rm -f ~/.local/bin/creator-studio
     rm -f ~/.local/share/applications/creator-studio.desktop
     rm -f ~/.local/share/icons/hicolor/256x256/apps/creator-studio.png
     ```
   - **Portable archive:** delete the extracted folder.
3. Optional: delete `~/Documents/3D Creator Studio` to remove settings, references, logs, and local
   AI history. This also removes your saved API keys and activation state.
4. Optional: delete `~/.config/Creator Studio` if you want no residual Electron cache.

Back up projects before deleting any data folder.

---

## Third-party components

This application includes open-source and third-party components, including **Electron**,
**Chromium**, **Node.js**, **React**, **Three.js**, **Express**, **adm-zip**, and **Zustand**.

- Electron and Chromium license texts ship alongside the executable
  (`LICENSE.electron.txt` and `LICENSES.chromium.html`).
- Other components retain their own licenses and copyright notices.

Nothing in the Creator Studio license restricts rights granted to you by those component
licenses.

---

## License

Creator Studio is proprietary software by Twilight Studio. Use is governed by `LICENSE.txt` in
this folder. A valid product key is required to run the application.

---

## Support

**Twilight Studio**

- Discord: [discord.gg/V2vDQCUSNe](https://discord.gg/V2vDQCUSNe)
- Email: [twilightstudio.dev@gmail.com](mailto:twilightstudio.dev@gmail.com)
- Website: [twilightstudio.carrd.co](https://twilightstudio.carrd.co/)

When reporting a problem, include the app version, your Linux distribution, a short description,
and the relevant log lines from **Settings → Diagnostics**. Remove any personal information before
sharing.

© 2026 Twilight Studio. All rights reserved.

---

**Other platform:** [Creator Studio for Windows](https://github.com/Error404-RedRose/CreatorStudio_WindowsOS)
