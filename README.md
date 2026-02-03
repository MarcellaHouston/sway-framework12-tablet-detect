# Sway Framework Laptop 12 Tablet Detector
Automatically flip your display 180° when in tabletop mode.

### Features
- When lid is at an acute angle, keep display at 0°
- When lid is at an obtuse angle, keep display at 180°
- When lid is fully opened in tablet mode, keep display at 0°
- Forbids >1 process from running it just in case you accidentally run it again

### Installation
- Put tablet-detect.sh anywhere
- Put `exec_always /path/to/tablet-detect.sh` in your `~/.config/sway/config`
- Reload Sway (`Super+Shift+c` by default)

### Notes
- You can trade responsiveness & stability by changing the `REQUIRED_HITS` variable
- You can change the thresholds for flipping by changing the `TABLETIN`, `TABLETOPIN`, and `TABLETOPOUT` variables
- Core logic could be extended to non-Sway or non-Framework systems by modifying the `ANGLE_FILE` varible and `swaymsg` statements
