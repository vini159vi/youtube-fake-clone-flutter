import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_flutter/blocs/favorite_bloc.dart';
import 'package:youtube_flutter/blocs/videos_bloc.dart';
import 'package:youtube_flutter/data/video.dart';
import 'package:youtube_flutter/delegates/data_search.dart';
import 'package:youtube_flutter/ui/favorites.dart';
import 'package:youtube_flutter/widgets/videotile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    VideosBloc videosBloc = BlocProvider.getBloc<VideosBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 25,
          child: Image.asset("images/yt_logo_rgb_dark.png"),
        ),
        elevation: 0,
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
              alignment: Alignment.center,
              child: StreamBuilder<Map<String, Video>>(
                stream: BlocProvider.getBloc<FavoriteBloc>().outFav,
                builder: (context, snapshot) {
                  if (snapshot.hasData)
                    return Text("${snapshot.data.length}");
                  else
                    return Container();
                },
              )),
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                return Favorites();
              }));
            },
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String result =
                  await showSearch(context: context, delegate: DataSearch());
              if (result != null) {
                final videoBloc = BlocProvider.getBloc<VideosBloc>();
                videoBloc.inSearch.add(result);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: StreamBuilder(
        stream: videosBloc.outVideos,
        initialData: [],
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (context, index) {
                if (index < snapshot.data.length) {
                  return VideoTile(snapshot.data[index]);
                } else if (index > 1) {
                  videosBloc.inSearch.add(null);
                  return Container(
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
