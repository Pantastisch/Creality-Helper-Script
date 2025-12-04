#!/bin/sh

set -e

manage_menu_ui_e5m() {
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
  feature_option ' 6' 'Klipper Adaptive Meshing & Purging' "$([ -d "$KAMP_FOLDER" ] && echo true || echo false)"
  feature_option ' 7' 'Buzzer Support' "$([ -f "$BUZZER_FILE" ] && echo true || echo false)"
  feature_option ' 8' 'Nozzle Cleaning Fan Control' "$([ -d "$NOZZLE_CLEANING_FOLDER" ] && echo true || echo false)"
  feature_option ' 9' 'Fans Control Macros' "$([ -f "$FAN_CONTROLS_FILE" ] && echo true || echo false)"
  feature_option '10' 'Improved Shapers Calibrations' "$([ -d "$IMP_SHAPERS_FOLDER" ] && echo true || echo false)"
  feature_option '11' 'Useful Macros' "$([ -f "$USEFUL_MACROS_FILE" ] && echo true || echo false)"
  feature_option '12' 'Save Z-Offset Macros' "$([ -f "$SAVE_ZOFFSET_FILE" ] && echo true || echo false)"
  feature_option '13' 'Screws Tilt Adjust Support' "$([ -f "$SCREWS_ADJUST_FILE" ] && echo true || echo false)"
  feature_option '14' 'M600 Support' "$([ -f "$M600_SUPPORT_FILE" ] && echo true || echo false)"
  feature_option '15' 'Git Backup' "$([ -f "$GIT_BACKUP_FILE" ] && echo true || echo false)"
  hr
  subtitle '•CAMERA:'
  feature_option '16' 'Moonraker Timelapse' "$([ -f "$TIMELAPSE_FILE" ] && echo true || echo false)"
  feature_option '17' 'Camera Settings Control' "$([ -f "$CAMERA_SETTINGS_FILE" ] && echo true || echo false)"
  feature_option '18' 'USB Camera Support' "$([ -f "$USB_CAMERA_FILE" ] && echo true || echo false)"
  hr
  subtitle '•REMOTE ACCESS:'
  feature_option '19' 'OctoEverywhere' "$([ -d "$OCTOEVERYWHERE_FOLDER" ] && echo true || echo false)"
  feature_option '20' 'Moonraker Obico' "$([ -d "$MOONRAKER_OBICO_FOLDER" ] && echo true || echo false)"
  feature_option '21' 'GuppyFLO' "$([ -d "$GUPPYFLO_FOLDER" ] && echo true || echo false)"
  feature_option '22' 'Mobileraker Companion' "$([ -d "$MOBILERAKER_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '23' 'OctoApp Companion' "$([ -d "$OCTOAPP_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '24' 'SimplyPrint' "$(grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && echo true || echo false)"
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

manage_feature_e5m() {
  feature_num=$1
  case "${feature_num}" in
    1) [ -d "$MOONRAKER_FOLDER" ] && run "remove_moonraker_nginx" "manage_menu_ui_e5m" || run "install_moonraker_nginx" "manage_menu_ui_e5m";;
    2) [ -d "$FLUIDD_FOLDER" ] && run "remove_fluidd" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_fluidd" "manage_menu_ui_e5m"; };;
    3) [ -d "$MAINSAIL_FOLDER" ] && run "remove_mainsail" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_mainsail" "manage_menu_ui_e5m"; };;
    4) [ -f "$ENTWARE_FILE" ] && run "remove_entware" "manage_menu_ui_e5m" || run "install_entware" "manage_menu_ui_e5m";;
    5) [ -f "$KLIPPER_SHELL_FILE" ] && run "remove_gcode_shell_command" "manage_menu_ui_e5m" || run "install_gcode_shell_command" "manage_menu_ui_e5m";;
    6) [ -d "$KAMP_FOLDER" ] && run "remove_kamp" "manage_menu_ui_e5m" || run "install_kamp" "manage_menu_ui_e5m";;
    7) [ -f "$BUZZER_FILE" ] && run "remove_buzzer_support" "manage_menu_ui_e5m" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_buzzer_support" "manage_menu_ui_e5m"; };;
    8) [ -d "$NOZZLE_CLEANING_FOLDER" ] && run "remove_nozzle_cleaning_fan_control" "manage_menu_ui_e5m" || run "install_nozzle_cleaning_fan_control" "manage_menu_ui_e5m";;
    9) [ -f "$FAN_CONTROLS_FILE" ] && run "remove_fans_control_macros" "manage_menu_ui_e5m" || run "install_fans_control_macros" "manage_menu_ui_e5m";;
    10) [ -d "$IMP_SHAPERS_FOLDER" ] && run "remove_improved_shapers" "manage_menu_ui_e5m" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_improved_shapers" "manage_menu_ui_e5m"; };;
    11) [ -f "$USEFUL_MACROS_FILE" ] && run "remove_useful_macros" "manage_menu_ui_e5m" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_useful_macros" "manage_menu_ui_e5m"; };;
    12) [ -f "$SAVE_ZOFFSET_FILE" ] && run "remove_save_zoffset_macros" "manage_menu_ui_e5m" || run "install_save_zoffset_macros" "manage_menu_ui_e5m";;
    13) [ -f "$SCREWS_ADJUST_FILE" ] && run "remove_screws_tilt_adjust" "manage_menu_ui_e5m" || run "install_screws_tilt_adjust" "manage_menu_ui_e5m";;
    14) [ -f "$M600_SUPPORT_FILE" ] && run "remove_m600_support" "manage_menu_ui_e5m" || run "install_m600_support" "manage_menu_ui_e5m";;
    15) [ -f "$GIT_BACKUP_FILE" ] && run "remove_git_backup" "manage_menu_ui_e5m" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_git_backup" "manage_menu_ui_e5m"; }; };;
    16) [ -f "$TIMELAPSE_FILE" ] && run "remove_moonraker_timelapse" "manage_menu_ui_e5m" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_moonraker_timelapse" "manage_menu_ui_e5m"; };;
    17) [ -f "$CAMERA_SETTINGS_FILE" ] && run "remove_camera_settings_control" "manage_menu_ui_e5m" || { v4l2-ctl --list-devices | grep -q 'CCX2F3299' && [ ! -f "$INITD_FOLDER"/S50usb_camera ] && error_msg "This is not compatible with the new hardware version of the camera!" || { [ ! -f "$KLIPPER_SHELL_FILE" ] && error_msg "Klipper Gcode Shell Command is needed, please install it first!" || run "install_camera_settings_control" "manage_menu_ui_e5m"; }; };;
    18) [ -f "$USB_CAMERA_FILE" ] && run "remove_usb_camera" "manage_menu_ui_e5m" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_usb_camera" "manage_menu_ui_e5m"; };;
    19) [ -d "$OCTOEVERYWHERE_FOLDER" ] && run "remove_octoeverywhere" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_octoeverywhere" "manage_menu_ui_e5m"; }; }; };;
    20) [ -d "$MOONRAKER_OBICO_FOLDER" ] && run "remove_moonraker_obico" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_moonraker_obico" "manage_menu_ui_e5m"; }; }; };;
    21) [ -d "$GUPPYFLO_FOLDER" ] && run "remove_guppyflo" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && [ ! -d "$NGINX_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || run "install_guppyflo" "manage_menu_ui_e5m"; };;
    22) [ -d "$MOBILERAKER_COMPANION_FOLDER" ] && run "remove_mobileraker_companion" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_mobileraker_companion" "manage_menu_ui_e5m"; }; }; };;
    23) [ -d "$OCTOAPP_COMPANION_FOLDER" ] && run "remove_octoapp_companion" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || { [ ! -f "$ENTWARE_FILE" ] && error_msg "Entware is needed, please install it first!" || run "install_octoapp_companion" "manage_menu_ui_e5m"; }; }; };;
    24) grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && run "remove_simplyprint" "manage_menu_ui_e5m" || { [ ! -d "$MOONRAKER_FOLDER" ] && error_msg "Moonraker and Nginx are needed, please install them first!" || { [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ] && error_msg "Fluidd or Mainsail is needed, please install one of them first!" || run "install_simplyprint" "manage_menu_ui_e5m"; }; };;
  esac
}

manage_menu_e5m() {
  clear
  manage_menu_ui_e5m
  manage_menu_opt=""
  while true; do
    read -p " ${white}Type your choice and validate with Enter: ${yellow}" manage_menu_opt
    case "${manage_menu_opt}" in
      1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24) manage_feature_e5m "${manage_menu_opt}";;
      B|b) clear; main_menu; break;;
      Q|q) clear; exit 0;;
      *) error_msg "Please select a correct choice!";;
    esac
  done
  manage_menu_e5m
}
