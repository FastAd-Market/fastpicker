import 'package:flutter/material.dart';

import 'utilities/fast_picker_strings.dart';

class NoMediaView extends StatelessWidget {
  final FastPickerStrings strings;

  const NoMediaView({
    required this.strings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 4,
                color: theme.colorScheme.tertiary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Icon(
                Icons.photo_outlined,
                size: 60,
                color: theme.colorScheme.tertiary,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24, bottom: 8),
            child: Text(
              strings.noMedia,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.tertiary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            strings.yourPhotosAndVideosWillAppear,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
