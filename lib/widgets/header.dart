import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final String title;

  Header({Key key, @required this.title}): super(key: key);

  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return SizedBox(
      height: 48.0,
      child: Material(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(title, style: textTheme.subhead.copyWith(color: Colors.black45, fontWeight: FontWeight.w500))
          )
        )
      ),
    );
  }
}