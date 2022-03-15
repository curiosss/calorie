import 'package:calorie_calculator/providers/todaymeals_prv.dart';
import 'package:calorie_calculator/views/fitness_app/ui_view/wave_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main_app.dart';
import '../../../utils/colors.dart';
import '../../../utils/dimens.dart';
import '../fitness_app_theme.dart';

class WaterView extends StatefulWidget {
  const WaterView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _WaterViewState createState() => _WaterViewState();
}

class _WaterViewState extends State<WaterView> with TickerProviderStateMixin {
  TextEditingController textEditingController = TextEditingController();
  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  saveDrink({bool isAdd = true}) {
    int dval = int.tryParse(textEditingController.text.toString() ?? '0');
    if (!isAdd) dval = -dval;
    Provider.of<TodayMealsProvider>(context, listen: false)
        .changeWater(val: dval);
  }

  changeDrink({bool isAdd = true}) {
    showDialog(
      context: context,
      useSafeArea: true,
      useRootNavigator: true,
      builder: (context) {
        return Dialog(
          insetPadding: EdgeInsets.all(10),
          child: Container(
            padding: EdgeInsets.all(15),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 18.0),
                      decoration: InputDecoration(
                        labelText: 'Mukdary',
                        hintText: '100 mL',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(color: Colors.red),
                        ),
                        prefixIcon: Icon(Icons.numbers),
                      ),
                    ),
                  ),
                  SizedBox(height: Dimens.GMargin),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPlateItem(val: '150'),
                      _buildPlateItem(val: '200'),
                      _buildPlateItem(val: '250'),
                    ],
                  ),
                  SizedBox(height: Dimens.GMargin),
                  SizedBox(
                    height: 40.0,
                    child: ElevatedButton(
                      onPressed: () {
                        saveDrink(isAdd: isAdd);
                        Navigator.pop(context);
                      },
                      child: Text('Ýatda sakla'),
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Dimens.SBORDER_R)))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buildPlateItem({String val = '0'}) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
        onTap: () {
          textEditingController.text = val;
        },
        child: Container(
          height: 40,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.blue,
            borderRadius: BorderRadius.circular(Dimens.SBORDER_R),
          ),
          child: Text(
            val + ' mL',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
              transform: Matrix4.translationValues(
                  0.0, 30 * (1.0 - widget.mainScreenAnimation.value), 0.0),
              child: Consumer<TodayMealsProvider>(
                builder: (context, prov, _) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 16, bottom: 18),
                    child: Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.white,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            bottomRight: Radius.circular(8.0),
                            topRight: Radius.circular(68.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: FitnessAppTheme.grey.withOpacity(0.2),
                              offset: const Offset(1.1, 1.1),
                              blurRadius: 10.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 16, left: 16, right: 16, bottom: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4, bottom: 3),
                                            child: Text(
                                              prov.water.toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 32,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8, bottom: 8),
                                            child: Text(
                                              'ml',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                                letterSpacing: -0.2,
                                                color: FitnessAppTheme
                                                    .nearlyDarkBlue,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 4, top: 2, bottom: 14),
                                        child: Text(
                                          'gündelik norma ${prov.SHOULDDRINK / 1000}L',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            letterSpacing: 0.0,
                                            color: FitnessAppTheme.darkText,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4, right: 4, top: 8, bottom: 16),
                                    child: Container(
                                      height: 2,
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.background,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(4.0)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 16),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4),
                                              child: Icon(
                                                Icons.access_time,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                                size: 16,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 4.0),
                                              child: Text(
                                                'Soňky gezek ${prov.lastDrinkDate}',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily:
                                                      FitnessAppTheme.fontName,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 14,
                                                  letterSpacing: 0.0,
                                                  color: FitnessAppTheme.grey
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Padding(
                                        //   padding: const EdgeInsets.only(top: 4),
                                        //   child: Row(
                                        //     mainAxisAlignment:
                                        //         MainAxisAlignment.start,
                                        //     crossAxisAlignment:
                                        //         CrossAxisAlignment.center,
                                        //     children: <Widget>[
                                        //       SizedBox(
                                        //         width: 24,
                                        //         height: 24,
                                        //         child: Image.asset(
                                        //             'assets/fitness_app/bell.png'),
                                        //       ),
                                        //       Flexible(
                                        //         child: Text(
                                        //           'Your bottle is empty, refill it!.',
                                        //           textAlign: TextAlign.start,
                                        //           style: TextStyle(
                                        //             fontFamily:
                                        //                 FitnessAppTheme.fontName,
                                        //             fontWeight: FontWeight.w500,
                                        //             fontSize: 12,
                                        //             letterSpacing: 0.0,
                                        //             color: HexColor('#F65283'),
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ],
                                        // ),
                                        // ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 34,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  InkWell(
                                    onTap: () {
                                      changeDrink(isAdd: true);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.nearlyWhite,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme
                                                  .nearlyDarkBlue
                                                  .withOpacity(0.4),
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.add,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 28,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      changeDrink(isAdd: false);
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.nearlyWhite,
                                        shape: BoxShape.circle,
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme
                                                  .nearlyDarkBlue
                                                  .withOpacity(0.4),
                                              offset: const Offset(4.0, 4.0),
                                              blurRadius: 8.0),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(6.0),
                                        child: Icon(
                                          Icons.remove,
                                          color: FitnessAppTheme.nearlyDarkBlue,
                                          size: 24,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 8, top: 16),
                              child: Container(
                                width: 60,
                                height: 160,
                                decoration: BoxDecoration(
                                  color: HexColor('#E8EDFE'),
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(80.0),
                                      bottomLeft: Radius.circular(80.0),
                                      bottomRight: Radius.circular(80.0),
                                      topRight: Radius.circular(80.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.4),
                                        offset: const Offset(2, 2),
                                        blurRadius: 4),
                                  ],
                                ),
                                child: WaveView(
                                  percentageValue:
                                      prov.water / prov.SHOULDDRINK * 100,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )),
        );
      },
    );
  }
}
