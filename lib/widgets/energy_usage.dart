import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:scoped_model/scoped_model.dart';

import './progress_indicator.dart';

import '../data.dart';
import '../theme.dart';

class EnergyUsage extends StatelessWidget {
  EnergyUsage({Key key}): super(key: key);

  Widget build(BuildContext context) {
    final model = ScopedModel.of<Data>(context, rebuildOnChange: true);

    final TextTheme textTheme = Theme.of(context).textTheme;

    final progress = 77 / model.budget;

    final title1 = textTheme.display2.copyWith(color: progress < 1.0 ? ThemeColors.primaryColor : Colors.red);
    final subhead1 = textTheme.body1.copyWith(color: Colors.black38);

    return Hero(tag: Key("EnergyUsage"), child: Stack(
      alignment: AlignmentDirectional.centerStart,
      children: <Widget>[
        ProgressIndicator(progress: progress, total: 1.0, size: 200.0),
        SizedBox(
          width: 200.0,
          child: Column(
            children: <Widget>[
              Text("\$77", style: title1),
              Text("\$${model.budget.toStringAsFixed(0)} budget", style: subhead1)
            ],
            mainAxisAlignment: MainAxisAlignment.center
          )
        )
      ]
    ));
  }
}