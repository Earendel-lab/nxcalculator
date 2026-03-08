import "package:flutter/material.dart";
import "package:nxcalculator/registries/settings.dart";
import "package:nxcalculator/repositories/settings.dart";
import "package:nxcalculator/screens/settings/settings.dart";
import "package:nxcalculator/widgets/slide_page_route.dart";
import "package:nxdesign/fonts.dart";
import "package:provider/provider.dart";

class DynamicAppbar extends StatelessWidget {
  const DynamicAppbar({super.key, this.padding, this.actions});

  final List<Widget>? actions;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Consumer<SettingsRepository>(
      builder: (context, repo, child) {
        return Padding(
          padding: padding ?? EdgeInsetsGeometry.zero,
          child: AppBar(
            titleSpacing: 0,
            title: repo.get(hideCalcTextSetting)
                ? null
                : const Text(
                    "Calculator",
                    style: TextStyle(
                      fontFamily: NxFonts.fontNType,
                      fontSize: 36,
                    ),
                    strutStyle: StrutStyle(
                      forceStrutHeight: true,
                      fontSize: 36,
                    ),
                  ),
            actions: [
              ...?actions,
              IconButton(
                tooltip: "Settings",
                icon: isDark
                    ? Image.asset("assets/icons/dark/settings.png")
                    : Image.asset("assets/icons/light/settings.png"),
                padding: const EdgeInsets.all(14),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(SlidePageRoute(page: const SettingsScreen()));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
