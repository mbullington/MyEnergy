import "dart:async";

import 'package:flutter/material.dart' hide ProgressIndicator;
import 'package:flutter/rendering.dart';

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';

import './edit_budget.dart';

import './support_page.dart';
import './pay_page.dart';
import './breakdown_page.dart';

import '../widgets/header.dart';
import '../widgets/energy_usage.dart';
import '../widgets/scroll_glue.dart';

import '../theme.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final TextEditingController textController = TextEditingController();

  _onMessageSubmitted(BuildContext context, String message) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportPage(submitted: message)));
  }

  Function _goToPay(BuildContext context) {
    return () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => PayPage()));
    };
  }
 
  Function _goToBreakdown(BuildContext context, [bool drawer = false]) {
    return () {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => BreakdownPage()));
    };
  }

  void _waysToSave() async {
    final url = "https://www.dominionenergy.com/home-and-small-business/ways-to-save";

    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  Widget _buildBillCard(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final title1 = textTheme.display2.copyWith(color: ThemeColors.primaryColor);
    final subhead1 = textTheme.body1.copyWith(color: Colors.black38);

    return Row(children: <Widget>[
      Column(
          children: <Widget>[Hero(tag: "abc", child: Text("\$125.84", style: title1)), Text("\$20 over budget", style: subhead1)],
          crossAxisAlignment: CrossAxisAlignment.start),
      RaisedButton(
          child: Text("PAY >"),
          onPressed: _goToPay(context),
          color: ThemeColors.accentColor,
          textColor: Colors.white)
    ], mainAxisAlignment: MainAxisAlignment.spaceBetween);
  }

  Widget _buildEnergyUsage(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final title2 = textTheme.title.copyWith(color: Colors.green);

    return Stack(alignment: AlignmentDirectional.centerStart, children: <Widget>[
      EnergyUsage(),
      Align(
          alignment: Alignment.centerRight,
          child: Column(children: <Widget>[
            Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text("820 kWh", style: title2)),
            RaisedButton(
                child: Text("BREAKDOWN >"),
                onPressed: _goToBreakdown(context),
                color: ThemeColors.accentColor,
                textColor: Colors.white)
          ], mainAxisAlignment: MainAxisAlignment.center))
    ]);
  }

  Widget _buildTextComposer(BuildContext context) {
    return Hero(tag: "composer", child: SizedBox(
        height: 56.0,
        child: Material(
            type: MaterialType.canvas,
            color: Colors.white,
            elevation: 6.0,
            child: Row(children: <Widget>[
              Flexible(
                  child: TextField(
                      controller: textController,
                      onSubmitted: (text) {
                        _onMessageSubmitted(context, text);
                      },
                      decoration: InputDecoration(
                          hintText: 'Need support? Report an outage?',
                          contentPadding: EdgeInsets.all(16.0) + EdgeInsets.only(top: 2.0),
                          border: InputBorder.none))),
              IconButton(
                  icon: Icon(Icons.camera_alt),
                  onPressed: () {
                  },
                  padding: EdgeInsets.all(8.0) + EdgeInsets.only(right: 8.0)),
              IconButton(
                  icon: Icon(Icons.send, color: ThemeColors.primaryColor),
                  onPressed: () {
                    _onMessageSubmitted(context, textController.text);
                    textController.text = "";
                  },
                  padding: EdgeInsets.all(8.0) + EdgeInsets.only(right: 8.0))
            ], mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.stretch))));
  }

  Widget _buildDrawer(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final avatar1 = textTheme.subhead.copyWith(color: Colors.white);

    return Drawer(
        child: ListView(children: <Widget>[
      Container(
          decoration: BoxDecoration(color: ThemeColors.backgroundAlt),
          padding: EdgeInsets.all(16.0),
          child: Row(children: <Widget>[
            CircleAvatar(backgroundColor: ThemeColors.accentColor, child: Text("M", style: avatar1)),
            Padding(
                padding: EdgeInsets.only(left: 16.0),
                child: Column(children: <Widget>[
                  Text("Hi Matthew Corlew,", style: textTheme.body1),
                  Text("Electric Customer", style: textTheme.body2)
                ], crossAxisAlignment: CrossAxisAlignment.start))
          ])),
      Header(title: "Statements"),
      ListTile(
        title: Text("Pay Statement"),
        leading: Icon(Icons.account_balance),
        onTap: _goToPay(context)
      ),
      ListTile(
        title: Text("Previous Statements"),
        leading: Icon(Icons.history),
        onTap: () {
          showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Previous Statements", style: textTheme.title.copyWith(fontFamily: "RobotoSlab", fontWeight: FontWeight.bold)),
                content: Text("There are no previous statements currently available."),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "DONE",
                      style: textTheme.button.copyWith(color: ThemeColors.accentColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                  )
                ],
              );
            }
          );
        }
      ),
      Header(title: "Usage"),
      ListTile(
        title: Text("Usage Breakdown"),
        leading: Icon(Icons.data_usage),
        onTap: _goToBreakdown(context)
      ),
      ListTile(
        title: Text("Edit Monthly Budget"),
        leading: Icon(Icons.fitness_center),
        onTap: () {
          showDialog<Null>(
            context: context,
            builder: editBudgetDialogBuilder
          );
        }
      ),
      Header(title: "Other"),
      ListTile(
        title: Text("Ways to Save"),
        leading: Icon(Icons.power),
        onTap: () {
          _waysToSave();
        }
      ),
      ListTile(
        title: Text("Configure Notifications"),
        leading: Icon(Icons.notifications),
        onTap: () {
          showDialog<Null>(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Configure Notifications", style: textTheme.title.copyWith(fontFamily: "RobotoSlab", fontWeight: FontWeight.bold)),
                content: Text("This functionality is not currently available."),
                actions: <Widget>[
                  FlatButton(
                    child: Text(
                      "DONE",
                      style: textTheme.button.copyWith(color: ThemeColors.accentColor),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }
                  )
                ],
              );
            }
          );
        }
      ),
      ListTile(
        title: Text("Live Support"),
        leading: Icon(Icons.hearing),
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SupportPage(submitted: "")));
        }
      ),
      Padding(
          padding: EdgeInsets.all(16.0),
          child: RaisedButton(
              child: Text("LOG OUT"), onPressed: () {}, color: ThemeColors.accentColor, textColor: Colors.white))
    ]));
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final display =
        textTheme.display2.copyWith(color: Colors.black87, fontFamily: "RobotoSlab", fontWeight: FontWeight.bold);

    return Scaffold(
      appBar: AppBar(
          backgroundColor: ThemeColors.background,
          textTheme: getTextTheme(),
          centerTitle: true,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black)),
      drawer: _buildDrawer(context),
      body: Column(children: <Widget>[
        Flexible(
            child: RefreshIndicator(onRefresh: () => Future.delayed(Duration(seconds: 1)), child: CustomScrollView(
              physics: kPhysics,
          slivers: <Widget>[
            ScrollGlueWidgetList(widgets: <Widget>[
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Align(alignment: Alignment.center, child: Text("My Energy", style: display)))
            ]),
            SliverStickyHeader(
                header: Header(title: "My Bill"),
                sliver: ScrollGlueWidgetList(
                    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                    widgets: <Widget>[_buildBillCard(context)])),
            SliverStickyHeader(
                header: Header(title: "My Usage"),
                sliver: ScrollGlueWidgetList(
                    padding: EdgeInsets.symmetric(horizontal: 16.0) + EdgeInsets.only(right: 16.0),
                    widgets: <Widget>[_buildEnergyUsage(context)]))
          ],
        ))),
        _buildTextComposer(context)
      ]),
    );
  }
}
