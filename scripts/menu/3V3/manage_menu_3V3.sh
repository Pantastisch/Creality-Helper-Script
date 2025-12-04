#!/bin/sh

set -e

manage_menu_ui_3v3() {
  top_line
  title '[ MANAGE FEATURES ]' "${yellow}"
  inner_line
  hr
  subtitle '•ESSENTIALS:'
  feature_option ' 1' 'Updated Moonraker' "$([ -d "$MOONRAKER_FOLDER" ] && echo true || echo false)"
  feature_option ' 2' 'Updated Fluidd (port 4408)' "$([ -d "$FLUIDD_FOLDER" ] && echo true || echo false)"
  feature_option ' 3' 'Mainsail (port 4409)' "$([ -d "$MAINSAIL_FOLDER" ] && echo true || echo false)"
  hr
  subtitle '•UTILITIES:'
  feature_option ' 4' 'Entware' "$([ -f "$ENTWARE_FILE" ] && echo true || echo false)"
  feature_option ' 5' 'Klipper Gcode Shell Command' "$([ -f "$KLIPPER_SHELL_FILE" ] && echo true || echo false)"
  hr
  subtitle '•IMPROVEMENTS:'
  feature_option ' 6' 'Klipper Adaptive Meshing & Purging' "$([ -d "$KAMP_FOLDER" ] && echo true || echo false)"
  feature_option ' 7' 'Buzzer Support' "$([ -f "$BUZZER_FILE" ] && echo true || echo false)"
  feature_option ' 8' 'Improved Shapers Calibrations' "$([ -d "$IMP_SHAPERS_FOLDER" ] && echo true || echo false)"
  feature_option ' 9' 'Useful Macros' "$([ -f "$USEFUL_MACROS_FILE" ] && echo true || echo false)"
  feature_option '10' 'Save Z-Offset Macros' "$([ -f "$SAVE_ZOFFSET_FILE" ] && echo true || echo false)"
  feature_option '11' 'M600 Support' "$([ -f "$M600_SUPPORT_FILE" ] && echo true || echo false)"
  feature_option '12' 'Git Backup' "$([ -f "$GIT_BACKUP_FILE" ] && echo true || echo false)"
  hr
  subtitle '•CAMERA:'
  feature_option '13' 'Moonraker Timelapse' "$([ -f "$TIMELAPSE_FILE" ] && echo true || echo false)"
  feature_option '14' 'Nebula Camera Settings Control' "$([ -f "$CAMERA_SETTINGS_FILE" ] && echo true || echo false)"
  feature_option '15' 'USB Camera Support' "$([ -f "$USB_CAMERA_FILE" ] && echo true || echo false)"
  hr
  subtitle '•REMOTE ACCESS:'
  feature_option '16' 'OctoEverywhere' "$([ -d "$OCTOEVERYWHERE_FOLDER" ] && echo true || echo false)"
  feature_option '17' 'Moonraker Obico' "$([ -d "$MOONRAKER_OBICO_FOLDER" ] && echo true || echo false)"
  feature_option '18' 'GuppyFLO' "$([ -d "$GUPPYFLO_FOLDER" ] && echo true || echo false)"
  feature_option '19' 'Mobileraker Companion' "$([ -d "$MOBILERAKER_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '20' 'OctoApp Companion' "$([ -d "$OCTOAPP_COMPANION_FOLDER" ] && echo true || echo false)"
  feature_option '21' 'SimplyPrint' "$(grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null && echo true || echo false)"
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

manage_feature_3v3() {
  feature_num=$1
  
  case "${feature_num}" in
    1) # Updated Moonraker
      if [ -d "$MOONRAKER_FOLDER" ]; then
        if [ -d "$GUPPY_SCREEN_FOLDER" ]; then
          error_msg "Moonraker is needed to use Guppy Screen, please uninstall it first!"
        else
          run "remove_moonraker_3v3" "manage_menu_ui_3v3"
        fi
      else
        run "install_moonraker_3v3" "manage_menu_ui_3v3"
      fi;;
    2) # Updated Fluidd
      if [ -d "$FLUIDD_FOLDER" ]; then
        run "remove_fluidd" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        else
          run "install_fluidd_3v3" "manage_menu_ui_3v3"
        fi
      fi;;
    3) # Mainsail
      if [ -d "$MAINSAIL_FOLDER" ]; then
        run "remove_mainsail" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        else
          run "install_mainsail" "manage_menu_ui_3v3"
        fi
      fi;;
    4) # Entware
      if [ -f "$ENTWARE_FILE" ]; then
        run "remove_entware" "manage_menu_ui_3v3"
      else
        run "install_entware" "manage_menu_ui_3v3"
      fi;;
    5) # Klipper Gcode Shell Command
      if [ -f "$KLIPPER_SHELL_FILE" ]; then
        run "remove_gcode_shell_command" "manage_menu_ui_3v3"
      else
        run "install_gcode_shell_command" "manage_menu_ui_3v3"
      fi;;
    6) # KAMP
      if [ -d "$KAMP_FOLDER" ]; then
        run "remove_kamp" "manage_menu_ui_3v3"
      else
        run "install_kamp" "manage_menu_ui_3v3"
      fi;;
    7) # Buzzer Support
      if [ -f "$BUZZER_FILE" ]; then
        run "remove_buzzer_support" "manage_menu_ui_3v3"
      else
        if [ ! -f "$KLIPPER_SHELL_FILE" ]; then
          error_msg "Klipper Gcode Shell Command is needed, please install it first!"
        else
          run "install_buzzer_support" "manage_menu_ui_3v3"
        fi
      fi;;
    8) # Improved Shapers
      if [ -d "$IMP_SHAPERS_FOLDER" ]; then
        run "remove_improved_shapers" "manage_menu_ui_3v3"
      else
        if [ -d "$GUPPY_SCREEN_FOLDER" ]; then
          error_msg "Guppy Screen already has these features!"
        elif [ ! -f "$KLIPPER_SHELL_FILE" ]; then
          error_msg "Klipper Gcode Shell Command is needed, please install it first!"
        else
          run "install_improved_shapers" "manage_menu_ui_3v3"
        fi
      fi;;
    9) # Useful Macros
      if [ -f "$USEFUL_MACROS_FILE" ]; then
        run "remove_useful_macros" "manage_menu_ui_3v3"
      else
        if [ ! -f "$KLIPPER_SHELL_FILE" ]; then
          error_msg "Klipper Gcode Shell Command is needed, please install it first!"
        else
          run "install_useful_macros" "manage_menu_ui_3v3"
        fi
      fi;;
    10) # Save Z-Offset
      if [ -f "$SAVE_ZOFFSET_FILE" ]; then
        run "remove_save_zoffset_macros" "manage_menu_ui_3v3"
      else
        run "install_save_zoffset_macros" "manage_menu_ui_3v3"
      fi;;
    11) # M600 Support
      if [ -f "$M600_SUPPORT_FILE" ]; then
        run "remove_m600_support" "manage_menu_ui_3v3"
      else
        run "install_m600_support" "manage_menu_ui_3v3"
      fi;;
    12) # Git Backup
      if [ -f "$GIT_BACKUP_FILE" ]; then
        run "remove_git_backup" "manage_menu_ui_3v3"
      else
        if [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        elif [ ! -f "$KLIPPER_SHELL_FILE" ]; then
          error_msg "Klipper Gcode Shell Command is needed, please install it first!"
        else
          run "install_git_backup" "manage_menu_ui_3v3"
        fi
      fi;;
    13) # Moonraker Timelapse
      if [ -f "$TIMELAPSE_FILE" ]; then
        run "remove_moonraker_timelapse" "manage_menu_ui_3v3"
      else
        if [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_moonraker_timelapse" "manage_menu_ui_3v3"
        fi
      fi;;
    14) # Nebula Camera Settings
      if [ -f "$CAMERA_SETTINGS_FILE" ]; then
        run "remove_camera_settings_control" "manage_menu_ui_3v3"
      else
        if ! v4l2-ctl --list-devices | grep -q 'CCX2F3298'; then
          error_msg "Nebula camera not detected, please plug it in!"  
        elif [ ! -f "$KLIPPER_SHELL_FILE" ]; then
          error_msg "Klipper Gcode Shell Command is needed, please install it first!"
        else
          run "install_camera_settings_control" "manage_menu_ui_3v3"
        fi
      fi;;
    15) # USB Camera
      if [ -f "$USB_CAMERA_FILE" ]; then
        run "remove_usb_camera" "manage_menu_ui_3v3"
      else
        if v4l2-ctl --list-devices | grep -qE 'CREALITY|CCX2F3298'; then
          error_msg "It looks like you are using a Creality camera and it's not compatible!"
        elif [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_usb_camera" "manage_menu_ui_3v3"
        fi
      fi;;
    16) # OctoEverywhere
      if [ -d "$OCTOEVERYWHERE_FOLDER" ]; then
        run "remove_octoeverywhere" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        elif [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ]; then
          error_msg "Updated Fluidd or Mainsail is needed, please install one of them first!"
        elif [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_octoeverywhere" "manage_menu_ui_3v3"
        fi
      fi;;
    17) # Moonraker Obico
      if [ -d "$MOONRAKER_OBICO_FOLDER" ]; then
        run "remove_moonraker_obico" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        elif [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ]; then
          error_msg "Updated Fluidd or Mainsail is needed, please install one of them first!"
        elif [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_moonraker_obico" "manage_menu_ui_3v3"
        fi
      fi;;
    18) # GuppyFLO
      if [ -d "$GUPPYFLO_FOLDER" ]; then
        run "remove_guppyflo" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        else
          run "install_guppyflo" "manage_menu_ui_3v3"
        fi
      fi;;
    19) # Mobileraker Companion
      if [ -d "$MOBILERAKER_COMPANION_FOLDER" ]; then
        run "remove_mobileraker_companion" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        elif [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ]; then
          error_msg "Fluidd or Mainsail is needed, please install one of them first!"
        elif [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_mobileraker_companion" "manage_menu_ui_3v3"
        fi
      fi;;
    20) # OctoApp Companion
      if [ -d "$OCTOAPP_COMPANION_FOLDER" ]; then
        run "remove_octoapp_companion" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        elif [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ]; then
          error_msg "Updated Fluidd or Mainsail is needed, please install one of them first!"
        elif [ ! -f "$ENTWARE_FILE" ]; then
          error_msg "Entware is needed, please install it first!"
        else
          run "install_octoapp_companion" "manage_menu_ui_3v3"
        fi
      fi;;
    21) # SimplyPrint
      if grep -q "\[simplyprint\]" "$MOONRAKER_CFG" 2>/dev/null; then
        run "remove_simplyprint" "manage_menu_ui_3v3"
      else
        if [ ! -d "$MOONRAKER_FOLDER" ]; then
          error_msg "Updated Moonraker is needed, please install it first!"
        elif [ ! -d "$FLUIDD_FOLDER" ] && [ ! -d "$MAINSAIL_FOLDER" ]; then
          error_msg "Updated Fluidd or Mainsail is needed, please install one of them first!"
        else
          run "install_simplyprint" "manage_menu_ui_3v3"
        fi
      fi;;
  esac
}

manage_menu_3v3() {
  clear
  manage_menu_ui_3v3
  manage_menu_opt=""
  while true; do
    read -p " ${white}Type your choice and validate with Enter: ${yellow}" manage_menu_opt
    case "${manage_menu_opt}" in
      1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21)
        manage_feature_3v3 "${manage_menu_opt}"
        ;;
      B|b)
        clear; main_menu; break;;
      Q|q)
         clear; exit 0;;
      *)
        error_msg "Please select a correct choice!";;
    esac
  done
  manage_menu_3v3
}
