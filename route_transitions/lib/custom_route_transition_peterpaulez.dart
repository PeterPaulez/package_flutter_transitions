import 'package:flutter/material.dart';

const durationDefault = Duration(milliseconds: 300);
enum AnimationType { normal, fadeIn }

/// Main core Class
///
/// [context] is the BuildContext de la app at this moment [child] is the widget to go,
/// [animation] is the type of animation
class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration; // Default transition 300 ms
  final bool replacement; // No replacement by default

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
      case AnimationType.fadeIn:
        this._fadeInTransition();
        break;
    }
  }

  /// Function who decides about [replacement]
  void _pushPageType(Route route) {
    if (this.replacement) {
      Navigator.pushReplacement(this.context, route);
    } else {
      Navigator.push(this.context, route);
    }
  }

  /// Controller of normal transition
  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => this.child);
    this._pushPageType(route);
  }

  /// Controller of fadein transition
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
