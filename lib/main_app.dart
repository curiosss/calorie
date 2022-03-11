import 'package:calorie_calculator/providers/categorie_prv.dart';
import 'package:calorie_calculator/providers/todaymeals_prv.dart';
import 'package:calorie_calculator/views/fitness_app/fitness_app_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategorieProvider()),
        ChangeNotifierProvider(
          create: ((context) => TodayMealsProvider()),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.indigo,
          primarySwatch: Colors.indigo,
          iconTheme: IconThemeData(color: Colors.green),
          // textTheme: TextTheme(),

          appBarTheme: AppBarTheme(centerTitle: true),
        ),
        // home: MenuScreen(),
        home: FitnessAppHomeScreen(),
      ),
    );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}
