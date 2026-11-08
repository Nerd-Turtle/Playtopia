# Helping with Playtopia

Playtopia is a beginner's Godot 4 / GDScript game. The child owns the creative choices;
the adult operates AI tools, GitHub and account actions. Explain changes in short,
friendly sentences: what changed, where to find it, and how to try it.

## Keep the first game small
- Preserve the working desktop yard, character, jump and door.
- Make one requested feature at a time. Ask about creative choices when needed.
- Use standard Godot nodes and typed GDScript where helpful. No C# or native dependencies.
- Prefer editable scenes and small reusable scripts. Do not rewrite working systems
  or add frameworks, plugins, networking or asset downloads without a concrete need.
- Keep art original or licensed. Record outside asset sources.

## Shared gameplay, different players
- Desktop key reads belong in players/desktop/desktop_input.gd.
- Shared interactions receive an actor position and expose get_prompt/interact;
  do not put keyboard, touch or headset APIs in the door.
- Future touch and XR players are separate adapters/rigs, sharing world interactions.
  They are not implemented yet. Do not claim device support without real device tests.
- Keep Compatibility rendering as the desktop baseline. Treat a renderer change,
  new XR plugin or export preset as a separate tested task.
- No hard-coded Windows paths in runtime scripts. Use res:// and user://.
- Keep scenes simple for integrated graphics. Measure before adding costly effects.

## Check each change
- Read README.md and relevant scene/script files first.
- Import with Godot: --headless --path . --editor --import --quit.
- For gameplay changes run: --headless --path . --script res://tests/smoke_test.gd.
- Inspect logs as well as exit codes. State clearly when Godot or a device test
  was unavailable. Do not describe unperformed checks as passed.
- Ask the adult to play with F5 after visible/control changes if you cannot do it.
- Preserve .uid and source .import sidecars. Never commit .godot, exports, keys or secrets.
- Report what changed, the tests performed, and any remaining limitations.

## Adult-managed project
- Repository target: Nerd-Turtle/Playtopia. The adult explicitly approved public
  visibility on November 8, 2026. Do not change visibility without their instruction.
- The adult confirmed that Nerd-Turtle is their account. Keep Git identity local
  to this project. Do not use the child's name, age, email, school or photos.
- Ask the adult before signing in, installing software, creating a remote repository,
  pushing changes, publishing, spending money or enabling a service, unless they
  already authorized that exact action in the current session.
- Do not share credentials or create a child account.
- Do not delete history, force-push, change global Git settings or undo someone else's work.
