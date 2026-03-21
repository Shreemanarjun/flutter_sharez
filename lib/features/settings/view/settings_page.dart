import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/features/settings/controller/settings_pod.dart';
import 'package:flutter_sharez/features/theme_segmented_btn/view/theme_segmented_btn.dart';
import 'package:flutter_sharez/shared/widget/app_locale_popup.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:file_picker/file_picker.dart';

@RoutePage(
  deferredLoading: true,
)
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
          _buildSectionHeader(context, "Preferences"),
          const SizedBox(height: 12),
          ShadCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                ListTile(
                  leading: Icon(LucideIcons.languages),
                  title: Text(t.changeLanguage),
                  trailing: const AppLocalePopUp(),
                ),
                const Divider(),
                ListTile(
                  leading: Icon(LucideIcons.palette),
                  title: Text(t.switchTheme),
                  trailing: const ThemeSegmentedBtn(),
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
}
