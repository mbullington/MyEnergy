import "package:flutter/material.dart";
import "package:flutter/foundation.dart";

// Should be used for CustomScrollView when used in your app.
const kPhysics = const AlwaysScrollableScrollPhysics(parent: const BouncingScrollPhysics());

// Used by ScrollGlueGrid.
const kGridPadding = const EdgeInsets.all(16.0);
const kGridSpacing = 8.0;
const kGridAspectRatio = 3 / 4;

typedef Widget ScrollGlueWidgetBuilder<T>(BuildContext context, T entry, int i, bool first, bool last);

enum ScrollGlueDivider { none, divided }

enum ScrollGlueDismissable { none, linear }

class ScrollGlueWidgetList extends StatelessWidget {
  final List<Widget> widgets;

  final EdgeInsets padding;

  ScrollGlueWidgetList({Key key, @required this.widgets, this.padding: const EdgeInsets.all(0.0)}) : super(key: key);

  Widget build(BuildContext context) => SliverPadding(
      padding: padding,
      sliver: SliverList(delegate: SliverChildListDelegate(widgets)));
}

class ScrollGlueList<T> extends StatelessWidget {
  final List<T> data;
  final ScrollGlueWidgetBuilder builder;

  final Widget header;

  final ScrollGlueWidgetBuilder backgroundBuilder;

  final EdgeInsets padding;

  final ScrollGlueDismissable dismissable;
  final ScrollGlueDivider divider;

  ScrollGlueList(
      {Key key,
      @required this.data,
      @required this.builder,
      this.header,
      this.backgroundBuilder,
      this.dismissable: ScrollGlueDismissable.none,
      this.divider: ScrollGlueDivider.none,
      this.padding})
      : super(key: key);

  Widget _itemBuilder(BuildContext context, int index) {
    if (header != null) {
      if (index == 0) {
        return header;
      }

      index--;
    }

    final entry = data[index];

    final first = index == 0;
    final last = index == data.length - 1;

    Widget widget = builder(context, entry, index, first, last);

    if (dismissable != ScrollGlueDismissable.none) {
      Widget background = backgroundBuilder ?? backgroundBuilder(context, entry, index, first, last);

      if (dismissable == ScrollGlueDismissable.linear) {
        widget = Dismissible(key: Key("${index}_dismissible"), child: widget, background: background);
      }
    }

    if (divider == ScrollGlueDivider.divided && !last) {
      widget = DecoratedBox(
          position: DecorationPosition.foreground,
          child: widget,
          decoration: BoxDecoration(border: Border(bottom: Divider.createBorderSide(context, width: 1.0))));
    }

    return widget;
  }

  Widget build(BuildContext context) => SliverPadding(
      padding: padding,
      sliver: SliverList(
          delegate: SliverChildBuilderDelegate(_itemBuilder, childCount: data.length + (header != null ? 1 : 0))));
}

class ScrollGlueGrid<T> extends StatelessWidget {
  final List<T> data;
  final ScrollGlueWidgetBuilder builder;
  final ScrollGlueWidgetBuilder backgroundBuilder;
  final ScrollGlueDismissable dismissable;

  ScrollGlueGrid(
      {Key key,
      @required this.data,
      @required this.builder,
      this.backgroundBuilder,
      this.dismissable: ScrollGlueDismissable.none})
      : super(key: key);

  Widget _itemBuilder(BuildContext context, int index) {
    final entry = data[index];

    final first = index == 0;
    final last = index == data.length - 1;

    Widget widget = builder(context, entry, index, first, last);

    if (dismissable != ScrollGlueDismissable.none) {
      Widget background = backgroundBuilder ?? backgroundBuilder(context, entry, index, first, last);

      if (dismissable == ScrollGlueDismissable.linear) {
        widget = Dismissible(key: Key("${index}_dismissible"), child: widget, background: background);
      }
    }

    return widget;
  }

  Widget build(BuildContext context) => SliverPadding(
      padding: kGridPadding,
      sliver: SliverGrid(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kGridSpacing,
              crossAxisSpacing: kGridSpacing,
              childAspectRatio: kGridAspectRatio),
          delegate: SliverChildBuilderDelegate(_itemBuilder, childCount: data.length)));
}
