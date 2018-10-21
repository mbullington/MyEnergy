import 'package:flutter/material.dart';

import 'package:scoped_model/scoped_model.dart';

import 'pages/home_page.dart';

import 'data.dart';
import 'theme.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<Data>(
      model: Data(),
      child: MaterialApp(
        title: 'My Dominion',
        theme: getTheme(),
        home: HomePage(title: 'My Dominion')
      )
    );
  }
}

void main() => runApp(MyApp());