import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'linear_sheet.dart';
import 'utilities/fast_picker_strings.dart';

class PermissionBottomSheet extends StatelessWidget {
  final FastPickerStrings strings;
  final PermissionState? permission;
  final AnimationController controller;

  const PermissionBottomSheet({
    required this.strings,
    required this.permission,
    required this.controller,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return LinearSheet(
          controller: controller,
          heightFactor: controller.value,
          child: child!,
        );
      },
      child: _PermissionStateInfo(
        theme: Theme.of(context),
        strings: strings,
        permission: permission,
      ),
    );
  }
}

class _PermissionStateInfo extends StatelessWidget {
  final Widget child;

  const _PermissionStateInfo._({
    required this.child,
  });

  factory _PermissionStateInfo({
    required ThemeData theme,
    required PermissionState? permission,
    required FastPickerStrings strings,
  }) {
    switch (permission) {
      case PermissionState.restricted:
        return _PermissionStateInfo.restricted(theme, strings);

      default:
        return _PermissionStateInfo.denied(theme, strings);
    }
  }

  factory _PermissionStateInfo.denied(ThemeData theme, FastPickerStrings strings) {
    return _PermissionStateInfo._(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.pleaseAllowAccessToYourPhotos,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.tertiary,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Text(
                strings.youCanAlwaysChangeThisInYourDeviceSettings,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ),
            Center(
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  foregroundColor: theme.colorScheme.onPrimaryContainer,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  textStyle: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: PhotoManager.openSetting,
                child: Text(
                  strings.allowAccess,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  factory _PermissionStateInfo.restricted(ThemeData theme, FastPickerStrings strings) {
    return _PermissionStateInfo._(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              strings.pleaseAllowAccessToYourPhotos,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.tertiary,
                fontSize: 19,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                strings.accessToYourPhotosIsRestricted,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
