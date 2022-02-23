import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/utils/utils.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> _dates = [
    '18 Ýan',
    '19 Ýan',
    '20 Ýan',
    '21 Ýan',
    '22 Ýan',
    '23 Ýan',
    '24 Ýan'
  ];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _controller.animateTo(_controller., duration: Duration(milliseconds:10), curve: Curves.linear);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaloriýa taryhy'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(Dimens.GMargin),
        child: Column(
          children: [
            Container(
              height: 50,
              child: _buildDates(),
            ),
            SizedBox(height: Dimens.GMargin),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
              ),
              child: Container(
                height: 100,
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(Dimens.GMargin),
                child: Center(
                  child: Text(
                    'Kaloriýalar taryhy boş',
                    style: TextStyle(
                      fontSize: Dimens.FONT_H18,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDates() {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: _dates.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.HGMargin),
            child: ElevatedButton(
              onPressed: () {},
              child: Text(_dates[index]),
            ),
          );
        });
  }
}
