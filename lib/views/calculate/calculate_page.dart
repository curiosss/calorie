import 'package:calorie_calculator/helpers/calculate.dart';
import 'package:calorie_calculator/models/calorie_model.dart';
import 'package:calorie_calculator/providers/categorie_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

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
  double _activityTypeInd = 1;
  bool _isLoading = false;
  String _recommendCal;

  @override
  void dispose() {
    _ageValController.dispose();
    _weightValController.dispose();
    _heightValController.dispose();

    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    var cal = await Provider.of<CategorieProvider>(context, listen: false)
        .initCalData();

    if (cal != null) {
      _ageValController.text = cal.age.toString();
      _genderTypeInd = cal.isMen ? 0 : 1;
      _heightValController.text = cal.heightInCm.toString();
      _weightValController.text = cal.weightInKg.toString();
      _activityTypeInd = cal.activityIndex;
      _recommendCal = cal.recomendCal.toStringAsFixed(2);
      setState(() {});
    }
    super.didChangeDependencies();
  }

  calculateAndSave() async {
    if (validate()) {
      setState(() {
        _isLoading = true;
      });

      CalorieModel calorieModel = CalorieModel(
        isMen: _genderTypeInd == 0,
        weightInKg: int.tryParse(_weightValController.text.toString() ?? '0'),
        heightInCm: int.tryParse(_heightValController.text.toString() ?? '0'),
        age: int.tryParse(_ageValController.text.toString() ?? '0'),
        activityIndex: _activityTypeInd,
      );
      calorieModel.recomendCal = Ccalculator.calculateCalorie(calorieModel);

      bool res = await Provider.of<CategorieProvider>(context, listen: false)
          .saveCalData(calorieModel);

      setState(() {
        _isLoading = false;
      });
      if (res) _recommendCal = calorieModel.recomendCal.toStringAsFixed(2);
    }
  }

  bool validate() {
    if (_ageValController.text.length == 0 ||
        _heightValController.text.length == 0 ||
        _weightValController.text.length == 0) {
      ScaffoldMessenger.of(context).removeCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        'Maglumatlaryny doly girizin',
        textAlign: TextAlign.center,
      )));
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        padding:
            EdgeInsets.symmetric(vertical: Dimens.GMargin, horizontal: 30.0),
        child: Column(
          children: [
            _recommendCal != null
                ? Text(
                    'Günde $_recommendCal kkal iýmit iýmeli',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  )
                : Container(),
            SizedBox(height: Dimens.GMargin),
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
                  child: Text('Aýal'),
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
                title: 'Boýy  (sm)',
                textEditingController: _heightValController),
            SizedBox(height: Dimens.GMargin),
            buildRow(
                title: 'Agramy  (kg)',
                textEditingController: _weightValController),
            SizedBox(height: Dimens.GMargin),
            _buildDropdown(
              title: 'Işjenligi',
              items: [
                DropdownMenuItem(
                  value: 1.0,
                  child: Text('Oturylyşyk'),
                ),
                DropdownMenuItem(
                  value: 1.13,
                  child: Text('Ýeňil işjeňlik'),
                ),
                DropdownMenuItem(
                  //
                  value: 1.28,
                  child: Text('Ortaça işjeňlik'),
                ),
                DropdownMenuItem(
                  value: 1.4,
                  child: Text('Örän işjeň'),
                )
              ],
              onChanged: (val) {
                setState(() {
                  _activityTypeInd = val;
                });
              },
              typeIndex: _activityTypeInd,
            ),
            SizedBox(height: 2 * Dimens.GMargin),
            SizedBox(
              height: 45.0,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: calculateAndSave,
                child: _isLoading
                    ? Center(
                        child: SpinKitCircle(
                          size: 30.0,
                          color: Colors.white,
                        ),
                      )
                    : Text('Hasapla'),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Dimens.GBORDER_R),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 300),
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
      dynamic typeIndex,
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
