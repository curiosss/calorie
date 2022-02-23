import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasapla'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimens.GMargin),
        child: Column(
          children: [
            buildRow(title: 'Ýaşy'),
            SizedBox(height: Dimens.GMargin),
            buildRow(title: 'Jynsy'),
            SizedBox(height: Dimens.GMargin),
            buildRow(title: 'Boýy'),
            SizedBox(height: Dimens.GMargin),
            buildRow(title: 'Agramy'),
            SizedBox(height: Dimens.GMargin),
            buildRow(title: 'Işjenligi'),
            SizedBox(height: 2 * Dimens.GMargin),
            SizedBox(
              height: 45.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.calculate),
                label: Text('Hasapla'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildRow({String title}) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Expanded(
          child: TextField(),
        ),
      ],
    );
  }
}
