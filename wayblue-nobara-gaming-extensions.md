# Wayblue Gaming Extensions

Goal: experiment with selected Nobara gaming components in a Wayblue/Fedora Atomic image without adopting the full Nobara stack.

## 1. Nobara Gamescope

Integrate Nobara's patched `gamescope` package into the image.

- Use Nobara's current Gamescope build/patches rather than replacing the Fedora/Wayblue base.
- Preserve normal Wayland/Sway usage.
- Intended use: Steam/Proton games, likely nested Gamescope and potentially Steam Gamescope session.
- Do not pull in unrelated Nobara desktop/HTPC/handheld packages unless required by the chosen Gamescope setup.
- Compare against the existing Wayblue Gamescope for actual benefits/regressions.

Nobara currently patches Gamescope with larger default resolution support and fixes ported from projects including ChimeraOS and Bazzite.

## 2. falcond

Add Nobara's `falcond` gaming performance daemon.

Goals:

- Automatic detection of running games, including Steam/Proton games.
- Enable performance mode while gaming.
- Restore the previous state when the game exits.
- Keep the initial configuration simple.
- Do **not** run Feral GameMode alongside falcond; they provide overlapping functionality and can conflict.

Initial configuration should **not** select an alternative SCX scheduler. Start with:

```ini
enable_performance_mode = true
scx_sched = none
scx_sched_props = default
vcache_mode = none
profile_mode = none
```

Once the basic setup is working, enable LAVD as a separate experiment.

## 3. scx-scheds / LAVD

Add the SCX scheduler package/tooling required to run `scx_lavd`.

Primary scheduler of interest:

- `scx_lavd`

LAVD is designed around latency-sensitive, communication-heavy workloads such as games and aims to reduce latency spikes while retaining reasonable throughput/fairness.

Experiment progression:

1. Fedora's normal EEVDF scheduler — baseline.
2. `falcond` with performance mode but no SCX scheduler.
3. `falcond` + `scx_lavd`.
4. Compare LAVD gaming mode against the normal scheduler.
5. Only later test other SCX schedulers such as BPFland/Rusty if useful.

Keep the normal Fedora kernel initially. Do not import the full Nobara/CachyOS kernel just to use sched_ext.

## Scope / deliberately deferred

Do **not** initially import:

- Nobara kernel
- Nobara Mesa stack
- Nobara repositories wholesale
- AppArmor/security-stack changes
- Nobara sysctl/udev tweaks
- `ntsync` changes
- USB polling tweaks

These can be investigated independently later if there is a concrete reason.

