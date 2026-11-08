# Playtopia

A tiny, offline 3D playground made with **Godot 4 and GDScript**.
First goal: walk around a grassy yard, jump, and open a house door.

The child directs the creative ideas and uses Godot. The adult operates ChatGPT/Codex,
GitHub, account sign-ins, approvals, and uploads. The repository is **public**, explicitly
approved by the adult owner `Nerd-Turtle`. Do not create a GitHub account for the child or share
the adult's login. [GitHub account requirements](https://docs.github.com/en/site-policy/github-terms/github-terms-of-service#3-account-requirements).

## Open and play (Windows 11)

1. Keep the entire `playtopia` folder together. Open **Godot 4 standard**, not Godot 3.
   This project was checked with **4.7.2.stable.official.ed1daf0bf** from the existing download.
   No .NET SDK, asset packs, plugins, or export templates are needed to play in the editor.
2. In Godot's Project Manager, choose **Import**, browse to this folder's `project.godot`,
   and choose **Import & Edit**. Opening the file directly also works if its association is configured.
3. Allow the first import to finish. Press **F5** (Run Project).
4. Click inside the game view if keys do not respond.

| Key | Action |
| --- | --- |
| W / A / S / D | Walk forward / left / back / right |
| Space | Jump |
| E | Open or close the door when nearby |
| R | Return to the starting spot |
| F8 in the editor | Stop the game |

The camera follows the player from behind and above. The house has a partial roof so
you can see inside. There is no mouse capture. The editor's 3D view shows the actual
house, yard, player and trees, so they can be selected and moved visually.

**First play checklist:** walk toward the blue door, try walking through it while
closed, press E to open it, enter the house, turn back and close it, jump, then press R.
Walking off the edge returns you home. Verify the HUD text is readable.

### Where is Godot?

At setup, Godot was not on PATH. Your installed console executable was later found at
`C:\dev\Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64_console.exe`.
The regular editor EXE is beside it. Both report the same 4.7.2 version.
The existing ZIP was in the adult's Downloads folder.
A working copy was extracted into this chat workspace's `work\godot` for validation.
You may run that copy or extract your ZIP to a permanent tools folder. Keep both EXEs
together. Use the console EXE for terminal checks; use the regular EXE for the editor.
The project does not depend on that location.

## A simple family workflow

1. Open this folder as a local project in ChatGPT Desktop/Codex using **Add new project**
   or **Ctrl+O**. Select the folder containing `AGENTS.md` and `project.godot`.
   Keep sandbox protections enabled. [Official Windows app guidance](https://learn.chatgpt.com/docs/app/windows).
2. The adult enters one small request based on the child's idea. Example:
   "Read AGENTS.md. Make the house peach and the door purple. Keep the controls working."
3. Review the changed files. Run the checks below, then play with F5 in Godot.
4. The child decides whether the result matches her idea. Make one small adjustment at a time.
5. The adult commits a working checkpoint and pushes to the repository.

Godot includes a GDScript editor; a separate coding editor is optional.
An ordinary planning chat or a connected GitHub account alone does not guarantee local file access:
use the local project workflow shown above.

## Project map

```text
project.godot                 game settings, input actions, main scene
AGENTS.md                     instructions for coding helpers
scenes/world/                 editable neighborhood scene
scenes/interactions/          reusable door scene
scenes/ui/                    light HUD and instructions
players/desktop/              keyboard adapter, character, fixed follow camera
players/touch/                notes for a later touch controller
players/xr/                   notes for a later XR rig
scripts/interactions/         shared door behavior
scripts/ui/                   nearby interaction prompt
assets/                       future original/licensed art and sound
docs/                         scope, platform plan, setup status
tests/smoke_test.gd            automated gameplay check
```

Start with `scenes/world/neighborhood.tscn` to change the yard or house.
`walk_speed` in the player Inspector changes walking speed.
Avoid renaming files until you are comfortable updating scene references.

## Test from PowerShell

Open a terminal **in this playtopia folder**. Set the console EXE path to your actual copy:

```powershell
$godotExe = 'C:\dev\Godot_v4.7.2-stable_win64.exe\Godot_v4.7.2-stable_win64_console.exe'
& $godotExe --version
& $godotExe --headless --path . --editor --import --quit
& $godotExe --headless --path . --script res://tests/smoke_test.gd
```

Expect an exit code of 0, no `SCRIPT ERROR` / `ERROR` messages, and
`Playtopia smoke test: 0 failure(s)`. The smoke test uses real physics and keyboard
actions to check movement, jump/landing, closed-door blocking, opening, entering,
closing, interaction range, R reset, and fall recovery. It does not check graphics,
comfort, exported builds, or real devices. Run F5 as well.

## Git checkpoint (adult)

Git was available in the Codex runtime at setup; a regular PowerShell window may need
[Git for Windows](https://git-scm.com/downloads/win) installed. Check `git --version`.
GitHub CLI was not detected and is optional.

This delivery initializes a local repository on `main`. Check the state first:

```powershell
git status
git log -1 --oneline
git remote -v
```

For a fresh copy without a `.git` directory, run `git init -b main` once.
For a ZIP copy, the Git history is not included. Use the adult's repository-local identity
below (or a different verified adult identity); do not put the child's name/email in commits.

```powershell
git config --local user.name "Nerd-Turtle"
git config --local user.email "186396874+Nerd-Turtle@users.noreply.github.com"
git diff
git add .
git diff --cached --stat
git commit -m "Create Playtopia desktop playground"
```

If the initial commit already exists and the tree is clean, skip that commit command.
For later changes use a short description such as `"Change house colors"`.
Review staged content for personal information or credentials before each commit.

The Godot cache `.godot/`, builds and signing files are ignored. Track the source
`.gd`, `.tscn`, `project.godot`, `.uid` and source `.import` sidecars.
[Godot version control guidance](https://docs.godotengine.org/en/stable/tutorials/best_practices/version_control_systems.html).

## Connect the GitHub repository (adult)

Repository: [Nerd-Turtle/Playtopia](https://github.com/Nerd-Turtle/Playtopia).
The adult confirmed account ownership and explicitly approved its public visibility.
The adult handles authentication and uploads. Keep personal details and credentials out
of the source files and commit history.

On another computer, clone the existing repository, then import its project.godot in Godot:

```powershell
git clone https://github.com/Nerd-Turtle/Playtopia.git
cd Playtopia
```

For an existing local repository with a first commit, inspect its remotes before connecting:

```powershell
git remote -v
git remote add origin https://github.com/Nerd-Turtle/Playtopia.git
git remote -v
git push -u origin main
```

Run `remote add` only if no `origin` exists. If one already exists, inspect it before
changing anything. Authenticate as the adult in the sign-in prompt; do not paste tokens
into chat or save them in the project. A GitHub password is not a Git HTTPS credential.
If sign-in support is missing, install Git for Windows or use GitHub Desktop as the adult.

If a push is rejected because the remote has commits, stop and inspect the remote history.
Do not force-push. Ask Codex to help combine the histories safely.

After uploading, refresh GitHub and confirm `project.godot`, `AGENTS.md`, scenes and scripts
are present; confirm `.godot` and credentials are absent.
If needed, grant the ChatGPT/Codex GitHub connection access to **only this repository**.
   Local Git authentication and connector access are separate.

For subsequent adult-approved backups:

```powershell
git status
git add .
git diff --cached
git commit -m "Describe the small working change"
git push
```

## Later platforms

This is a **desktop prototype**, not a Quest/Android/iPad release.
See [the platform plan](docs/platform-plan.md) for the shared architecture and device gates.
No networking, accounts, chat, purchases, analytics or cloud services are included.
