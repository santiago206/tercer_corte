import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tecnar_tok/presentation/providers/discover_provider.dart';
import 'package:tecnar_tok/presentation/widgets/shared/video_scrollable_view.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DiscoverProvider>().loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: discoverProvider.initialLoading
          ? const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : VideoScrollableView(
              videos: discoverProvider.videos,
            ),
    );
  }
}
