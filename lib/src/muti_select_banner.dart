import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import 'linear_sheet.dart';
import 'utilities/fast_picker_strings.dart';

class MultiSelectBanner extends StatelessWidget {
  final AnimationController controller;
  final ValueNotifier<List<AssetEntity>> selectedMediaRef;
  final void Function(List<AssetEntity>)? onComplete;
  final ScrollPhysics? physics;
  final FastPickerStrings strings;

  const MultiSelectBanner({
    required this.strings,
    required this.controller,
    required this.selectedMediaRef,
    required this.onComplete,
    required this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);

    return LinearSheet(
      elevation: 8,
      controller: controller,
      alignment: AlignmentDirectional.bottomStart,
      animationAlignment: AlignmentDirectional.topStart,
      child: SafeArea(
        child: ValueListenableBuilder<List<AssetEntity>>(
          valueListenable: selectedMediaRef,
          child: Text(strings.done),
          builder: (context, mediaAssets, child) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SelectedAssetsPreview(
                  strings: strings,
                  physics: physics,
                  mediaAssets: mediaAssets,
                  onPressed: (index) {
                    selectedMediaRef.value.removeAt(index);
                    selectedMediaRef.value = List.of(selectedMediaRef.value);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(strings.addUpTo10PhotosAndVideos),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          elevation: 0,
                          minimumSize: Size.zero,
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                            horizontal: 16,
                          ),
                        ),
                        onPressed: mediaAssets.isEmpty
                            ? null
                            : () {
                                onComplete?.call(mediaAssets);
                                if (navigator.canPop()) navigator.pop(mediaAssets);
                              },
                        child: Text(strings.done),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class SelectedAssetsPreview extends StatelessWidget {
  final ScrollPhysics? physics;
  final List<AssetEntity> mediaAssets;
  final void Function(int) onPressed;
  final FastPickerStrings strings;

  const SelectedAssetsPreview({
    required this.physics,
    required this.mediaAssets,
    required this.onPressed,
    required this.strings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      child: SizedBox.fromSize(
        size: Size.fromHeight(mediaAssets.isEmpty ? 0 : 56),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          physics: physics,
          scrollDirection: Axis.horizontal,
          itemCount: mediaAssets.length,
          itemBuilder: (context, index) {
            return AspectRatio(
              aspectRatio: 1,
              child: Material(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(width: 0, color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AssetEntityImage(
                      mediaAssets[index],
                      isOriginal: false,
                      fit: BoxFit.cover,
                    ),
                    ColoredBox(
                      color: Colors.black26,
                      child: IconButton(
                        color: Colors.white,
                        iconSize: 16,
                        splashRadius: 16,
                        tooltip: '${strings.removePhoto} $index',
                        icon: const Icon(Icons.close),
                        padding: EdgeInsets.zero,
                        alignment: AlignmentDirectional.topEnd,
                        onPressed: () => onPressed(index),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (_, __) {
            return const Padding(
              padding: EdgeInsets.only(right: 8),
            );
          },
        ),
      ),
    );
  }
}
