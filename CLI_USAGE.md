# Command Line Interface Usage

The Creality Helper Script now supports both interactive menu mode and
command-line interface (CLI) mode.

## Interactive Mode

Run without arguments to start the interactive menu:

```bash
./helper.sh
# or if linked
helper
```

## CLI Mode

### Basic Syntax

```bash
./helper.sh <command> <feature> [options]
```

### Available Commands

#### Install a Feature

```bash
./helper.sh install <feature>
```

Examples:

```bash
./helper.sh install moonraker
./helper.sh install fluidd
./helper.sh install mainsail
./helper.sh install entware
./helper.sh install kamp
./helper.sh install buzzer
```

#### Remove a Feature

```bash
./helper.sh remove <feature>
```

Examples:

```bash
./helper.sh remove moonraker
./helper.sh remove fluidd
./helper.sh remove timelapse
```

#### Check Status

Check status of a specific feature:

```bash
./helper.sh status <feature>
```

Check status of all features:

```bash
./helper.sh status
```

Examples:

```bash
./helper.sh status moonraker
./helper.sh status fluidd
./helper.sh status  # Shows all features
```

#### List Available Features

```bash
./helper.sh list
```

### Available Features

#### Essentials

- `moonraker` - Moonraker and Nginx
- `fluidd` - Fluidd Web Interface
- `mainsail` - Mainsail Web Interface

#### Utilities

- `entware` - Entware Package Manager
- `shell-command` (or `gcode-shell-command`) - Klipper Gcode Shell Command

#### Improvements

- `kamp` - Klipper Adaptive Meshing & Purging
- `buzzer` - Buzzer Support
- `nozzle-cleaning` - Nozzle Cleaning Fan Control
- `fans-control` - Fans Control Macros
- `shapers` (or `improved-shapers`) - Improved Shapers Calibrations
- `macros` (or `useful-macros`) - Useful Macros
- `zoffset` (or `save-zoffset`) - Save Z-Offset Macros
- `screws` (or `screws-tilt-adjust`) - Screws Tilt Adjust Support
- `m600` - M600 Support
- `backup` (or `git-backup`) - Git Backup

#### Camera

- `timelapse` - Moonraker Timelapse
- `camera` (or `camera-settings`) - Camera Settings Control
- `usb-camera` - USB Camera Support

#### Remote Access

- `octoeverywhere` - OctoEverywhere
- `obico` (or `moonraker-obico`) - Moonraker Obico
- `guppyflo` - GuppyFLO
- `mobileraker` - Mobileraker Companion
- `octoapp` - OctoApp Companion
- `simplyprint` - SimplyPrint

#### Other

- `guppy-screen` (or `guppy`) - Guppy Screen (K1 only)

### Feature Aliases

Many features support multiple aliases for convenience:

- `shell-command` = `gcode-shell-command`
- `shapers` = `improved-shapers`
- `macros` = `useful-macros`
- `zoffset` = `save-zoffset`
- `screws` = `screws-tilt-adjust`
- `backup` = `git-backup`
- `camera` = `camera-settings`
- `obico` = `moonraker-obico`
- `guppy` = `guppy-screen`

### Help

Show usage information:

```bash
./helper.sh help
./helper.sh -h
./helper.sh --help
```

## Examples

### Installing Multiple Features

```bash
./helper.sh install entware
./helper.sh install moonraker
./helper.sh install fluidd
./helper.sh install kamp
```

### Checking Installation Status

```bash
# Check all features
./helper.sh status

# Check specific feature
./helper.sh status moonraker
./helper.sh status fluidd
```

### Script Integration

You can use the CLI in scripts for automation:

```bash
#!/bin/sh

# Install essential features
./helper.sh install entware
./helper.sh install moonraker
./helper.sh install fluidd

# Check if installation was successful
if [ "$(./helper.sh status moonraker)" = "moonraker: installed" ]; then
    echo "Moonraker installed successfully!"
fi
```

## Notes

- The CLI mode runs non-interactively (no confirmation prompts)
- All dependency checks and validations are still performed
- Error messages will be displayed if dependencies are missing
- The script will automatically detect your printer model
- Some features may only be available for specific printer models
