# Route Transitions
This package helps how to manage transitions between different views/pages.  
I am going to add more types of transitions, keep posted.

## Use example case
```
/// [context] from the BuildContext
RouteTransitions(
    context: context,
    child: UnoPage(),
    animation: AnimationType.fafeIn,
    duration: Duration(milliseconds: 2000), // Optional value
    replacement: true, // Optional value
);
```
