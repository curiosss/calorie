import 'dart:io';

import 'package:calorie_calculator/providers/history_prv.dart';
import 'package:calorie_calculator/utils/dimens.dart';
import 'package:calorie_calculator/views/choose_meal/choose_meal.dart';
import 'package:calorie_calculator/views/fitness_app/models/meals_list_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../main_app.dart';
import '../fitness_app/fitness_app_theme.dart';

class HistoryMealListView extends StatefulWidget {
  const HistoryMealListView(
      {Key key, this.mainScreenAnimationController, this.mainScreenAnimation})
      : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _HistoryMealListViewState createState() => _HistoryMealListViewState();
}

class _HistoryMealListViewState extends State<HistoryMealListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<MealsListData> mealsListData = MealsListData.standardMeals;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
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
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: Dimens.GMargin),
              child: Column(
                children: mealsListData.map((e) {
                  int index = mealsListData.indexOf(e);

                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                          CurvedAnimation(
                              parent: animationController,
                              curve: Interval((1 / 4) * index, 1.0,
                                  curve: Curves.fastOutSlowIn)));
                  animationController?.forward();

                  return MealsView(
                    index: index,
                    mealsListData: mealsListData[index],
                    animation: animation,
                    animationController: animationController,
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {
  const MealsView({
    Key key,
    this.index,
    this.mealsListData,
    this.animationController,
    this.animation,
  }) : super(key: key);

  final int index;
  final MealsListData mealsListData;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Consumer<HistoryProvider>(builder: (context, prov, _) {
      return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: Transform(
              transform: Matrix4.translationValues(
                  100 * (1.0 - animation.value), 0.0, 0.0),
              child: IntrinsicHeight(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 8, right: 8, bottom: 16),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: HexColor(mealsListData.endColor)
                                    .withOpacity(0.6),
                                offset: const Offset(1.1, 4.0),
                                blurRadius: 8.0),
                          ],
                          gradient: LinearGradient(
                            colors: <HexColor>[
                              HexColor(mealsListData.startColor),
                              HexColor(mealsListData.endColor),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(8.0),
                            bottomLeft: Radius.circular(8.0),
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(54.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 54, left: 16, right: 16, bottom: 8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 8, bottom: 8),
                            // child: SingleChildScrollView(
                            //   physics: BouncingScrollPhysics(),
                            // child: Wrap(
                            //     children: prov.eatings[index].map((product) {
                            //   return Text(
                            //     '${product.name}, ',
                            //     overflow: TextOverflow.ellipsis,
                            //     style: TextStyle(
                            //       fontFamily: FitnessAppTheme.fontName,
                            //       fontWeight: FontWeight.w500,
                            //       fontSize: 14,
                            //       letterSpacing: 0.2,
                            //       color: FitnessAppTheme.white,
                            //     ),
                            //   );
                            // }).toList()),
                            // ),
                            child: Column(
                                children: prov.eatings[index].map((product) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: Dimens.HGMargin),
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          Dimens.GBORDER_R),
                                      child: Image.file(
                                        File(product.image),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(
                                    product.name,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  subtitle: Text(
                                    (product.quant / 100 * product.calorie)
                                            .toString() +
                                        ' kkal / ${product.quant} g',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList()),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(
                          color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 8,
                      child: SizedBox(
                        width: 80,
                        height: 80,
                        child: Image.asset(mealsListData.imagePath),
                      ),
                    ),
                    Positioned(
                      top: 48,
                      left: 90,
                      right: 10,
                      child: Row(children: [
                        Flexible(
                          child: Text(
                            mealsListData.titleTxt,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              letterSpacing: 0.2,
                              color: FitnessAppTheme.white,
                            ),
                          ),
                        ),
                        Spacer(),
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, bottom: 3),
                            child: Text(
                              prov.totalEatingCal[index].toStringAsFixed(0) +
                                  ' kkal',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}