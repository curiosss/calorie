import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';

class TipsPage extends StatefulWidget {
  const TipsPage({Key key}) : super(key: key);

  @override
  _TipsPageState createState() => _TipsPageState();
}

class _TipsPageState extends State<TipsPage> {
  List<String> tips = [
    'Gök önümleri we miweleri has köp iýiň.',
    'Belok we witaminleriň ýeterlikdigine üns beriň.',
    'Doldurylan ýagy we şekeri kesiň',
    'Duzy az iýiň: ulular üçin günde 6g-dan köp bolmaly däl',
    'Ertirlik hökman ediniň',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maslahatlar'),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(
          top: Dimens.GMargin,
          left: Dimens.GMargin,
          right: Dimens.GMargin,
          bottom: 80,
        ),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
                  // child: CachedNetworkImage(imageUrl: ),
                  child: Container(
                    // height: 100.0,
                    width: double.infinity,
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .color
                        .withOpacity(0.05),
                    // padding: const EdgeInsets.all(Dimens.GMargin),
                    child: Image.asset(
                      'assets/tips/${index}.jpg',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Dimens.GMargin,
                    horizontal: Dimens.GMargin,
                  ),
                  child: Text(
                    '${index + 1}\) ${tips[index]}',
                    textAlign: TextAlign.start,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget chil1() {
    return Container(
      color: Colors.green,
      child: Text('slfjlsl'),
    );
  }

  Widget chil2() {
    return Container(
      color: Colors.red,
      child: Text(
          'slfjlsl andl jsjlk jlsjfowj ljsofj slfj lsjlfjlkagh[hjskla kljd'),
    );
  }
}
