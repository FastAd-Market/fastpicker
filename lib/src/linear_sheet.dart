import 'package:flutter/material.dart';

class LinearSheet extends StatelessWidget {
  final AnimationController controller;
  final Widget child;
  final double elevation;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? surfaceTintColor;
  final AlignmentGeometry alignment;
  final AlignmentGeometry animationAlignment;
  final double? widthFactor;
  final double? heightFactor;
  final ShapeBorder? shape;
  final Offset begin;
  final Offset end;
  final Curve curve;

  const LinearSheet({
    required this.controller,
    required this.child,
    this.alignment = AlignmentDirectional.bottomStart,
    this.animationAlignment = AlignmentDirectional.topStart,
    this.curve = Curves.fastOutSlowIn,
    this.widthFactor,
    this.heightFactor,
    this.elevation = 0,
    this.backgroundColor,
    this.shadowColor,
    this.surfaceTintColor,
    this.shape,
    this.begin = const Offset(0, 1),
    this.end = Offset.zero,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Tween<Offset>(begin: begin, end: end).animate(
      CurvedAnimation(parent: controller, curve: curve),
    );

    return Align(
      alignment: alignment,
      heightFactor: heightFactor,
      widthFactor: widthFactor,
      child: AnimatedBuilder(
        animation: animation,
        child: Material(
          elevation: elevation,
          color: backgroundColor,
          shadowColor: shadowColor,
          surfaceTintColor: surfaceTintColor,
          shape: shape,
          child: child,
        ),
        builder: (context, child) {
          return Align(
            alignment: animationAlignment,
            heightFactor: curve.transform(controller.value),
            child: child!,
          );
        },
      ),
    );
  }
}
