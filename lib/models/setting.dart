import "package:shared_preferences/shared_preferences.dart";

enum NumpadShape { rounded, circular, mixed }

enum NumpadDensity { comfy, normal, dense }

enum GroupingSeparator { comma, dot, space, system }

enum DecimalSeparator { dot, comma, system }

class Setting<T> {
  final String key;
  final String category;
  final String name;
  final String? description;
  final Future<T> Function(SharedPreferencesAsync prefs) read;
  final Future<void> Function(SharedPreferencesAsync prefs, dynamic value)
  write;

  const Setting({
    required this.key,
    required this.category,
    required this.name,
    required this.read,
    required this.write,
    this.description,
  });
}
