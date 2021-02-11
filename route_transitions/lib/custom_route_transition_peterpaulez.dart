import 'package:flutter/material.dart';

// Different types of ROUT TRANSITION
enum AnimationType {
  normal,
  fadeIn,
  slideRight,
  slideLeft,
  slideTop,
  slideBottom
}
// Different types of CURVE
enum CurveType { ease, bounce, decelerate }

/// Main core Class just 2 mandatory FIELDS [context] & [child]
///
/// [context] is the BuildContext de la app at this moment [child] is the widget to go,
/// [animation] is the type of animation [curveType] is the Curve style
/// [replacement] is bool to show back button [curves] is the final Style translated into class
class RouteTransitions {
  final BuildContext context;
  final Widget child;
  final AnimationType animation;
  final Duration duration; // Default transition 300 ms
  final bool replacement; // No replacement by default
  final CurveType curveType;
  Curve curves = Curves.ease;

  RouteTransitions(
      {@required this.context,
      @required this.child,
      this.animation = AnimationType.normal,
      this.duration = const Duration(milliseconds: 300),
      this.curveType = CurveType.ease,
      this.replacement = false}) {
    switch (this.animation) {
      case AnimationType.normal:
        this._normalTransition();
        break;
      case AnimationType.fadeIn:
        this._fadeInTransition();
        break;
      case AnimationType.slideRight:
        this._slideTransition('slideRight');
        break;
      case AnimationType.slideLeft:
        this._slideTransition('slideLeft');
        break;
      case AnimationType.slideTop:
        this._slideTransition('slideTop');
        break;
      case AnimationType.slideBottom:
        this._slideTransition('slideBottom');
        break;
    }
    switch (this.curveType) {
      case CurveType.ease:
        this.curves = Curves.ease;
        break;
      case CurveType.bounce:
        this.curves = Curves.easeInOutBack;
        break;
      case CurveType.decelerate:
        this.curves = Curves.decelerate;
        break;
    }
  }

  /// Navigation PUSH decides about [replacement]
  void _pushPageType(Route route) {
    if (this.replacement) {
      Navigator.pushReplacement(this.context, route);
    } else {
      Navigator.push(this.context, route);
    }
  }

  // Controller of normal transition BORING
  void _normalTransition() {
    final route = MaterialPageRoute(builder: (_) => this.child);
    this._pushPageType(route);
  }

  /// Controller of fadein transition [curves] & [duration]
  void _fadeInTransition() {
    final route = PageRouteBuilder(
      pageBuilder: (_, __, ___) => this.child,
      transitionDuration: this.duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: animation, curve: this.curves),
          ),
          child: child,
        );
      },
    );
    this._pushPageType(route);
  }

  /// Controller of Slide [curves] & [duration] & [offSetBegin]
  void _slideTransition(String type) {
    // Decide direction of animation
    Offset offSetBegin;
    if (type == 'slideRight') {
      offSetBegin = Offset(-1, 0);
    } else if (type == 'slideLeft') {
      offSetBegin = Offset(1, 0);
    } else if (type == 'slideTop') {
      offSetBegin = Offset(0, 1);
    } else if (type == 'slideBottom') {
      offSetBegin = Offset(0, -1);
    }
    final route = PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => this.child,
      transitionDuration: this.duration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var tween = Tween(begin: offSetBegin, end: Offset.zero)
            .chain(CurveTween(curve: this.curves));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
    this._pushPageType(route);
  }
}
