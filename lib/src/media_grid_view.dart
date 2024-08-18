import 'package:fastpicker/src/no_media_view.dart';
import 'package:fastpicker/src/utilities/enums/loading_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

import 'models/album_model.dart';
import 'selection_indicator.dart';
import 'utilities/fast_picker_strings.dart';
import 'video_indicator.dart';

class MediaGridView extends HookWidget {
  final AnimationController controller;
  final ScrollPhysics? physics;
  final ValueNotifier<AlbumModel> selectedAlbumRef;
  final ValueNotifier<List<AssetEntity>> selectedMediaRef;
  final ValueNotifier<LoadingStatus> loadingStatusRef;
  final FastPickerStrings strings;
  final void Function(List<AssetEntity>)? onComplete;
  final int maxSelection;

  const MediaGridView({
    required this.controller,
    required this.selectedAlbumRef,
    required this.selectedMediaRef,
    required this.loadingStatusRef,
    required this.maxSelection,
    required this.onComplete,
    required this.physics,
    required this.strings,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final selectedAlbum = useValueListenable(selectedAlbumRef);
    final loadingStatus = useValueListenable(loadingStatusRef);
    final loadingComplete = (loadingStatus == LoadingStatus.complete);

    if (loadingComplete) {
      return (selectedAlbum.assetCount == 0)
          ? NoMediaView(strings: strings)
          : GridView.builder(
              physics: physics,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
              ),
              itemCount: selectedAlbum.assets.length,
              itemBuilder: (context, index) {
                return _GridRow(
                  controller: controller,
                  selectedMediaRef: selectedMediaRef,
                  mediaAsset: selectedAlbum.assets[index],
                  maxSelection: maxSelection,
                  onComplete: onComplete,
                );
              },
            );
    }

    return const SizedBox.shrink();
  }
}

class _GridRow extends StatelessWidget {
  final AssetEntity mediaAsset;
  final AnimationController controller;
  final ValueNotifier<List<AssetEntity>> selectedMediaRef;
  final void Function(List<AssetEntity>)? onComplete;
  final int maxSelection;

  const _GridRow({
    required this.mediaAsset,
    required this.controller,
    required this.selectedMediaRef,
    required this.maxSelection,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Semantics(
        image: true,
        child: InkWell(
          excludeFromSemantics: true,
          onTap: () {
            if (maxSelection == 1 || controller.value == 0) {
              onComplete?.call([mediaAsset]);
              final navigator = Navigator.of(context);
              if (navigator.canPop()) navigator.pop([mediaAsset]);
              return;
            }

            if (selectedMediaRef.value.contains(mediaAsset)) {
              selectedMediaRef.value.remove(mediaAsset);
              selectedMediaRef.value = List.of(selectedMediaRef.value);
            } else if (selectedMediaRef.value.length < maxSelection) {
              selectedMediaRef.value.add(mediaAsset);
              selectedMediaRef.value = List.of(selectedMediaRef.value);
            }
          },
          child: AssetEntityImage(
            mediaAsset,
            isOriginal: false,
            fit: BoxFit.cover,
          ),
        ),
      ),
      builder: (context, child) {
        return GridTile(
          header: ValueListenableBuilder<List<AssetEntity>>(
            valueListenable: selectedMediaRef,
            builder: (context, selectedMedia, child) {
              return SelectionIndicator(
                visible: (controller.value == 1),
                selected: selectedMedia.contains(mediaAsset),
                counter: selectedMedia.indexOf(mediaAsset) + 1,
              );
            },
          ),
          footer: VideoIndicator(mediaAsset),
          child: child!,
        );
      },
    );
  }
}
