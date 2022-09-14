import 'package:flutter/material.dart';

///* Transitions ("Teleport")
class Teleport extends PageRouteBuilder {
  /*
? ANWENDUNG: ('child' notwendig, der Rest optional)
      Navigator.push(context,
        Teleport(
          child: Settings(),
          type: "scale_bottomRight",
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 150),
      ));
* Für 'type'-Optionen, siehe 'animationHandler(..)'
  */

  final Widget child;
  final String type;
  final Duration duration;
  final Duration reverseDuration;

  Teleport({
    required this.child,
    this.type = "none",
    this.duration = const Duration(milliseconds: 300),
    this.reverseDuration = const Duration(milliseconds: 200),
  }) : super(
          transitionDuration: duration,
          reverseTransitionDuration: reverseDuration,
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  animationHandler(animation, child) {
    switch (type) {
      case "none":
        return SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(animation),
          child: child,
        );
      case "fade":
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      case "slide_right":
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
          child: child,
        );
      case "slide_left":
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(animation),
          child: child,
        );
      case "slide_top":
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, -1), end: Offset.zero).animate(animation),
          child: child,
        );
      case "slide_bottom":
        return SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
          child: child,
        );
      case "scale_topLeft":
        return ScaleTransition(
          alignment: Alignment.topLeft,
          scale: animation,
          child: child,
        );
      case "scale_topCenter":
        return ScaleTransition(
          alignment: Alignment.topCenter,
          scale: animation,
          child: child,
        );
      case "scale_topRight":
        return ScaleTransition(
          alignment: Alignment.topRight,
          scale: animation,
          child: child,
        );
      case "scale_centerLeft":
        return ScaleTransition(
          alignment: Alignment.centerLeft,
          scale: animation,
          child: child,
        );
      case "scale_center":
        return ScaleTransition(
          alignment: Alignment.center,
          scale: animation,
          child: child,
        );
      case "scale_centerRight":
        return ScaleTransition(
          alignment: Alignment.centerRight,
          scale: animation,
          child: child,
        );
      case "scale_bottomLeft":
        return ScaleTransition(
          alignment: Alignment.bottomLeft,
          scale: animation,
          child: child,
        );
      case "scale_bottomCenter":
        return ScaleTransition(
          alignment: Alignment.bottomCenter,
          scale: animation,
          child: child,
        );
      case "scale_bottomRight":
        return ScaleTransition(
          alignment: Alignment.bottomRight,
          scale: animation,
          child: child,
        );
      default:
        Exception("Teleport()-type '$type' not found.");
        return SlideTransition(
          position: Tween<Offset>(begin: Offset.zero, end: Offset.zero).animate(animation),
          child: child,
        );
    }
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    return animationHandler(animation, child);
  }
}
