import 'package:flutter/material.dart';
import 'package:custom_route_transition_peterpaulez/custom_route_transition_peterpaulez.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'uno',
      routes: {
        'uno': (_) => UnoPage(),
        'dos': (_) => DosPage(),
      },
    );
  }
}

class UnoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        actions: [],
        title: Text('Page Uno'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            RouteTransitions(
              context: context,
              child: DosPage(),
              animation: AnimationType.fadeIn,
              duration: Duration(milliseconds: 500),
              replacement: true,
              curveType: CurveType.bounce,
            );
          },
          color: Colors.white,
          child: Text('Go to Page Dos'),
        ),
      ),
    );
  }
}

class DosPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        actions: [],
        title: Text('Page Dos'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            RouteTransitions(
              context: context,
              child: UnoPage(),
              animation: AnimationType.normal,
              duration: Duration(milliseconds: 2000),
              replacement: true,
              curveType: CurveType.decelerate,
            );
          },
          color: Colors.white,
          child: Text('Go to Page Uno'),
        ),
      ),
    );
  }
}
