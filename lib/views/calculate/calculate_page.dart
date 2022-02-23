import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key key}) : super(key: key);

  @override
  _CalculatePageState createState() => _CalculatePageState();
}

class _CalculatePageState extends State<CalculatePage> {
  TextEditingController _ageValController = TextEditingController();
  TextEditingController _weightValController = TextEditingController();
  TextEditingController _heightValController = TextEditingController();
  int _genderTypeInd = 0;
  int activityTypeInd = 0;

  @override
  void dispose() {
    _ageValController.dispose();
    _weightValController.dispose();
    _heightValController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hasapla'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding:
            EdgeInsets.symmetric(vertical: Dimens.GMargin, horizontal: 30.0),
        child: Column(
          children: [
            buildRow(title: 'Ýaşy', textEditingController: _ageValController),
            SizedBox(height: Dimens.GMargin),
            _buildDropdown(
              title: 'Jynsy',
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Erkek'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Ayal'),
                )
              ],
              onChanged: (val) {
                setState(() {
                  _genderTypeInd = val;
                });
              },
              typeIndex: _genderTypeInd,
            ),
            SizedBox(height: Dimens.GMargin),
            buildRow(
                title: 'Boýy', textEditingController: _heightValController),
            SizedBox(height: Dimens.GMargin),
            buildRow(
                title: 'Agramy', textEditingController: _weightValController),
            SizedBox(height: Dimens.GMargin),
            _buildDropdown(
              title: 'Isjenligi',
              items: [
                DropdownMenuItem(
                  value: 0,
                  child: Text('Oturylyşyk'),
                ),
                DropdownMenuItem(
                  value: 0,
                  child: Text('Ýeňil işjeňlik'),
                ),
                DropdownMenuItem(
                  value: 0,
                  child: Text('Ortaça işjeňlik'),
                ),
                DropdownMenuItem(
                  value: 1,
                  child: Text('Örän işjeň'),
                )
              ],
              onChanged: (val) {
                setState(() {
                  _genderTypeInd = val;
                });
              },
              typeIndex: activityTypeInd,
            ),
            SizedBox(height: 2 * Dimens.GMargin),
            SizedBox(
              height: 45.0,
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(Icons.calculate),
                label: Text('Hasapla'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
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

  Widget buildRow({String title, TextEditingController textEditingController}) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Flexible(
          child: Container(
            constraints: BoxConstraints(minWidth: 50),
            child: TextField(
              controller: textEditingController,
              keyboardType: TextInputType.number,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(
      {String title,
      List<DropdownMenuItem> items,
      int typeIndex,
      Function onChanged}) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        Expanded(
          child: DropdownButton(
            underline: Container(),
            value: typeIndex,
            onChanged: onChanged,
            items: items,
          ),
        ),
      ],
    );
  }
}
