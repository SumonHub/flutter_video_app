import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pokedex/ads/Ads.dart';
import 'package:pokedex/screens/home/widgets/content_list.dart';
import 'package:pokedex/widgets/color_loader.dart';

class Home extends StatefulWidget {
  static const cardHeightFraction = 0.65;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();

    Ads.initialize();
    Ads.showBannerAd();

    print('--------------Videos init----------------');

  }

  @override
  void dispose() {
    Ads.hideBannerAd();
    super.dispose();
  }

  Widget _buildCard(data) {
    List categories = data['test_response'] as List;

    final screenSize = MediaQuery.of(context).size;

    final pokeSize = screenSize.width * 0.66;
    final pokeTop = -(screenSize.width * 0.154);
    final pokeRight = -(screenSize.width * 0.23);

    return Container(
      width: screenSize.width,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: pokeTop,
            right: pokeRight,
            child: Image.asset(
              "assets/images/pokeball.png",
              width: pokeSize,
              height: pokeSize,
              color: Color(0xFF303943).withOpacity(0.05),
            ),
          ),
          Column(
            children: <Widget>[
              SizedBox(height: 70),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28),
                child: Text(
                  "What Content\nare you looking for?",
                  style: TextStyle(
                    fontSize: 30,
                    height: 0.9,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: ContentList(
                categories: categories,
              ))
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> adsContainer = new List<Widget>();
    adsContainer.add(new Container(
      height: 50.0,
    ));

    return Scaffold(
      body: FutureBuilder(
          future: Firestore.instance.document('test_collection/test_doc').get(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.active:
              case ConnectionState.waiting:
                return Center(
                  child: ColorLoader(),
                );
              case ConnectionState.done:
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }
                return _buildCard(snapshot.data);
            }
            return null;
          }),
      persistentFooterButtons: Ads.isAdsShowing() ? adsContainer : null,
    );
  }
}
