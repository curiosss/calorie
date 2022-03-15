import 'package:calorie_calculator/views/calculate/calculate_page.dart';
import 'package:calorie_calculator/views/categories/categories_page.dart';
import 'package:calorie_calculator/views/history/history_page.dart';
import 'package:calorie_calculator/views/tips/tips_page.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_view/bottom_bar_view.dart';
import 'fitness_app_theme.dart';
import 'models/tabIcon_data.dart';
import 'my_diary/my_diary_screen.dart';

class FitnessAppHomeScreen extends StatefulWidget {
  @override
  _FitnessAppHomeScreenState createState() => _FitnessAppHomeScreenState();
}

class _FitnessAppHomeScreenState extends State<FitnessAppHomeScreen>
    with TickerProviderStateMixin {
  AnimationController animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;
  int selectedScreen = 0;

  List<Widget> screens = [];

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);
    tabBody = MyDiaryScreen(animationController: animationController);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    screens = [
      HistoryPage(animationController: animationController),
      TipsPage(),
      CategoriesPage(),
      CalculatePage(),
      MyDiaryScreen(animationController: animationController),
    ];
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            screens[selectedScreen],
            bottomBar(),
          ],
        ),
        // body: screens[selectedScreen],
        // bottomNavigationBar: bottomBar(),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {
            print('add click');
            setState(() {
              selectedScreen = 4;
            });
          },
          changeIndex: (int index) {
            print(index);
            setState(() {
              selectedScreen = index;
            });
            //   if (index == 0 || index == 2) {
            //     animationController.reverse().then<dynamic>((data) {
            //       if (!mounted) {
            //         return;
            //       }
            //       setState(() {
            //         tabBody =
            //             MyDiaryScreen(animationController: animationController);
            //       });
            //     });
            //   } else if (index == 1 || index == 3) {
            //     animationController.reverse().then<dynamic>((data) {
            //       if (!mounted) {
            //         return;
            //       }
            //       setState(() {
            //         tabBody =
            //             TrainingScreen(animationController: animationController);
            //       });
            //     });
            //   }
          },
        ),
      ],
    );
  }
}
