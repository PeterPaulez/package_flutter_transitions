# Route Transitions
This package helps how to manage transitions between different views/pages.  
I am going to add more types of transitions, keep posted.

## Use example case
```dart
/// [context] from the BuildContext
/// [child] destiny widget
/// [animation] type of transition to show
RouteTransitions(
    context: context,
    child: UnoPage(),
    animation: AnimationType.fadeIn,
    duration: Duration(milliseconds: 2000), // Optional value
    replacement: true, // Optional value
    curveType: CurveType.decelerate, // Optional value
);
```

# Video Example
<img src="https://github.com/PeterPaulez/repository/blob/main/api_login_app-1615120214725.gif?raw=true" width="400px">