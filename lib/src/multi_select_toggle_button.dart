import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'models/album_model.dart';
import 'utilities/fast_picker_strings.dart';

class MultiSelectToggleButton extends StatelessWidget {
  final AnimationController controller;
  final ValueNotifier<AlbumModel> selectedAlbumRef;
  final FastPickerStrings strings;

  const MultiSelectToggleButton({
    required this.controller,
    required this.selectedAlbumRef,
    required this.strings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AnimatedBuilder(
      animation: controller,
      child: Tooltip(
        message: strings.toggleMultipleSelectionMode,
        child: ListenableBuilder(
          listenable: controller,
          builder: (context, child) {
            return Semantics(
              button: true,
              toggled: (controller.value == 1),
              label: strings.toggleMultipleSelectionMode,
              child: child,
            );
          },
          child: InkWell(
            customBorder: const CircleBorder(),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.collections, size: 16),
            ),
            onTap: () {
              if (selectedAlbumRef.value.assetCount > 0) {
                if (controller.status == AnimationStatus.dismissed) {
                  controller.forward();
                } else if (controller.status == AnimationStatus.completed) {
                  controller.reverse();
                }
              }
            },
          ),
        ),
      ),
      builder: (context, child) {
        return ValueListenableBuilder<AlbumModel>(
          valueListenable: selectedAlbumRef,
          builder: (context, album, child) {
            return Visibility(
              visible: (album.assetCount > 0),
              child: child!,
            );
          },
          child: Material(
            shape: const CircleBorder(),
            color: theme.colorScheme.tertiaryContainer.withOpacity(
              math.max(0.2, (controller.value / 1)),
            ),
            child: child,
          ),
        );
      },
    );
  }
}
