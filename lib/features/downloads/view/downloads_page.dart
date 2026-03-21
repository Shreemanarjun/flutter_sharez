import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:file_sizes/file_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/data/model/download_item.dart';
import 'package:flutter_sharez/features/downloads/controller/download_history_pod.dart';
import 'package:flutter_sharez/shared/helper/global_helper.dart';
import 'package:flutter_sharez/translation_pod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

@RoutePage(
  deferredLoading: true,
)
class DownloadsPage extends ConsumerStatefulWidget {
  const DownloadsPage({super.key});

  @override
  ConsumerState<DownloadsPage> createState() => _DownloadsPageState();
}

class _DownloadsPageState extends ConsumerState<DownloadsPage>
    with GlobalHelper {
  final Set<DownloadItem> _selectedItems = {};
  bool _isSelectionMode = false;

  void _toggleSelection(DownloadItem item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
        if (_selectedItems.isEmpty) _isSelectionMode = false;
      } else {
        _selectedItems.add(item);
        _isSelectionMode = true;
      }
    });
  }

  void _clearSelection() {
    setState(() {
      _isSelectionMode = false;
      _selectedItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final t = ref.watch(translationsPod);
    final history = ref.watch(downloadHistoryPod);
    final theme = ShadTheme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        leading: _isSelectionMode
            ? IconButton(
                onPressed: _clearSelection,
                icon: const Icon(LucideIcons.x),
              )
            : null,
        title: _isSelectionMode
            ? Text("${_selectedItems.length} selected")
            : Text(t.downloads),
        backgroundColor: theme.colorScheme.background,
        elevation: 0,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              onPressed: () {
                ref
                    .read(downloadHistoryPod.notifier)
                    .deleteMultiple(_selectedItems.toList());
                _clearSelection();
              },
              icon: const Icon(LucideIcons.trash2, color: Colors.red),
            ),
          ] else if (history.isNotEmpty) ...[
            ShadTooltip(
              builder: (context) => const Text("Clear History"),
              child: ShadButton.ghost(
                onPressed: () {
                  ref.read(downloadHistoryPod.notifier).clearHistory();
                },
                child: const Icon(LucideIcons.trash2, size: 20),
              ),
            ),
          ],
          const SizedBox(width: 8),
        ],
      ),
      body: history.isEmpty
          ? _buildEmptyState(theme, t)
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final item = history[index];
                final isSelected = _selectedItems.contains(item);

                return GestureDetector(
                  onLongPress: () => _toggleSelection(item),
                  onTap: () {
                    if (_isSelectionMode) {
                      _toggleSelection(item);
                    } else {
                      _openFile(item);
                    }
                  },
                  child: ShadCard(
                    padding: const EdgeInsets.all(16),
                    backgroundColor: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : null,
                    child: Row(
                      children: [
                        if (_isSelectionMode)
                          Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.circle_outlined,
                              color: theme.colorScheme.primary,
                              size: 24,
                            ),
                          ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color:
                                theme.colorScheme.primary.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            _getIconForExtension(item.name),
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: theme.textTheme.large.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    FileSize.getSize(item.size),
                                    style: theme.textTheme.muted
                                        .copyWith(fontSize: 12),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.mutedForeground
                                          .withValues(alpha: 0.3),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    DateFormat('MMM dd, HH:mm')
                                        .format(item.downloadDate),
                                    style: theme.textTheme.muted
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (!_isSelectionMode) ...[
                          const SizedBox(width: 12),
                          ShadButton.outline(
                            size: ShadButtonSize.sm,
                            onPressed: () => _openFile(item),
                            child:
                                const Icon(LucideIcons.externalLink, size: 16),
                          ),
                        ],
                      ],
                    ),
                  ).animate().fadeIn(duration: 400.ms, curve: Curves.easeOut).slideX(
                        begin: 0.2,
                        end: 0,
                        delay: (index * 50).ms,
                      ),
                );
              },
            ),
    );
  }

  Future<void> _openFile(DownloadItem item) async {
    if (await File(item.path).exists()) {
      await OpenFilex.open(item.path);
    } else {
      showErrorSnack(child: const Text("File not found"));
    }
  }

  Widget _buildEmptyState(ShadThemeData theme, dynamic t) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              LucideIcons.download,
              size: 48,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            "No Downloads Yet",
            style: theme.textTheme.h3.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            "Files you receive will appear here.",
            style: theme.textTheme.muted,
          ),
        ],
      ),
    );
  }

  IconData _getIconForExtension(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'mp4' || 'mkv' || 'mov' || 'avi':
        return LucideIcons.video;
      case 'mp3' || 'wav' || 'm4a' || 'flac':
        return LucideIcons.music;
      case 'jpg' || 'jpeg' || 'png' || 'gif' || 'webp' || 'svg':
        return LucideIcons.image;
      case 'pdf':
        return LucideIcons.fileText;
      case 'zip' || 'rar' || '7z' || 'tar' || 'gz':
        return LucideIcons.fileArchive;
      default:
        return LucideIcons.file;
    }
  }
}
