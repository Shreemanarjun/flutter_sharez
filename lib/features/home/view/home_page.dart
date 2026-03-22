import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/core/router/router.gr.dart';
import 'package:flutter_sharez/core/router/router_pod.dart';
import 'package:flutter_sharez/features/update_app_version/controller/check_update_available.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';

import 'package:flutter_sharez/features/file_selector/controller/selected_files_list_pod.dart';
import 'package:flutter_sharez/features/settings/controller/settings_pod.dart';

import 'package:flutter_sharez/features/send/controller/send_notifier_pod.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        SendRoute(),
        ReceiveRoute(),
      ],
      builder: (context, child) {
        return _HomeContent(child: child);
      },
    );
  }
}

class _HomeContent extends ConsumerStatefulWidget {
  final Widget child;
  const _HomeContent({required this.child});

  @override
  ConsumerState<_HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends ConsumerState<_HomeContent> {
  bool _dragging = false;
  Offset? _dragPosition;

  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    ref.watch(sendStateNotifierPod);

    // Auto-start logic
    ref.listen(selectedFilesPod, (previous, next) {
      final isAutoStart = ref.read(autoStartServerProvider);
      if (next.isNotEmpty && isAutoStart) {
        final tabsRouter = AutoTabsRouter.of(context);
        if (tabsRouter.activeIndex != 0) {
          tabsRouter.setActiveIndex(0);
        }
      }
    });

    ref.listen(
      checkUpdateAvailablePod,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref
              .read(autorouterProvider)
              .navigate(ChangelogRoute(updateModel: next.value!));
        }
      },
    );

    final tabsRouter = AutoTabsRouter.of(context);
    final isDesktop = ResponsiveBreakpoints.of(context).largerThan(MOBILE);

    final content = isDesktop
        ? Scaffold(
            backgroundColor: ShadTheme.of(context).colorScheme.background,
            body: Row(
              children: [
                _buildSidebar(context, tabsRouter, t, ref),
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: ShadTheme.of(context).colorScheme.border,
                ),
                Expanded(child: widget.child),
              ],
            ),
          )
        : Scaffold(
            backgroundColor: ShadTheme.of(context).colorScheme.background,
            body: widget.child,
            bottomNavigationBar:
                _buildBottomNavigationBar(context, tabsRouter, t),
          );

    return DropTarget(
      onDragEntered: (details) {
        setState(() {
          _dragging = true;
          _dragPosition = details.localPosition;
        });
      },
      onDragExited: (details) {
        setState(() {
          _dragging = false;
          _dragPosition = null;
        });
      },
      onDragUpdated: (details) {
        setState(() {
          _dragPosition = details.localPosition;
        });
      },
      onDragDone: (details) async {
        setState(() => _dragging = false);
        final List<PlatformFile> platformFiles = [];
        for (final xFile in details.files) {
          final size = await xFile.length();
          platformFiles.add(
            PlatformFile(
              path: xFile.path,
              name: xFile.name,
              size: size,
            ),
          );
        }
        if (platformFiles.isNotEmpty) {
          ref.read(selectedFilesPod.notifier).addFiles(platformFiles);
        }
      },
      child: Stack(
        children: [
          content,
          if (_dragging && _dragPosition != null)
            _DragFollower(position: _dragPosition!),
        ],
      ),
    );
  }

  Widget _buildSidebar(
      BuildContext context, TabsRouter tabsRouter, dynamic t, WidgetRef ref) {
    return Container(
      width: 260,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      color: ShadTheme.of(context).colorScheme.background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              "Sharez",
              style: ShadTheme.of(context).textTheme.h3.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          const SizedBox(height: 48),
          _SidebarItem(
            icon: LucideIcons.arrowUp,
            label: t.sendLbl,
            isSelected: tabsRouter.activeIndex == 0,
            onTap: () => tabsRouter.setActiveIndex(0),
          ),
          const SizedBox(height: 8),
          _SidebarItem(
            icon: LucideIcons.arrowDown,
            label: t.receiveLbl,
            isSelected: tabsRouter.activeIndex == 1,
            onTap: () => tabsRouter.setActiveIndex(1),
          ),
          const Spacer(),
          _SidebarItem(
            icon: LucideIcons.settings,
            label: t.settingsPage,
            isSelected: false,
            onTap: () => ref.read(autorouterProvider).push(const SettingsRoute()),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigationBar(
      BuildContext context, TabsRouter tabsRouter, dynamic t) {
    final theme = ShadTheme.of(context);
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 10,
          )
        ],
        border: Border(
          top: BorderSide(
            color: theme.colorScheme.border,
            width: 1,
          ),
        ),
      ),
      padding: EdgeInsets.only(
        bottom: MediaQuery.paddingOf(context).bottom + 12,
        top: 12,
        left: 16,
        right: 16,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _BottomNavItem(
            icon: LucideIcons.arrowUp,
            label: t.sendLbl,
            isSelected: tabsRouter.activeIndex == 0,
            onTap: () => tabsRouter.setActiveIndex(0),
          ),
          _BottomNavItem(
            icon: LucideIcons.arrowDown,
            label: t.receiveLbl,
            isSelected: tabsRouter.activeIndex == 1,
            onTap: () => tabsRouter.setActiveIndex(1),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.mutedForeground;

    return Material(
      color: isSelected
          ? theme.colorScheme.primary.withValues(alpha: 0.1)
          : Colors.transparent,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        hoverColor: theme.colorScheme.primary.withValues(alpha: 0.05),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(icon, color: color, size: 22),
              const SizedBox(width: 16),
              Text(
                label,
                style: theme.textTheme.p.copyWith(
                  color: color,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavItem extends StatelessWidget {
  const _BottomNavItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    final color = isSelected
        ? theme.colorScheme.primary
        : theme.colorScheme.mutedForeground;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: theme.textTheme.small.copyWith(
                color: color,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class _DragFollower extends StatelessWidget {
  final Offset position;
  const _DragFollower({required this.position});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Positioned.fill(
      child: IgnorePointer(
        child: Stack(
          children: [
            // Background dim
            AnimatedOpacity(
              duration: const Duration(milliseconds: 200),
              opacity: 1.0,
              child: Container(
                color: theme.colorScheme.primary.withValues(alpha: 0.05),
              ),
            ),
            // Floating Indicator
            AnimatedPositioned(
              duration: const Duration(milliseconds: 50),
              left: position.dx - 100,
              top: position.dy - 60,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.background,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: theme.colorScheme.primary,
                    width: 2,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.primary.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      LucideIcons.copyPlus,
                      color: theme.colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "Drop to Share",
                      style: theme.textTheme.p.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Full Screen Border Glow
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                  width: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
