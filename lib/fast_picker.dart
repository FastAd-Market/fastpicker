import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

import 'src/fast_picker_scaffold.dart';
import 'src/utilities/fast_picker_strings.dart';

export 'src/utilities/fast_picker_strings.dart';
export 'package:photo_manager/photo_manager.dart'
    show
        AssetEntity,
        AssetPathEntity,
        AssetType,
        ThumbnailFormat,
        ThumbnailSize,
        ResizeMode,
        RequestType,
        ImageFileType,
        FilterOptionGroup,
        CustomFilter,
        FilterOption,
        SizeConstraint,
        DurationConstraint,
        OrderOption,
        DateTimeCond;

export 'package:photo_manager_image_provider/photo_manager_image_provider.dart'
    show AssetEntityImage, AssetEntityImageProvider;

class FastPicker extends StatelessWidget {
  final ThemeData theme;
  final FastPickerStrings strings;
  final int maxSelection;
  final ScrollPhysics? physics;
  final List<String> selectedAssets;
  final Widget? closeButton;
  final RequestType requestType;
  final void Function(List<AssetEntity>)? onComplete;
  final FilterOptionGroup? filterOption;

  const FastPicker({
    required this.theme,
    this.strings = const FastPickerStrings(),
    this.maxSelection = 10,
    this.selectedAssets = const [],
    this.onComplete,
    this.physics,
    this.closeButton,
    this.requestType = RequestType.common,
    this.filterOption,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: theme.copyWith(
        bannerTheme: const MaterialBannerThemeData(
          dividerColor: Colors.transparent,
        ),
        bottomSheetTheme: const BottomSheetThemeData(
          shape: Border(),
        ),
      ),
      child: FastPickerScaffold(
        maxSelection: maxSelection,
        selectedAssetIds: selectedAssets,
        onComplete: onComplete,
        physics: physics,
        strings: strings,
        closeButton: closeButton,
        requestType: requestType,
        filterOption: filterOption,
      ),
    );
  }
}
