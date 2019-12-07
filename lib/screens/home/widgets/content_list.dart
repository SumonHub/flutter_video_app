import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:pokedex/screens/home/widgets/content_card.dart';

class ContentList extends StatelessWidget {
  List categories;

  ContentList({@required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2.44,
          crossAxisSpacing: 10,
          mainAxisSpacing: 12,
        ),
        padding: EdgeInsets.all(28.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String categoryTitle = categories[index]['field0'];
          // ToDo: pass keyword
          String categoryKey = categories[index]['field1'];
          return ContentCard(
              categoryTitle: categoryTitle,
              onPress: () {
                Navigator.of(context)
                    .pushNamed("/video_list", arguments: 'bangla');
              });
        });
  }
}
