import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SkeletonFileLoader extends StatelessWidget {
  const SkeletonFileLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: 8,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return ShadCard(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _SkeletonIcon(),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SkeletonText(width: MediaQuery.sizeOf(context).width * 0.4),
                    const SizedBox(height: 8),
                    _SkeletonText(width: 60, height: 12),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              _SkeletonAction(),
            ],
          ),
        );
      },
    );
  }
}

class _SkeletonIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}

class _SkeletonText extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonText({required this.width, this.height = 16});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}

class _SkeletonAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context);
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
