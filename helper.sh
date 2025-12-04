#!/bin/sh

set -e
clear

HELPER_SCRIPT_FOLDER="$(dirname "$(readlink -f "$0")")"
for script in "${HELPER_SCRIPT_FOLDER}/scripts/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/K1/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/3V3/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/3KE/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/10SE/"*.sh; do . "${script}"; done
for script in "${HELPER_SCRIPT_FOLDER}/scripts/menu/E5M/"*.sh; do . "${script}"; done

function update_helper_script() {
  echo -e "${white}"
  echo -e "Info: Updating Creality Helper Script..."
  cd "${HELPER_SCRIPT_FOLDER}"
  git reset --hard && git pull
  ok_msg "Creality Helper Script has been updated!"
  echo -e "   ${green}Please restart script to load the new version.${white}"
  echo
  exit 0
}

function update_available() {
  [[ ! -d "${HELPER_SCRIPT_FOLDER}/.git" ]] && return
  local remote current
  cd "${HELPER_SCRIPT_FOLDER}"
  ! git branch -a | grep -q "\* main" && return
  git fetch -q > /dev/null 2>&1
  remote=$(git rev-parse --short=8 FETCH_HEAD)
  current=$(git rev-parse --short=8 HEAD)
  if [[ ${remote} != "${current}" ]]; then
    echo "true"
  fi
}

function update_menu() {
  local update_available=$(update_available)
  if [[ "$update_available" == "true" ]]; then
    top_line
    title "A new script version is available!" "${green}"
    inner_line
    hr
    echo -e " │ ${cyan}It's recommended to keep script up to date. Updates usually    ${white}│"
    echo -e " │ ${cyan}contain bug fixes, important changes or new features.          ${white}│"
    echo -e " │ ${cyan}Please consider updating!                                      ${white}│"
    hr 
    echo -e " │ See changelog here: ${yellow}https://tinyurl.com/3sf3bzck               ${white}│"
    hr
    bottom_line
    local yn
    while true; do
      read -p " Do you want to update now? (${yellow}y${white}/${yellow}n${white}): ${yellow}" yn
      case "${yn}" in
        Y|y)
          run "update_helper_script"
          if [ ! -x "$HELPER_SCRIPT_FOLDER"/helper.sh ]; then
            chmod +x "$HELPER_SCRIPT_FOLDER"/helper.sh >/dev/null 2>&1
          fi
          break;;
        N|n)
          break;;
        *)
          error_msg "Please select a correct choice!";;
      esac
    done
  fi
}

function show_usage() {
  echo "Creality Helper Script - Command Line Interface"
  echo
  echo "Usage: $0 [command] [feature] [options]"
  echo
  echo "Commands:"
  echo "  install <feature>    Install a feature"
  echo "  remove <feature>     Remove a feature"
  echo "  status [feature]     Show installation status of feature(s)"
  echo "  list                 List all available features"
  echo
  echo "Examples:"
  echo "  $0 install moonraker"
  echo "  $0 remove fluidd"
  echo "  $0 status moonraker"
  echo "  $0 status"
  echo "  $0 list"
  echo
  echo "Run without arguments to start interactive menu."
  exit 0
}

function get_feature_status() {
  feature_name=$1
  case "$feature_name" in
    moonraker|moonraker-nginx) [ -d "$MOONRAKER_FOLDER" ] && echo "installed" || echo "not installed";;
    fluidd) [ -d "$FLUIDD_FOLDER" ] && echo "installed" || echo "not installed";;
    mainsail) [ -d "$MAINSAIL_FOLDER" ] && echo "installed" || echo "not installed";;
    entware) [ -f "$ENTWARE_FILE" ] && echo "installed" || echo "not installed";;
    gcode-shell-command|shell-command) [ -f "$KLIPPER_SHELL_FILE" ] && echo "installed" || echo "not installed";;
    kamp) [ -d "$KAMP_FOLDER" ] && echo "installed" || echo "not installed";;
    buzzer) [ -f "$BUZZER_FILE" ] && echo "installed" || echo "not installed";;
    nozzle-cleaning) [ -d "$NOZZLE_CLEANING_FOLDER" ] && echo "installed" || echo "not installed";;
    fans-control) [ -f "$FAN_CONTROLS_FILE" ] && echo "installed" || echo "not installed";;
    improved-shapers|shapers) [ -d "$IMP_SHAPERS_FOLDER" ] && echo "installed" || echo "not installed";;
    useful-macros|macros) [ -f "$USEFUL_MACROS_FILE" ] && echo "installed" || echo "not installed";;
    save-zoffset|zoffset) [ -f "$SAVE_ZOFFSET_FILE" ] && echo "installed" || echo "not installed";;
    screws-tilt-adjust|screws) [ -f "$SCREWS_ADJUST_FILE" ] && echo "installed" || echo "not installed";;
    m600) [ -f "$M600_SUPPORT_FILE" ] && echo "installed" || echo "not installed";;
    git-backup|backup) [ -f "$GIT_BACKUP_FILE" ] && echo "installed" || echo "not installed";;
    timelapse) [ -f "$TIMELAPSE_FILE" ] && echo "installed" || echo "not installed";;
    camera-settings|camera) [ -f "$CAMERA_SETTINGS_FILE" ] && echo "installed" || echo "not installed";;
    usb-camera) [ -f "$USB_CAMERA_FILE" ] && echo "installed" || echo "not installed";;
    octoeverywhere) [ -d "$OCTOEVERYWHERE_FOLDER" ] && echo "installed" || echo "not installed";;
    obico|moonraker-obico) [ -d "$MOONRAKER_OBICO_FOLDER" ] && echo "installed" || echo "not installed";;
    guppyflo) [ -d "$GUPPYFLO_FOLDER" ] && echo "installed" || echo "not installed";;
    mobileraker) [ -d "$MOBILERAKER_COMPANION_FOLDER" ] && echo "installed" || echo "not installed";;
    octoapp) [ -d "$OCTOAPP_COMPANION_FOLDER" ] && echo "installed" || echo "not installed";;
    simplyprint) grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && echo "installed" || echo "not installed";;
    guppy-screen|guppy) [ -d "$GUPPY_SCREEN_FOLDER" ] && echo "installed" || echo "not installed";;
    *) echo "unknown"; return 1;;
  esac
}

function list_features() {
  echo "Available features:"
  echo
  echo "Essentials:"
  echo "  moonraker          - Moonraker and Nginx"
  echo "  fluidd             - Fluidd Web Interface"
  echo "  mainsail           - Mainsail Web Interface"
  echo
  echo "Utilities:"
  echo "  entware            - Entware Package Manager"
  echo "  shell-command      - Klipper Gcode Shell Command"
  echo
  echo "Improvements:"
  echo "  kamp               - Klipper Adaptive Meshing & Purging"
  echo "  buzzer             - Buzzer Support"
  echo "  nozzle-cleaning    - Nozzle Cleaning Fan Control"
  echo "  fans-control       - Fans Control Macros"
  echo "  shapers            - Improved Shapers Calibrations"
  echo "  macros             - Useful Macros"
  echo "  zoffset            - Save Z-Offset Macros"
  echo "  screws             - Screws Tilt Adjust Support"
  echo "  m600               - M600 Support"
  echo "  backup             - Git Backup"
  echo
  echo "Camera:"
  echo "  timelapse          - Moonraker Timelapse"
  echo "  camera             - Camera Settings Control"
  echo "  usb-camera         - USB Camera Support"
  echo
  echo "Remote Access:"
  echo "  octoeverywhere     - OctoEverywhere"
  echo "  obico              - Moonraker Obico"
  echo "  guppyflo           - GuppyFLO"
  echo "  mobileraker        - Mobileraker Companion"
  echo "  octoapp            - OctoApp Companion"
  echo "  simplyprint        - SimplyPrint"
  echo
  echo "Other:"
  echo "  guppy-screen       - Guppy Screen (K1 only)"
}

function execute_feature_command() {
  cmd=$1
  feature=$2
  
  case "$feature" in
    moonraker|moonraker-nginx)
      [ "$model" = "3V3" ] && func_suffix="_3v3" || func_suffix="_nginx"
      [ "$cmd" = "install" ] && install_moonraker${func_suffix} || remove_moonraker${func_suffix};;
    fluidd)
      [ "$model" = "3V3" ] && func_suffix="_3v3" || func_suffix=""
      [ "$cmd" = "install" ] && install_fluidd${func_suffix} || remove_fluidd;;
    mainsail)
      [ "$cmd" = "install" ] && install_mainsail || remove_mainsail;;
    entware)
      [ "$cmd" = "install" ] && install_entware || remove_entware;;
    gcode-shell-command|shell-command)
      [ "$cmd" = "install" ] && install_gcode_shell_command || remove_gcode_shell_command;;
    kamp)
      [ "$cmd" = "install" ] && install_kamp || remove_kamp;;
    buzzer)
      [ "$cmd" = "install" ] && install_buzzer_support || remove_buzzer_support;;
    nozzle-cleaning)
      [ "$cmd" = "install" ] && install_nozzle_cleaning_fan_control || remove_nozzle_cleaning_fan_control;;
    fans-control)
      [ "$cmd" = "install" ] && install_fans_control_macros || remove_fans_control_macros;;
    improved-shapers|shapers)
      [ "$cmd" = "install" ] && install_improved_shapers || remove_improved_shapers;;
    useful-macros|macros)
      [ "$cmd" = "install" ] && install_useful_macros || remove_useful_macros;;
    save-zoffset|zoffset)
      [ "$cmd" = "install" ] && install_save_zoffset_macros || remove_save_zoffset_macros;;
    screws-tilt-adjust|screws)
      [ "$cmd" = "install" ] && install_screws_tilt_adjust || remove_screws_tilt_adjust;;
    m600)
      [ "$cmd" = "install" ] && install_m600_support || remove_m600_support;;
    git-backup|backup)
      [ "$cmd" = "install" ] && install_git_backup || remove_git_backup;;
    timelapse)
      [ "$cmd" = "install" ] && install_moonraker_timelapse || remove_moonraker_timelapse;;
    camera-settings|camera)
      [ "$cmd" = "install" ] && install_camera_settings_control || remove_camera_settings_control;;
    usb-camera)
      [ "$cmd" = "install" ] && install_usb_camera || remove_usb_camera;;
    octoeverywhere)
      [ "$cmd" = "install" ] && install_octoeverywhere || remove_octoeverywhere;;
    obico|moonraker-obico)
      [ "$cmd" = "install" ] && install_moonraker_obico || remove_moonraker_obico;;
    guppyflo)
      [ "$cmd" = "install" ] && install_guppyflo || remove_guppyflo;;
    mobileraker)
      [ "$cmd" = "install" ] && install_mobileraker_companion || remove_mobileraker_companion;;
    octoapp)
      [ "$cmd" = "install" ] && install_octoapp_companion || remove_octoapp_companion;;
    simplyprint)
      [ "$cmd" = "install" ] && install_simplyprint || remove_simplyprint;;
    guppy-screen|guppy)
      [ "$cmd" = "install" ] && install_guppy_screen || remove_guppy_screen;;
    *)
      echo "Error: Unknown feature '$feature'"
      echo "Run '$0 list' to see available features"
      exit 1;;
  esac
}

if [ ! -L /usr/bin/helper ]; then
  ln -sf "$HELPER_SCRIPT_FOLDER"/helper.sh /usr/bin/helper > /dev/null 2>&1
fi
rm -rf /root/.cache
set_paths
set_permissions

# Handle command line arguments
if [ $# -gt 0 ]; then
  get_model=$( /usr/bin/get_sn_mac.sh model 2>&1 )
  if echo "$get_model" | grep -iq "K1"; then 
    model="K1"
  elif echo "$get_model" | grep -iq "F001"; then 
    model="3V3"
  elif echo "$get_model" | grep -iq "F002"; then 
    model="3V3"
  elif echo "$get_model" | grep -iq "F005"; then 
    model="3KE"
  elif echo "$get_model" | grep -iq "F003"; then 
    model="10SE"
  elif echo "$get_model" | grep -iq "F004"; then
    model="E5M"
  fi

  case "$1" in
    install|remove)
      if [ -z "$2" ]; then
        echo "Error: Feature name required"
        echo "Usage: $0 $1 <feature>"
        echo "Run '$0 list' to see available features"
        exit 1
      fi
      
      # Check installation status
      status=$(get_feature_status "$2")
      if [ "$status" = "unknown" ]; then
        echo "Error: Unknown feature '$2'"
        echo "Run '$0 list' to see available features"
        exit 1
      fi
      
      # Prevent installing already installed features
      if [ "$1" = "install" ] && [ "$status" = "installed" ]; then
        echo "Feature '$2' is already installed."
        exit 0
      fi
      
      # Prevent removing not installed features
      if [ "$1" = "remove" ] && [ "$status" = "not installed" ]; then
        echo "Feature '$2' is not installed."
        exit 0
      fi
      
      clear
      execute_feature_command "$1" "$2"
      echo
      echo "Operation completed!"
      ;;
    status)
      if [ -z "$2" ]; then
        echo "Feature Status:"
        echo
        for feat in moonraker fluidd mainsail entware shell-command kamp buzzer nozzle-cleaning fans-control shapers macros zoffset screws m600 backup timelapse camera usb-camera octoeverywhere obico guppyflo mobileraker octoapp simplyprint; do
          status=$(get_feature_status "$feat")
          printf "  %-20s: %s\n" "$feat" "$status"
        done
      else
        status=$(get_feature_status "$2")
        if [ "$status" = "unknown" ]; then
          echo "Error: Unknown feature '$2'"
          exit 1
        fi
        echo "$2: $status"
      fi
      ;;
    list)
      list_features
      ;;
    help|-h|--help)
      show_usage
      ;;
    *)
      echo "Error: Unknown command '$1'"
      show_usage
      ;;
  esac
  exit 0
fi

# Interactive mode
update_menu
main_menu
