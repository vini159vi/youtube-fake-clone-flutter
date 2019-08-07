import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_flutter/blocs/videos_bloc.dart';
import 'package:youtube_flutter/ui/home.dart';

import 'blocs/favorite_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
        Bloc((i) => FavoriteBloc())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Youtube_flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      ),
    );
  }
}
