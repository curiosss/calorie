import 'package:flutter/material.dart';

class CrudBottomSheet extends StatelessWidget {
  // final Category category;
  final Function updateTap;
  final Function deleteTap;
  const CrudBottomSheet({
    Key key,
    @required this.updateTap,
    @required this.deleteTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      margin: EdgeInsets.all(8.0),
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Center(
              child: Text(
                'Üýtgetmek',
              ),
            ),
            onTap: updateTap,
          ),
          Divider(height: 8),
          ListTile(
            title: Center(
              child: Text(
                'Pozmak',
              ),
            ),
            onTap: deleteTap,
          ),
          Divider(height: 8),
          ListTile(
            title: Center(
              child: Text(
                'Ýapmak',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
