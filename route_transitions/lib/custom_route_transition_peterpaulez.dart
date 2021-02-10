import 'package:flutter/material.dart';

const durationDefault = Duration(milliseconds: 300);
enum AnimationType { normal, fafeIn }

class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration;
  final bool replacement;

  RouteTransitions({
    @required this.context,
    @required this.child,
    this.animation = AnimationType.normal,
    this.duration = durationDefault,
    this.replacement = false,
  }) {
    switch (this.animation) {
      case AnimationType.normal:
        this._normalTransition();
        break;
      case AnimationType.fafeIn:
        this._fadeInTransition();
        break;
    }
  }

  void _pushPageType(Route route) {
    if (this.replacement) {
      Navigator.pushReplacement(this.context, route);
    } else {
      Navigator.push(this.context, route);
    }
  }

  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => this.child);
    this._pushPageType(route);
  }

  void _fadeInTransition() {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => this.child,
      transitionDuration: this.duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: Curves.easeOut),
          ),
          child: child,
        );
      },
    );
    this._pushPageType(route);
  }
}
