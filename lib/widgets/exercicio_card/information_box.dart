import 'package:flutter/material.dart';

class InformationBox extends StatelessWidget {
  final String information;
  final IconData icon;
  final double width;

  const InformationBox({this.information, this.icon, this.width});

  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          this.icon,
          color: Colors.white,
        ),
        SizedBox(
          width: this.width,
        ),
        Text(
          this.information,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}
