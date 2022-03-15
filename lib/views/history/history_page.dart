import 'package:calorie_calculator/providers/history_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:calorie_calculator/views/history/history_items.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryPage extends StatefulWidget {
  final AnimationController animationController;
  const HistoryPage({
    Key key,
    this.animationController,
  }) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int selectedIndex = 1;
  bool isFound = false;
  List<String> dateNames = [];
  List<DateTime> dates = [];
  String choosenDate = '';
  List<String> months = [
    'Ýan',
    'Few',
    'Mar',
    'Apr',
    'Maý',
    'Iýun',
    'Iýul',
    'Aug',
    'Sen',
    'Okt',
    'Noý',
    'Dek',
  ];
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    initDates();
    selectDate(dates[selectedIndex]);
    super.initState();
  }

  initDates() {
    DateTime now = DateTime.now();
    dateNames.add('');
    dates.add(null);
    for (int i = 1; i < 7; i++) {
      DateTime date = now.subtract(Duration(days: i));
      dates.add(date);
      if (i == 1)
        dateNames.add('Düýn');
      else
        dateNames.add('${months[date.month - 1]} ${date.day}');
    }
  }

  selectDate(DateTime date) async {
    isFound = await Provider.of<HistoryProvider>(context, listen: false)
        .initTodayMeals(date);
    setState(() {});
  }

  showdatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.utc(2022, 1, 1),
      lastDate: DateTime.now(),
      confirmText: 'Saýla',
      cancelText: 'Ýatyr',
      helpText: 'Sene saýlaň',
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedIndex = 0;
          choosenDate = DateFormat('yyyy.MM.dd').format(value);
        });
        selectDate(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kaloriýa taryhy'),
      ),
      body: Consumer<HistoryProvider>(builder: (context, prov, _) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: Dimens.GMargin),
          child: Column(
            children: [
              Container(
                height: 50,
                child: _buildDates(),
              ),
              SizedBox(height: Dimens.GMargin),
              selectedIndex == 0
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.GMargin),
                      child: Text(
                        choosenDate,
                        style: TextStyle(
                          fontSize: 17,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    )
                  : Container(),
              //empty page
              Expanded(
                child: isFound
                    ? HistoryItemWidget(
                        animationController: widget.animationController,
                      )
                    : _buildEmptyPage(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildDates() {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        controller: _controller,
        itemCount: dateNames.length,
        padding: EdgeInsets.symmetric(horizontal: Dimens.HGMargin),
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.HGMargin),
              child: ElevatedButton(
                onPressed: showdatePicker,
                child: Icon(Icons.date_range),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[400],
                  ),
                ),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.HGMargin),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  selectDate(dates[index]);
                },
                child: Text(dateNames[index]),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    isSelected
                        ? Theme.of(context).primaryColor
                        : Colors.grey[400],
                  ),
                ),
              ),
            );
          }
        });
  }

  _buildEmptyPage() {
    return Center(
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.no_meals_ouline,
              size: 90,
              color: Colors.grey,
            ),
            SizedBox(height: Dimens.GMargin),
            Text(
              'Kaloriýalar taryhy boş',
              style: TextStyle(
                fontSize: Dimens.FONT_H18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}
