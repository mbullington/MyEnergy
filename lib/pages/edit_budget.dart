import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../data.dart';
import '../theme.dart';

Widget editBudgetDialogBuilder(BuildContext context) {
  final textTheme = Theme.of(context).textTheme;
  final model = ScopedModel.of<Data>(context, rebuildOnChange: true);

  return SimpleDialog(
    title: Text("Edit Monthly Budget"),
    children: <Widget>[
      Padding(padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0), child:
      Column(children: <Widget>[
        Row(children: <Widget>[
          Text("\$${model.budget.toStringAsFixed(0)}"),
          Slider(
            value: model.budget,
            min: 0.0,
            max: 500.0,
            onChanged: (double value) {
              model.budget = value;
            }
          ),
        ], mainAxisSize: MainAxisSize.max, mainAxisAlignment: MainAxisAlignment.center),
        Row(children: <Widget>[
          FlatButton(
              child: Text(
                "DONE",
                style: textTheme.button.copyWith(color: ThemeColors.accentColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ], mainAxisAlignment: MainAxisAlignment.end)
      ])
      )
    ],
  );
}
