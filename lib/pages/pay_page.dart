import 'package:flutter/material.dart' hide ProgressIndicator;

import '../widgets/header.dart';
import '../widgets/scroll_glue.dart';

import '../theme.dart';

class PayPage extends StatefulWidget {
  @override
  _PayPage createState() => _PayPage();
}

class _PayPage extends State<PayPage> {
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final title1 = textTheme.display2.copyWith(color: ThemeColors.primaryColor);
  
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("Pay Statement"),
          textTheme: TextTheme(title: textTheme.title.copyWith(fontFamily: "RobotoSlab", fontWeight: FontWeight.bold)),
          elevation: 1.0,
          iconTheme: IconThemeData(color: Colors.black)),
      body: CustomScrollView(
          physics: kPhysics,
          slivers: <Widget>[
            ScrollGlueWidgetList(
              padding: EdgeInsets.symmetric(vertical: 32.0),
              widgets: <Widget>[
                Center(child: Hero(tag: "abc", child: Text("\$125.84", style: title1)))
              ]
            ),
            ScrollGlueWidgetList(
              padding: EdgeInsets.symmetric(vertical: 8.0) + EdgeInsets.only(bottom: 56.0),
              widgets: <Widget>[
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  child: Header(title: "Charges"),
                  decoration: BoxDecoration(
                    border: Border(
                      top: Divider.createBorderSide(context, color: Theme.of(context).dividerColor, width: 0.0),
                    ),
                  ),
                )
              ]..addAll(ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ListTile(
                    title: Text("Basic Customer Charge"),
                    trailing: Text("\$6.73")
                  ),
                  ListTile(
                    title: Text("First 800 kWh"),
                    subtitle: Text("\$0.021558 per kWh"),
                    trailing: Text("\$17.25")
                  ),
                  ListTile(
                    title: Text("Over 800 kWh"),
                    subtitle: Text("\$0.012212 per kWh"),
                    trailing: Text("\$3.87")
                  )
                ]
              ))..addAll([
                DecoratedBox(
                  position: DecorationPosition.foreground,
                  child: Header(title: "Consumption Tax"),
                  decoration: BoxDecoration(
                    border: Border(
                      top: Divider.createBorderSide(context, color: Theme.of(context).dividerColor, width: 0.0),
                    ),
                  ),
                )
              ])..addAll(ListTile.divideTiles(
                context: context,
                tiles: <Widget>[
                  ListTile(
                    title: Text("0 to 2,500 kWh")
                  ),
                  ListTile(
                    leading: SizedBox(width: 18.0, height: 18.0),
                    title: Text("State Consumption"),
                    subtitle: Text("\$0.00102 per kWh"),
                    trailing: Text("\$1.14")
                  ),
                  ListTile(
                    leading: SizedBox(width: 18.0, height: 18.0),
                    title: Text("Special Regulatory"),
                    subtitle: Text("\$0.00012 per kWh"),
                    trailing: Text("\$0.13")
                  ),
                  ListTile(
                    leading: SizedBox(width: 18.0, height: 18.0),
                    title: Text("Local Consumption"),
                    subtitle: Text("\$0.00038 per kWh"),
                    trailing: Text("\$0.42")
                  ),
                  ListTile(
                    title: Text("Other (see full bill)"),
                    trailing: Text("\$90")
                  ),
                ]
              ))
            )
          ]
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        elevation: 6.0,
        icon: Icon(Icons.payment),
        label: Text("CONFIRM PAYMENT"),
        backgroundColor: Colors.green,
        onPressed: () {
          
        },
      ),
    );
  }
}