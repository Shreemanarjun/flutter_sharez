import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/theme/app_theme_pod.dart';
import 'package:flutter_sharez/features/settings/controller/settings_pod.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:file_picker/file_picker.dart';

@RoutePage()
class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = ref.watch(translationsPod);
    final theme = ShadTheme.of(context);
    final deviceName = ref.watch(deviceNameProvider);
    final isAutoStart = ref.watch(autoStartServerProvider);
    final downloadPath = ref.watch(downloadPathProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: Text(t.settingsPage),
        backgroundColor: theme.colorScheme.background,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        children: [
          _buildSectionHeader(context, "Device Identity"),
          const SizedBox(height: 12),
          ShadCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(LucideIcons.smartphone),
                  title: const Text("Device Name"),
                  subtitle: Text(deviceName.isEmpty ? "Set your device identifier" : deviceName),
                  trailing: ShadButton.ghost(
                    onPressed: () => _showDeviceNameDialog(context, ref, deviceName),
                    child: Icon(LucideIcons.pencil, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, "Server Behavior"),
          const SizedBox(height: 12),
          ShadCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                SwitchListTile.adaptive(
                  secondary: Icon(LucideIcons.zap),
                  title: const Text("Auto-Start Server"),
                  subtitle: const Text("Start server immediately when files are selected"),
                  value: isAutoStart,
                  onChanged: (v) => ref.read(autoStartServerProvider.notifier).set(v),
                  activeTrackColor: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, "Storage"),
          const SizedBox(height: 12),
          ShadCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.folder),
                  title: const Text("Download Location"),
                  subtitle: Text(
                    downloadPath ?? "System Default",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: ShadButton.ghost(
                    onPressed: () async {
                      final path = await FilePicker.platform.getDirectoryPath();
                      if (path != null) {
                        ref.read(downloadPathProvider.notifier).set(path);
                      }
                    },
                    child: const Icon(LucideIcons.pencil, size: 16),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, "Appearance"),
          const SizedBox(height: 12),
          ShadCard(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.palette),
                  title: const Text("Theme Mode"),
                  trailing: const ThemeSegmentedBtn(),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Theme Accent",
                            style: theme.textTheme.small.copyWith(fontWeight: FontWeight.w600),
                          ),
                          if (ref.watch(themeAccentPod).accent == AppThemeAccent.custom)
                            ShadButton.ghost(
                              onPressed: () => _showCustomColorPicker(context, ref),
                              child: Text("Change Color", style: TextStyle(fontSize: 12, color: theme.colorScheme.primary)),
                            ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 54,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppThemeAccent.values.length,
                          separatorBuilder: (context, index) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final accentPreset = AppThemeAccent.values[index];
                            final currentThemeState = ref.watch(themeAccentPod);
                            final isSelected = currentThemeState.accent == accentPreset;
                            
                            // Use the actual color from the preset or the custom color if selected
                            final displayColor = accentPreset == AppThemeAccent.custom 
                              ? (currentThemeState.customColor ?? accentPreset.color)
                              : accentPreset.color;

                            return Tooltip(
                              message: accentPreset.name,
                              child: GestureDetector(
                                onTap: () {
                                  if (accentPreset == AppThemeAccent.custom) {
                                    _showCustomColorPicker(context, ref);
                                  } else {
                                    ref.read(themeAccentPod.notifier).updateTheme(accentPreset);
                                  }
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 250),
                                  width: 48,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: displayColor,
                                    shape: BoxShape.circle,
                                    boxShadow: isSelected ? [
                                      BoxShadow(
                                        color: displayColor.withValues(alpha: 0.4),
                                        blurRadius: 8,
                                        spreadRadius: 2,
                                      )
                                    ] : null,
                                    border: Border.all(
                                      color: isSelected ? Colors.white : Colors.transparent,
                                      width: 3,
                                    ),
                                  ),
                                  child: isSelected
                                      ? const Icon(Icons.check, color: Colors.white, size: 24)
                                      : (accentPreset == AppThemeAccent.custom ? const Icon(Icons.colorize, color: Colors.white, size: 20) : null),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader(context, "Preferences"),
          const SizedBox(height: 12),
          ShadCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.languages),
                  title: Text(t.changeLanguage),
                  trailing: const AppLocalePopUp(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title.toUpperCase(),
        style: ShadTheme.of(context).textTheme.small.copyWith(
              fontWeight: FontWeight.bold,
              color: ShadTheme.of(context).colorScheme.mutedForeground,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  void _showDeviceNameDialog(BuildContext context, WidgetRef ref, String currentName) {
    final controller = TextEditingController(text: currentName);
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Edit Device Name'),
        description: const Text("This name will be visible to other devices on the network."),
        actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
          ShadButton(
            child: const Text('Save'),
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref.read(deviceNameProvider.notifier).set(controller.text);
                Navigator.pop(context);
              }
            },
          ),
        ],
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: ShadInput(
            controller: controller,
            placeholder: const Text('Enter device name'),
          ),
        ),
      ),
    );
  }

  void _showCustomColorPicker(BuildContext context, WidgetRef ref) {
    showShadDialog(
      context: context,
      builder: (context) => ShadDialog(
        title: const Text('Pick a Custom Color'),
        description: const Text("Select a color to generate your unique theme."),
        actions: [
          ShadButton.outline(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        child: Container(
          width: 400,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment: WrapAlignment.center,
            children: [
              ...Colors.primaries.map((color) {
                return GestureDetector(
                  onTap: () {
                    ref.read(themeAccentPod.notifier).updateCustomColor(color);
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
