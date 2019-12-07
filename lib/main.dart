import 'package:flutter/material.dart';
import 'package:pokedex/configs/AppColors.dart';
import 'package:pokedex/screens/home/home.dart';
import 'package:pokedex/screens/videos/videos.dart';
import 'package:pokedex/screens/video_player/video_player.dart';
import 'package:pokedex/widgets/fade_page_route.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'CircularStd',
        textTheme: Theme.of(context).textTheme.apply(displayColor: AppColors.black),
        scaffoldBackgroundColor: AppColors.lightGrey,
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: _getRoute,
    );
  }

  Route _getRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        return FadeRoute(page: Home());

      case '/video_list':
        return FadeRoute(page: Videos(
          data: args,
        ));

      case '/video_player':
        return FadeRoute(page: VideoPlayer(
          data: args,
        ));

      default:
        return null;
    }
  }
}
