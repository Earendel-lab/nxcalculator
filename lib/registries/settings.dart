import "package:flutter/material.dart";
import "package:nxcalculator/models/setting.dart";
import "package:nxcalculator/services/screen_timeout.dart";
import "package:nxdesign/fonts.dart";
import "package:shared_preferences/shared_preferences.dart";

final allSettings = <Setting>[
  themeModeSetting,
  swapDecimalZeroSetting,
  hideCalcTextSetting,
  preferIconsToTextSetting,
  preferBottomToolbarSetting,
  numpadButtonShapeSetting,
  numpadDensitySetting,
  equationResultFontSetting,
  numpadFontSetting,
  groupingSeparatorSetting,
  decimalSeparatorSetting,
  preventDuplicateHistorySetting,
  startExtendedSetting,
  swipeUpHistorySetting,
  keepScreenAwakeSetting,
  disableHapticSetting,
];

Future<void> _writeToStorageHelper(
  SharedPreferencesAsync prefs,
  String key,
  dynamic value,
) async {
  if (value is ThemeMode) {
    await prefs.setString(key, value.name);
  } else if (value is NumpadShape) {
    await prefs.setString(key, value.name);
  } else if (value is NumpadDensity) {
    await prefs.setString(key, value.name);
  } else if (value is GroupingSeparator) {
    await prefs.setString(key, value.name);
  } else if (value is DecimalSeparator) {
    await prefs.setString(key, value.name);
  } else if (value is bool) {
    await prefs.setBool(key, value);
  } else if (value is String) {
    await prefs.setString(key, value);
  }
}

// App Appearance Settings

final themeModeSetting = Setting<ThemeMode>(
  key: "theme_mode",
  category: "appearance",
  name: "App Theme Mode",
  read: (prefs) async {
    final value = await prefs.getString("theme_mode");
    switch (value) {
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "theme_mode", value);
  },
);

final swapDecimalZeroSetting = Setting<bool>(
  key: "swap_decimal_zero",
  category: "appearance",
  name: "Swap Decimal & Zero",
  read: (prefs) async => await prefs.getBool("swap_decimal_zero") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "swap_decimal_zero", value);
  },
);

final preferBottomToolbarSetting = Setting<bool>(
  key: "prefer_bottom_toolbar",
  category: "appearance",
  name: "Toolbar Above Numpad",
  description: "Move history and mode buttons directly above the numpad",
  read: (prefs) async => await prefs.getBool("prefer_bottom_toolbar") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "prefer_bottom_toolbar", value);
  },
);

final hideCalcTextSetting = Setting<bool>(
  key: "hide_calc_text",
  category: "appearance",
  name: "Hide 'Calculator' Text",
  read: (prefs) async => await prefs.getBool("hide_calc_text") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "hide_calc_text", value);
  },
);

final preferIconsToTextSetting = Setting<bool>(
  key: "prefer_icon_to_text",
  category: "appearance",
  name: "Prefer Icon For Clear Button",
  read: (prefs) async => await prefs.getBool("prefer_icon_to_text") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "prefer_icon_to_text", value);
  },
);

final numpadButtonShapeSetting = Setting<NumpadShape>(
  key: "button_shape",
  category: "appearance",
  name: "Numpad Button Shape",
  read: (prefs) async {
    final value = await prefs.getString("button_shape");
    switch (value) {
      case "rounded":
        return NumpadShape.rounded;
      case "circular":
        return NumpadShape.circular;
      default:
        return NumpadShape.mixed;
    }
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "button_shape", value);
  },
);

final numpadDensitySetting = Setting<NumpadDensity>(
  key: "numpad_density",
  category: "appearance",
  name: "Numpad Button Density",
  read: (prefs) async {
    final value = await prefs.getString("numpad_density");
    switch (value) {
      case "comfy":
        return NumpadDensity.comfy;
      case "dense":
        return NumpadDensity.dense;
      default:
        return NumpadDensity.normal;
    }
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "numpad_density", value);
  },
);

// Fonts Settings

final equationResultFontSetting = Setting<String>(
  key: "equation_result_font",
  category: "fonts",
  name: "Equation & Result Font",
  read: (prefs) async {
    return await prefs.getString("equation_result_font") ?? NxFonts.fontInter;
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "equation_result_font", value);
  },
);

final numpadFontSetting = Setting<String>(
  key: "numpad_font",
  category: "fonts",
  name: "Numpad Font",
  read: (prefs) async {
    return await prefs.getString("numpad_font") ?? NxFonts.fontNType;
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "numpad_font", value);
  },
);

// Formatting Settings

final groupingSeparatorSetting = Setting<GroupingSeparator>(
  key: "grouping_separator",
  category: "formatting",
  name: "Grouping Separator",
  read: (prefs) async {
    final value = await prefs.getString("grouping_separator");
    switch (value) {
      case "comma":
        return GroupingSeparator.comma;
      case "dot":
        return GroupingSeparator.dot;
      case "space":
        return GroupingSeparator.space;
      default:
        return GroupingSeparator.system;
    }
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "grouping_separator", value);
  },
);

final decimalSeparatorSetting = Setting<DecimalSeparator>(
  key: "decimal_separator",
  category: "formatting",
  name: "Decimal Separator",
  read: (prefs) async {
    final value = await prefs.getString("decimal_separator");
    switch (value) {
      case "comma":
        return DecimalSeparator.comma;
      case "dot":
        return DecimalSeparator.dot;
      default:
        return DecimalSeparator.system;
    }
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "decimal_separator", value);
  },
);

// Functionality Settings

final preventDuplicateHistorySetting = Setting<bool>(
  key: "prevent_duplicate_history",
  category: "functionality",
  name: "Prevent Duplicate Simultaneous Calculation",
  description:
      "Prevent calculator from adding the same calculation to the history if the equation and result are the same as the last calculation.",
  read: (prefs) async {
    return await prefs.getBool("prevent_duplicate_history") ?? false;
  },
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "prevent_duplicate_history", value);
  },
);

final startExtendedSetting = Setting<bool>(
  key: "start_extended",
  category: "functionality",
  name: "Start in Scientific Mode",
  description: "Choose whether to always start in Scientific Mode",
  read: (prefs) async => await prefs.getBool("start_extended") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "start_extended", value);
  },
);

final swipeUpHistorySetting = Setting<bool>(
  key: "swipe_up_history",
  category: "functionality",
  name: "Swipe Up To Show History",
  description: "Use a quick swipe-up gesture on the numpad to show history.",
  read: (prefs) async => await prefs.getBool("swipe_up_history") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "swipe_up_history", value);
  },
);

final keepScreenAwakeSetting = Setting<bool>(
  key: "keep_screen_awake",
  category: "functionality",
  name: "Keep Screen Awake",
  description:
      "Prevent screen from locking.\n"
      "Use this sparingly for OLED/AMOLED screens due to risk of pixel burn-in if left on for extended periods.",
  read: (prefs) async => await prefs.getBool("keep_screen_awake") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "keep_screen_awake", value);
    await ScreenTimeoutService.setKeepScreenOn(value);
  },
);

final disableHapticSetting = Setting<bool>(
  key: "disable_haptic",
  category: "functionality",
  name: "Disable Haptic Feedback",
  description: "Remove vibrations when numpad buttons are pressed.",
  read: (prefs) async => await prefs.getBool("disable_haptic") ?? false,
  write: (prefs, value) async {
    await _writeToStorageHelper(prefs, "disable_haptic", value);
  },
);

// Extras Settings
