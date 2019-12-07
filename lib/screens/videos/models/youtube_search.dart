import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:pokedex/configs/AppString.dart';
import 'package:pokedex/screens/videos/models/video.dart';

class YoutubeSearch {
  YoutubeSearch({@required this.keyword, this.order, @required this.key, this.maxResults});
  String keyword;
  String key;
  String order;
  String maxResults;

  static get RELEVANCE => 'relevance';

  Future<List<Video>> getVideos() async {

    final String httpURL = 'https://www.googleapis.com/youtube/v3/search?part=snippet'
        '&maxResults=${this.maxResults}'
        '&order=${this.order}'
        '&q=${this.keyword}'
        '&type=video&videoEmbeddable=true&videoLicense=youtube&videoSyndicated=true'
        '&key=${AppString.key}';

    print('------httpURL------');
    print(httpURL);
    Response res = await get(httpURL);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body)['items'];
      List<Video> videos = body
          .map(
            (dynamic item) => Video.fromJson(item),
          )
          .toList();

      return videos;
    } else {
      throw "Can't get posts.";
    }
  }
}
