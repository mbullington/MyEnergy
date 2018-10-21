import 'package:flutter/material.dart';

import '../theme.dart';

class ProgressIndicator extends StatelessWidget {
  final double progress;
  final double total;

  final double size;

  ProgressIndicator({Key key, @required this.progress, @required this.total, @required this.size}): super(key: key);

  Widget _buildProgressIndicator(BuildContext context, double value, Color color) {
    return Container(
      width: size,
      height: size,
      padding: EdgeInsets.all(16.0),
      child: CircularProgressIndicator(
        value: value,
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: 6.0
      )
    );
  }

  Widget build(BuildContext context) {
    final value = progress / total;

    return Stack(alignment: Alignment.center, children: <Widget>[
      _buildProgressIndicator(context, 1.0, Colors.black.withAlpha(10)),
      _buildProgressIndicator(context, value > 1.0 ? value - 1.0 : value, value < 1.0 ? ThemeColors.primaryColor: Colors.red),
    ]);
  }
}