# Creator Studio

**By Twilight Studio** · Version **0.14.0-beta.3** · Linux x64

A native Linux creative workspace where AI agents and manual tools share the same project.
Model in 3D, simulate cloth, format writing, code with an AI agent, drive a live Unity Editor,
edit layered images, and run AI research — all from one desktop application.

> **Using Windows instead?** Download the Windows build here:
> **[CreatorStudio_WindowsOS](https://github.com/Error404-RedRose/CreatorStudio_WindowsOS)**
>
> The Linux and Windows repositories are separate. If you opened this page by mistake,
> the link above takes you to the correct Windows distribution.

---

## Downloading and installing from GitHub

The main executable is stored with **Git LFS** because it is larger than GitHub's
100 MB file limit. A plain ZIP download contains a small **pointer file** instead of
the real program, so use one of these methods.

### Recommended: clone with Git LFS

```text
git lfs install
git clone https://github.com/Error404-RedRose/CreatorStudio_LinuxOS.git
cd CreatorStudio_LinuxOS
git lfs pull
chmod +x creator-studio
./creator-studio
```

If the executable is still a small pointer file, run **`./install.sh`**. It detects the pointer,
downloads the real binary from GitHub's LFS media endpoint, verifies its size, marks the Electron
helpers executable, and starts Creator Studio.

### ZIP download

1. Download the repository as a ZIP and extract it completely.
2. Open a terminal in the extracted folder.
3. Run **`./install.sh`**.
4. The installer restores the complete executable and starts Creator Studio.

`install.sh` uses `git clone` plus `git lfs pull` when Git is installed. If Git is missing, it uses
`curl` or `wget` to download the executable directly, so no developer tools are required.

### Manual: single executable

Open `creator-studio` on GitHub and use **Download** on the file page. Keep it in the same folder
as the rest of the release files, then run:

```text
chmod +x creator-studio chrome-sandbox chrome_crashpad_handler install.sh
./creator-studio
```

---

## What's in this folder

| Item | Description |
| --- | --- |
| `creator-studio` | The application. Run it from this folder. |
| `install.sh` | Restores the full executable when the repository was downloaded as a ZIP. |
| `resources/`, `locales/`, `*.so`, `*.pak`, `*.bin` | Required runtime files. Do not move or delete them. |
| `README.md` | This document. |
| `LICENSE.txt` | License terms for Creator Studio. |
| `LICENSE.electron.txt`, `LICENSES.chromium.html` | Third-party license notices. |

Keep this folder intact. The executable depends on the shared libraries, `resources.pak`, `locales/`,
and the other bundled files beside it — the app will not start if files are separated or moved out.

> This is beta software. Back up important projects and expect interface changes between builds.

---

## System requirements

- **Linux x64** with a recent glibc (Ubuntu 22.04+, Debian 12+, Fedora 38+, or newer recommended)
- **8 GB RAM recommended** (4 GB minimum)
- A GPU and driver with **WebGL 2** support
- **About 1 GB free disk space** for the application, plus room for projects
- **Internet connection** for product activation, AI providers, GitHub, and updates
- **One AI backend**: OpenCode, a local Hermes endpoint, or a local Claude-compatible endpoint

The Linux build is unpacked and runs with Chromium's sandbox disabled so it works from any user-owned
folder without root setup. A separate Windows build is available at
**[CreatorStudio_WindowsOS](https://github.com/Error404-RedRose/CreatorStudio_WindowsOS)**.

---

## Run the app

1. If `creator-studio` is only a small pointer file, run `./install.sh` first.
2. Run `./creator-studio` from this folder.
3. Enter your product key when the activation screen appears.

To move the app to another location, copy the **entire folder**, not just the executable.

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
  [hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com/), start its local
  OpenAI-compatible endpoint, then open **Settings → AI backends**, enable Hermes, and enter the
  endpoint URL and model id.
- **Claude** — install Claude from [claude.com/download](https://claude.com/download), start a
  local Claude or Claude-compatible endpoint, then open **Settings → AI backends**, enable Claude,
  choose OpenAI or Anthropic API style, and enter the endpoint URL and model id.

Use **Test endpoint**, then **Save & reconnect agents**. The header model menu follows the active
backend and shows only that backend's models. Auto-connect uses whichever backend you saved.

**Each workspace remembers its own model.** The model you select for Writing is used for Writing;
the model you select for Coding is used for Coding, and so on. Choose models with tool calling
support for 3D scene editing, coding, and GitHub actions.

You can also configure provider API keys for OpenAI and Gemini in **Settings → Providers** if you
want those providers in Research or Photo.

### Optional Linux microphone engine

The voice feature uses Python 3 and the bundled speech scripts. Run once:

```text
tools/speech/setup.sh
```

Restart Creator Studio afterwards. The app falls back to `python3` when a local virtual environment
is not present.

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

Creator Studio checks the **CreatorStudio_LinuxOS** repository for a newer published version.
When an update is available, the home page shows an update banner and **Settings → Updates** shows
the release notes.

The Linux updater downloads the new unpacked build, restores any Git LFS files, verifies the
version and folder layout, keeps a backup named `Creator Studio backup <timestamp>` beside the
application folder, swaps the files and relaunches Creator Studio automatically. Update activity is
logged to `~/.local/state/creator-studio/update.log`.

Windows releases come from **CreatorStudio_WindowsOS** and use the Windows updater. If you installed
the wrong platform, use the opposite-distribution link at the top of this file.

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
2. Delete this application folder.
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
