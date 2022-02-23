import 'package:calorie_calculator/views/calculate/calculate_page.dart';
import 'package:calorie_calculator/views/categories/categories_page.dart';
import 'package:calorie_calculator/views/history/history_page.dart';
import 'package:calorie_calculator/views/tips/tips_page.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  double wid = 360;
  @override
  Widget build(BuildContext context) {
    wid = MediaQuery.of(context).size.width;
    wid /= 360;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                _buildMenuItem(
                  title: 'Hasapla',
                  icon: Icons.calculate,
                  navigate: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CalculatePage()));
                  },
                ),
                SizedBox(width: 8.0),
                _buildMenuItem(
                  title: 'Önümler',
                  icon: Icons.restaurant,
                  navigate: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoriesPage()));
                  },
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                _buildMenuItem(
                  title: 'Kaloriýa taryhy',
                  icon: Icons.history,
                  navigate: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HistoryPage()));
                  },
                ),
                SizedBox(width: 8.0),
                _buildMenuItem(
                  title: 'Maslahatlar',
                  icon: Icons.new_releases_sharp,
                  navigate: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TipsPage()));
                  },
                ),
              ],
            ),
            SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    String title,
    IconData icon,
    Function navigate,
  }) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                splashColor: Colors.green.withOpacity(0.2),
                highlightColor: Colors.green.withOpacity(0.3),
                onTap: navigate,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 20.0),
                      FittedBox(
                        child: Icon(
                          icon,
                          size: 34 * wid,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
