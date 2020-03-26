
import 'package:flutter/material.dart';

class NoTransitionPageRoute extends MaterialPageRoute {
  /// Builds the primary contents of the route.
  final WidgetBuilder builder;

  NoTransitionPageRoute({
    @required this.builder,
    RouteSettings settings,
    bool fullscreenDialog = false,
  }) : super(
      builder: builder,
      settings: settings,
      maintainState: true,
      fullscreenDialog: fullscreenDialog);

  @override
  Duration get transitionDuration => const Duration(milliseconds: 0);
}