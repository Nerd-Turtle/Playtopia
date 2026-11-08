# Small milestones and honest platform support

## 0.1: Desktop playground
A single offline scene with grass, a small house, a third-person character, jumping,
a blue door and an interaction prompt. Standard GDScript, primitive meshes and the
Compatibility renderer keep the starting workload modest for the Windows 11 HP
Pavilion Plus Ryzen / 16 GB target. Frame rate still needs measuring on the actual
laptop; no performance target is certified by this scaffold.

Done means: import cleanly, run the automated gameplay check, and play the scene
with F5. There is no login, multiplayer, saved progress or avatar customization yet.

## Architecture
The desktop adapter translates InputMap actions into movement/jump/interaction intentions.
The desktop CharacterBody3D handles motion and asks the nearest interactable to act.
The door owns proximity, animation and collision and never reads keys.
The HUD displays the door's prompt. The world scene instances the desktop player.

For later platforms, instance a different player in a separate entry scene, or choose
one with an explicit platform bootstrap. Reuse the house and interaction logic.
Some interaction API and movement changes will still be needed, especially for XR
hands, reach, collision and comfort. This separation reduces coupling; it is not a
guarantee that one export will work everywhere.

## Suggested order
1. Let the child choose colors and a yard decoration. Keep a working desktop checkpoint.
2. Add one more offline interaction, such as sitting on a bench.
3. Try Android tablet controls: touch movement and a large interaction button.
4. Build a separate Quest XR rig with comfort choices, OpenXR actions and headset testing.
5. Export/test iPad using the adult's Mac and Xcode.
6. Discuss multiplayer separately, including adult-controlled access and moderation.

The order of tablet vs Quest work can follow the devices available and the child's interest.

## Device gates

| Target | Additional work before claiming support |
| --- | --- |
| Windows PC | Test the actual laptop GPU, readability and controls; add matching export templates and a Windows export preset for an executable. F5 does not require export templates. |
| Android tablet | Install/configure supported JDK/Android SDK and matching export templates; add touch UI, tablet layout and signing configuration; test real device OS/GPU combinations. |
| Standalone Quest | Enable developer deployment with the adult, configure Android/OpenXR export, a separate tracked rig, input action map and comfort design. Evaluate the OpenXR Vendors plugin for the chosen Godot/headset version. Measure frame time on the actual headset. |
| iPad | Export from macOS with Xcode and matching templates; configure adult-managed Apple signing/provisioning, touch controls, layout and on-device testing. Windows alone cannot produce/test the native iPad app. |

No export presets, SDKs, plugins or signing credentials are included.
When export work starts, check the docs for the exact installed engine version.
Never commit signing keys or credentials.

Sources checked during setup:
- [Android export](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
- [Godot Android XR deployment](https://docs.godotengine.org/en/stable/tutorials/xr/deploying_to_android.html):
  Compatibility is the initial Android XR recommendation; evaluate again on the actual hardware.
- [OpenXR Vendors installation](https://godotvr.github.io/godot_openxr_vendors/getting-started/installation.html)
- [iOS/iPad export](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_ios.html):
  macOS and Xcode are required.
