import 'package:flutter/material.dart';

class KCard extends StatelessWidget {
  final Widget child;
  final Function navigate;
  const KCard({
    Key key,
    @required this.child,
    @required this.navigate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
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
            child: child,
          ),
        ),
      ),
    );
  }
}
