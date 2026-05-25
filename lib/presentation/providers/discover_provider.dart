import 'package:flutter/material.dart';
import 'package:tecnar_tok/domain/entities/video_post.dart';
import 'package:tecnar_tok/infrastructure/local_video_model.dart';
import 'package:tecnar_tok/infrastructure/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier {
  bool initialLoading = true;
  List<VideoPost> videos = [];

  Future<void> loadNextPage() async {
    final List<VideoPost> newVideos = localVideoPosts
        .map((video) => LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();

    videos.addAll(newVideos);
    initialLoading = false;

    notifyListeners();
  }
}
