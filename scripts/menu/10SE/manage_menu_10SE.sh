#!/bin/sh

set -e

manage_menu_ui_10se() {
  top_line
  title '[ MANAGE FEATURES ]' "${yellow}"
  inner_line
  hr
  subtitle '•ESSENTIALS:'
  feature_option ' 1' 'Moonraker and Nginx' "$([ -d "$MOONRAKER_FOLDER" ] && echo true || echo false)"
  feature_option ' 2' 'Fluidd (port 4408)' "$([ -d "$FLUIDD_FOLDER" ] && echo true || echo false)"
  feature_option ' 3' 'Mainsail (port 4409)' "$([ -d "$MAINSAIL_FOLDER" ] && echo true || echo false)"
  hr
  subtitle '•UTILITIES:'
  feature_option ' 4' 'Entware' "$([ -f "$ENTWARE_FILE" ] && echo true || echo false)"
  feature_option ' 5' 'Klipper Gcode Shell Command' "$([ -f "$KLIPPER_SHELL_FILE" ] && echo true || echo false)"
  hr
  subtitle '•IMPROVEMENTS:'
  feature_option ' 6' 'Improved Shapers Calibrations' "$([ -d "$IMP_SHAPERS_FOLDER" ] && echo true || echo false)"
  feature_option ' 7' 'Save Z-Offset Macros' "$([ -f "$SAVE_ZOFFSET_FILE" ] && echo true || echo false)"
  feature_option ' 8' 'Git Backup' "$([ -f "$GIT_BACKUP_FILE" ] && echo true || echo false)"
  hr
  subtitle '•CAMERA:'
  feature_option ' 9' 'Moonraker Timelapse' "$([ -f "$TIMELAPSE_FILE" ] && echo true || echo false)"
  feature_option '10' 'Nebula Camera Settings Control' "$([ -f "$CAMERA_SETTINGS_FILE" ] && echo true || echo false)"
  feature_option '11' 'USB Camera Support' "$([ -f "$USB_CAMERA_FILE" ] && echo true || echo false)"
  hr
  subtitle '•REMOTE ACCESS:'
  feature_option '12' 'OctoEverywhere' "$([ -d "$OCTOEVERYWHERE_FOLDER" ] && echo true || echo false)"
  feature_option '13' 'Moonraker Obico' "$([ -d "$MOONRAKER_OBICO_FOLDER" ] && echo true || echo false)"
  feature_option '14' 'GuppyFLO' "$([ -d "$GUPPYFLO_FOLDER" ] && echo true || echo false)"
  feature_option '15' 'Mobileraker Companion' "$([ -d "$MOBILERAKER_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '16' 'OctoApp Companion' "$([ -d "$OCTOAPP_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '17' 'SimplyPrint' "$(grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && echo true || echo false)"
  hr
  inner_line
  hr
  echo -e " │ ${cyan}Select a feature number to Install/Remove it                  ${white}│"
  hr
  bottom_menu_option 'b' 'Back to [Main Menu]' "${yellow}"
  bottom_menu_option 'q' 'Exit' "${darkred}"
  hr
  version_line "$(get_script_version)"
  bottom_line
}

manage_feature_10se() {
  feature_num=$1
  case "${feature_num}" in
    1) [ -d "$MOONRAKER_FOLDER" ] && run "remove_moonraker_nginx" "manage_menu_ui_10se" || run "install_moonraker_nginx" "manage_menu_ui_10se";;
    2) [ -d "$FLUIDD_FOLDER" ] && run "remove_fluidd" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_fluidd" "manage_menu_ui_10se"; };;
    3) [ -d "$MAINSAIL_FOLDER" ] && run "remove_mainsail" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_mainsail" "manage_menu_ui_10se"; };;
    4) [ -f "$ENTWARE_FILE" ] && run "remove_entware" "manage_menu_ui_10se" || run "install_entware" "manage_menu_ui_10se";;
    5) [ -f "$KLIPPER_SHELL_FILE" ] && run "remove_gcode_shell_command" "manage_menu_ui_10se" || run "install_gcode_shell_command" "manage_menu_ui_10se";;
    6) [ -d "$IMP_SHAPERS_FOLDER" ] && run "remove_improved_shapers" "manage_menu_ui_10se" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_improved_shapers" "manage_menu_ui_10se"; };;
    7) [ -f "$SAVE_ZOFFSET_FILE" ] && run "remove_save_zoffset_macros" "manage_menu_ui_10se" || run "install_save_zoffset_macros" "manage_menu_ui_10se";;
    8) [ -f "$GIT_BACKUP_FILE" ] && run "remove_git_backup" "manage_menu_ui_10se" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_git_backup" "manage_menu_ui_10se"; }; };;
    9) [ -f "$TIMELAPSE_FILE" ] && run "remove_moonraker_timelapse" "manage_menu_ui_10se" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_moonraker_timelapse" "manage_menu_ui_10se"; };;
    10) [ -f "$CAMERA_SETTINGS_FILE" ] && run "remove_camera_settings_control" "manage_menu_ui_10se" || { ! v4l2-ctl --list-devices | grep -q 'CCX2F3298' && error_msg "Nebula camera not detected, please plug it in!" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_camera_settings_control" "manage_menu_ui_10se"; }; };;
    11) [ -f "$USB_CAMERA_FILE" ] && run "remove_usb_camera" "manage_menu_ui_10se" || { v4l2-ctl --list-devices | grep -qE 'CREALITY|CCX2F3298' && error_msg "It looks like you are using a Creality camera and it's not compatible!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_usb_camera" "manage_menu_ui_10se"; }; };;
    12) [ -d "$OCTOEVERYWHERE_FOLDER" ] && run "remove_octoeverywhere" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_octoeverywhere" "manage_menu_ui_10se"; }; }; };;
    13) [ -d "$MOONRAKER_OBICO_FOLDER" ] && run "remove_moonraker_obico" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_moonraker_obico" "manage_menu_ui_10se"; }; }; };;
    14) [ -d "$GUPPYFLO_FOLDER" ] && run "remove_guppyflo" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_guppyflo" "manage_menu_ui_10se"; };;
    15) [ -d "$MOBILERAKER_COMPANION_FOLDER" ] && run "remove_mobileraker_companion" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_mobileraker_companion" "manage_menu_ui_10se"; }; }; };;
    16) [ -d "$OCTOAPP_COMPANION_FOLDER" ] && run "remove_octoapp_companion" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_octoapp_companion" "manage_menu_ui_10se"; }; }; };;
    17) grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && run "remove_simplyprint" "manage_menu_ui_10se" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || run "install_simplyprint" "manage_menu_ui_10se"; }; };;
  esac
}

manage_menu_10se() {
  clear
  manage_menu_ui_10se
  manage_menu_opt=""
  while true; do
    read -p " ${white}Type your choice and validate with Enter: ${yellow}" manage_menu_opt
    case "${manage_menu_opt}" in
      1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17) manage_feature_10se "${manage_menu_opt}";;
      B|b) clear; main_menu; break;;
      Q|q) clear; exit 0;;
      *) error_msg "Please select a correct choice!";;
    esac
  done
  manage_menu_10se
}
