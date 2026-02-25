import "package:flutter/material.dart";
import "package:nxcalculator/models/history_item.dart";
import "package:nxcalculator/repositories/calculator.dart";
import "package:nxcalculator/repositories/settings.dart";
import "package:nxcalculator/theme/constants.dart";
import "package:nxcalculator/utils/strings.dart";
import "package:nxcalculator/utils/ui.dart";
import "package:nxcalculator/widgets/confirm_action_dialog.dart";
import "package:provider/provider.dart";

class HistoryListview extends StatefulWidget {
  const HistoryListview({
    required this.repo,
    this.onDelete,
    this.onTapItem,
    super.key,
  });

  final void Function(int index)? onDelete;
  final void Function(HistoryItem item)? onTapItem;
  final CalculatorRepository repo;

  @override
  State<HistoryListview> createState() => _HistoryListviewState();
}

class _HistoryListviewState extends State<HistoryListview> {
  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsRepository>(
      builder: (context, settings, child) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const SizedBox.square(dimension: kMinInteractiveDimension),
                  const Expanded(
                    child: Text(
                      "History",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 24, fontFamily: "NType"),
                    ),
                  ),
                  IconButton(
                    tooltip: "Delete History",
                    onPressed: () async {
                      final shouldClear = await showDialog<bool>(
                        context: context,
                        builder: (context) => const ConfirmActionDialog(
                          titleText: "Clear History",
                          infoText:
                              "Are you sure you want to clear all history?",
                        ),
                      );

                      if (shouldClear ?? false) {
                        await widget.repo.clearHistory();
                      }
                    },
                    icon: SizedBox.square(
                      dimension: 24,
                      child: _isDark
                          ? Image.asset("assets/icons/dark/delete.png")
                          : Image.asset("assets/icons/light/delete.png"),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ListenableBuilder(
              listenable: widget.repo,
              builder: (context, child) {
                return Expanded(
                  child: widget.repo.history.isEmpty
                      ? const SafeArea(
                          child: Center(
                            child: Text(
                              "No items to display",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: widget.repo.history.length,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 2),
                          itemBuilder: (context, index) {
                            final item = widget.repo.history[index];
                            return Padding(
                              padding: index == widget.repo.history.length - 1
                                  ? const EdgeInsetsGeometry.only(bottom: 124)
                                  : EdgeInsetsGeometry.zero,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Dismissible(
                                      key: ValueKey(
                                        "${item.result}-${item.equation.join()}",
                                      ),
                                      direction: DismissDirection.endToStart,
                                      background: Container(
                                        alignment: Alignment.centerRight,
                                        padding: const EdgeInsets.only(
                                          right: 24,
                                          top: 32,
                                          bottom: 32,
                                        ),
                                        decoration: BoxDecoration(
                                          color: nothingRed,
                                          borderRadius: buildListTileBorder(
                                            index,
                                            widget.repo.history.length,
                                          ).borderRadius,
                                        ),
                                        child: Image.asset(
                                          "assets/icons/dark/delete.png",
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        widget.onDelete?.call(index);
                                        setState(() {});
                                      },
                                      child: Card(
                                        shape: buildListTileBorder(
                                          index,
                                          widget.repo.history.length,
                                        ),
                                        color: _isDark
                                            ? MediaQuery.of(
                                                        context,
                                                      ).orientation ==
                                                      Orientation.landscape
                                                  ? darkThemeCard
                                                  : darkThemeListItem
                                            : lightThemeCard,

                                        child: InkWell(
                                          onTap: () =>
                                              widget.onTapItem?.call(item),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              children: [
                                                Text(
                                                  getFormattedResult(
                                                    widget
                                                        .repo
                                                        .history[index]
                                                        .result,
                                                    settings: settings,
                                                  ),
                                                  textAlign: TextAlign.end,
                                                  maxLines: 1,
                                                  style: const TextStyle(
                                                    fontSize: 32,
                                                  ),
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                    fontSize: 32,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text.rich(
                                                  maxLines: 1,
                                                  textAlign: TextAlign.end,
                                                  strutStyle: const StrutStyle(
                                                    forceStrutHeight: true,
                                                    fontSize: 20,
                                                  ),

                                                  TextSpan(
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.grey,
                                                    ),
                                                    children: widget
                                                        .repo
                                                        .history[index]
                                                        .equation
                                                        .map((text) {
                                                          return getEquationText(
                                                            text,
                                                            superVerticalOffset:
                                                                -4,
                                                            superStyle:
                                                                const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                            settings: settings,
                                                          );
                                                        })
                                                        .toList(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
