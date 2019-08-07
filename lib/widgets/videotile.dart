import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_flutter/api.dart';
import 'package:youtube_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_flutter/data/video.dart';
import 'package:youtube_flutter/utils/utils.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  FavoriteBloc favoriteBloc = BlocProvider.getBloc<FavoriteBloc>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Utils.openYoutubeVideo(video.id);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                video.thumb,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                        child: Text(
                          video.title,
                          maxLines: 2,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          video.channel,
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
                StreamBuilder(
                  stream: favoriteBloc.outFav,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return IconButton(
                        icon: Icon(
                          snapshot.data.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border,
                          size: 24,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          favoriteBloc.toggleFavorite(video);
                        },
                      );
                    } else {
                      return CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
