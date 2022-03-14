import 'package:flutter/material.dart';

class ConfirmBottomSheet extends StatelessWidget {
  final String text;
  final String longText;
  const ConfirmBottomSheet({
    Key key,
    @required this.text,
    this.longText = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                // SvgPicture.asset(IconPath.imageHandle),
                SizedBox(height: 30.0),
                Icon(
                  Icons.info,
                  size: 60.0,
                  color: Theme.of(context).primaryColor,
                ),
                SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: Text(
                    text ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.0),
            height: 40.0,
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    child: Text(
                      'Ýok',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        width: 2.0,
                        color: Theme.of(context).primaryColor,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      'Hawa',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        // CustomColors.green,
                        Theme.of(context).primaryColor,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context, true);
                    },
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 25.0),
        ],
      ),
    );
  }
}
