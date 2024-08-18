import 'package:flutter/material.dart';

class SelectionIndicator extends StatelessWidget {
  final bool visible;
  final AlignmentGeometry alignment;
  final EdgeInsetsGeometry margin;
  final bool selected;
  final int counter;

  const SelectionIndicator({
    super.key,
    required this.visible,
    this.margin = const EdgeInsets.only(top: 6, right: 6),
    this.alignment = AlignmentDirectional.topEnd,
    this.selected = false,
    this.counter = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Semantics(
      selected: selected,
      child: AnimatedScale(
        scale: visible ? 1 : 0,
        duration: const Duration(milliseconds: 150),
        child: Align(
          alignment: alignment,
          child: AnimatedContainer(
            width: visible ? 19 : 0,
            height: visible ? 19 : 0,
            margin: margin,
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 150),
            decoration: BoxDecoration(
              color: (selected) ? theme.colorScheme.primary : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 0.5,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Text(
              selected ? counter.toString() : '',
              style: theme.textTheme.labelSmall?.copyWith(
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
