import 'package:flutter/material.dart' hide ProgressIndicator;

import './edit_budget.dart';

import '../widgets/header.dart';
import '../widgets/energy_usage.dart';
import '../widgets/scroll_glue.dart';

import '../theme.dart';

class Appliance {
  final String name;
  final String image;

  final double dollarAmount;
  final double powerAmount;

  Appliance({@required this.name, this.image, @required this.dollarAmount, @required this.powerAmount});
}

final List<Appliance> appliances = [
  Appliance(name: "HVAC", image: "assets/hvac.png", dollarAmount: 47.87, powerAmount: 432),
  Appliance(name: "Refrigerator", image: "assets/fridge.png", dollarAmount: 2.33, powerAmount: 21),
  Appliance(name: "Tesla Model 3", image: "assets/ev.png", dollarAmount: 14.40, powerAmount: 130),
  Appliance(name: "Hot Tub", image: "assets/bath.png", dollarAmount: 1.33, powerAmount: 12),
  Appliance(name: "Other", dollarAmount: 11.8, powerAmount: 100)
];

class BreakdownPage extends StatefulWidget {
  @override
  _BreakdownPage createState() => _BreakdownPage();
}

class _BreakdownPage extends State<BreakdownPage> {
  Widget _buildEnergyUsage(BuildContext context) {
    return Center(child: EnergyUsage());
  }

  Widget build(BuildContext context) {
    final textTheme = getTextTheme();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text("Usage Breakdown"),
            textTheme:
                TextTheme(title: textTheme.title.copyWith(fontFamily: "RobotoSlab", fontWeight: FontWeight.bold)),
            elevation: 1.0,
            iconTheme: IconThemeData(color: Colors.black)),
        body: CustomScrollView(
          physics: kPhysics,
          slivers: <Widget>[
            ScrollGlueWidgetList(padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0), widgets: <Widget>[
              _buildEnergyUsage(context),
              Row(children: <Widget>[
                Header(title: "October 1st thru 31st"),
                FlatButton(
                    child: Text(
                      "EDIT BUDGET >",
                      style: textTheme.button.copyWith(color: ThemeColors.accentColor),
                    ),
                    onPressed: () {
          showDialog<Null>(
            context: context,
            builder: editBudgetDialogBuilder
          );
        })
              ], mainAxisAlignment: MainAxisAlignment.spaceBetween)
            ]),
            ScrollGlueWidgetList(
              widgets: <Widget>[
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  child: Header(title: "Breakdown"),
                  decoration: BoxDecoration(
                    border: Border(
                      top: Divider.createBorderSide(context, color: Theme.of(context).dividerColor, width: 0.0),
                    ),
                  ),
                )
              ],
            ),
            ScrollGlueList<Appliance>(
              data: appliances,
              builder: (context, data, i, first, last) {
                return ListTile(
                    leading: data.image == null ? Container(width: 36.0, height: 36.0) : Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(image: DecorationImage(image: AssetImage(data.image))),
                    ),
                    title: Text(data.name),
                    subtitle: Text("\$${data.dollarAmount.toStringAsFixed(2)} | ${data.powerAmount.toStringAsFixed(2)} kWh"),);
              },
              padding: EdgeInsets.symmetric(vertical: 8.0),
              divider: ScrollGlueDivider.divided,
            )
          ],
        ));
  }
}
