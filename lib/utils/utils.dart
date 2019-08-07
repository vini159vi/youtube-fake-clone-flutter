import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_flutter/api.dart';

class Utils{
  static openYoutubeVideo(String idVideo){
    FlutterYoutube.playYoutubeVideoById(apiKey: API_KEY, videoId: idVideo, autoPlay: true, fullScreen: true);
  }
}