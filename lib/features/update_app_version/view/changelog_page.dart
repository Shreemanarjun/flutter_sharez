import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_sharez/bootstrap.dart';
import 'package:flutter_sharez/data/model/update_model.dart';
import 'package:flutter_sharez/features/update_app_version/controller/get_changelog_pod.dart';
import 'package:flutter_sharez/shared/riverpod_ext/asynvalue_easy_when.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage(
  deferredLoading: true,
)
class ChangelogPage extends StatefulWidget {
  final UpdateModel? updateModel;
  const ChangelogPage({super.key, required this.updateModel});

  @override
  State<ChangelogPage> createState() => _ChangelogPageState();
}

class _ChangelogPageState extends State<ChangelogPage> {
  void downloadApp(final String? assetURl) async {
    if (assetURl == null) return;
    final uri = Uri.parse(assetURl);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $uri');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Consumer(
        builder: (context, ref, child) {
          final changelogs = ref.watch(getChangeLogPod);
          return changelogs.easyWhen(
            data: (data) => Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.updateModel != null)
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          "A new update available \n🎉 ${widget.updateModel?.name}",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.amber,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          "No updates available for now !",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.amber,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  if (widget.updateModel != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          FilledButton(
                            onPressed: () {
                              talker.debug(widget.updateModel);
                              downloadApp(
                                  widget.updateModel!.html_url.toString());
                            },
                            child: const Text("Download"),
                          ),
                          FilledButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancel"),
                          ),
                        ],
                      ),
                    )
                  else
                    FilledButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  const Text(
                    "Changelogs",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Expanded(
                    child: Markdown(
                      data: data,
                      physics: const ClampingScrollPhysics(),
                    ),
                  ),
                ],
              ),
            ),
            onRetry: () {
              ref.invalidate(getChangeLogPod);
            },
          );
        },
      ),
    );
  }
}
