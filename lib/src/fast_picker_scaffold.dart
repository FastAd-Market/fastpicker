import 'package:fastpicker/src/album_list_view.dart';
import 'package:fastpicker/src/extensions/asset_path_entity_extension.dart';
import 'package:fastpicker/src/limited_permission_banner.dart';
import 'package:fastpicker/src/permission_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:photo_manager/photo_manager.dart';

import 'fast_picker_toolbar.dart';
import 'media_grid_view.dart';
import 'models/album_model.dart';
import 'muti_select_banner.dart';
import 'utilities/enums/loading_status.dart';
import 'utilities/fast_picker_strings.dart';

class FastPickerScaffold extends HookWidget {
  final FastPickerStrings strings;
  final int maxSelection;
  final ScrollPhysics? physics;
  final List<String> selectedAssetIds;
  final Widget? closeButton;
  final void Function(List<AssetEntity>)? onComplete;
  final RequestType requestType;
  final FilterOptionGroup? filterOption;

  const FastPickerScaffold({
    required this.strings,
    required this.maxSelection,
    required this.selectedAssetIds,
    required this.onComplete,
    required this.physics,
    required this.closeButton,
    required this.requestType,
    required this.filterOption,
    super.key,
  }) : assert(maxSelection > 0, 'max selection must be greater than or equal to 1');

  @override
  Widget build(BuildContext context) {
    final navigator = Navigator.of(context);
    const duration = Duration(milliseconds: 250);
    const reverseDuration = Duration(milliseconds: 200);

    final albumsRef = useValueNotifier(<AlbumModel>[]);
    final selectedAlbumRef = useValueNotifier(AlbumModel());
    final selectedMediaRef = useValueNotifier(<AssetEntity>[]);
    final loadingStatusRef = useValueNotifier(LoadingStatus.indeterminate);

    final multiSelectController = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
      initialValue: selectedAssetIds.isEmpty ? 0 : 1,
    );

    final albumController = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
    );

    final permissionLimitedController = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
    );

    final permissionController = useAnimationController(
      duration: duration,
      reverseDuration: reverseDuration,
    );

    /// Mark: request permission
    final permission = useFuture(
      initialData: PermissionState.notDetermined,
      useMemoized(PhotoManager.requestPermissionExtend),
    ).data;

    final hasPermission = useMemoized(() {
      final isAuthorized = (permission == PermissionState.authorized);
      final isLimited = (permission == PermissionState.limited);
      return (isAuthorized || isLimited);
    }, [permission]);

    /// Mark: load photos and videos in albums
    Future<void> loadAlbums() async {
      if (albumsRef.value.isEmpty) {
        loadingStatusRef.value = LoadingStatus.loading;
      }

      final assetPathEntities = await PhotoManager.getAssetPathList(
        type: requestType,
        filterOption: filterOption,
      );

      final albumsFuture = assetPathEntities.map((assetPathEntity) async {
        return AlbumModel.raw(
          id: assetPathEntity.id,
          name: assetPathEntity.name,
          albumType: assetPathEntity.albumType,
          lastModified: assetPathEntity.lastModified,
          type: assetPathEntity.type,
          thumbnail: await assetPathEntity.thumbnail,
          assets: await assetPathEntity.assetEntities,
          assetCount: await assetPathEntity.assetCountAsync,
        );
      });

      albumsRef.value = await Future.wait(albumsFuture);

      /// Mark: set default selected album to Recent(s)
      /// or update current album with media changes
      if (albumsRef.value.isNotEmpty) {
        if (selectedAlbumRef.value.id.isEmpty) {
          selectedAlbumRef.value = albumsRef.value.first;
        } else {
          selectedAlbumRef.value = albumsRef.value.firstWhere(
            (e) => (e.id == selectedAlbumRef.value.id),
            orElse: () => albumsRef.value.first,
          );
        }
      }

      if (loadingStatusRef.value == LoadingStatus.loading) {
        loadingStatusRef.value = LoadingStatus.complete;
      }
    }

    /// Mark: load previously selected assets using their ids
    Future<void> loadPreviouslySelectedAssets() async {
      final assetEntities = <AssetEntity>[];
      await Future.forEach(selectedAssetIds, (id) async {
        final tmp = await AssetEntity.fromId(id);
        final exists = (await tmp?.exists) ?? false;
        if (exists) assetEntities.add(tmp!);
      });
      selectedMediaRef.value = assetEntities;
    }

    /// Mark: start loading albums and previously selected assets
    /// when permission is granted or limited (iOS)
    useEffect(() {
      if (hasPermission) {
        loadAlbums();
        loadPreviouslySelectedAssets();
      }
      return;
    }, [hasPermission]);

    /// Mark: show permission state message
    useEffect(() {
      switch (permission) {
        case PermissionState.limited:
          permissionLimitedController.forward();
          break;

        case PermissionState.denied:
        case PermissionState.restricted:
          permissionController.forward();
          break;

        case PermissionState.authorized:
          permissionLimitedController.reverse();
          permissionController.reverse();
          break;

        default:
          break;
      }
      return;
    }, [permission]);

    /// Mark: clear selected media assets when
    /// multi-select mode is turned-off.
    useEffect(() {
      void callback(AnimationStatus status) {
        if (status == AnimationStatus.reverse) {
          selectedMediaRef.value = [];
        }
      }

      multiSelectController.addStatusListener(callback);
      return () => multiSelectController.removeStatusListener(callback);
    }, const []);

    /// Mark: monitor changes in albums and update the
    /// media assets within them.
    useEffect(() {
      if (hasPermission) {
        void callback(_) => loadAlbums();
        PhotoManager.addChangeCallback(callback);
        PhotoManager.startChangeNotify();
        return () {
          PhotoManager.removeChangeCallback(callback);
          PhotoManager.stopChangeNotify();
        };
      }
      return null;
    }, [hasPermission]);

    void onPop() {
      onComplete?.call(selectedMediaRef.value);
      return navigator.pop(selectedMediaRef.value);
    }

    /// Mark: Adds a leading widget to the AppBar.
    /// It defaults to the the CloseButton widget;
    Widget? leadingWidget() {
      if (closeButton != null) {
        return closeButton;
      }

      if (navigator.canPop()) {
        return CloseButton(
          onPressed: onPop,
        );
      }

      return null;
    }

    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) return;
        return onPop();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: leadingWidget(),
          centerTitle: true,
          title: Text(strings.selectMedia),
          bottom: FastPickerToolbar(
            strings: strings,
            visible: hasPermission,
            selectedAlbumRef: selectedAlbumRef,
            loadingStatusRef: loadingStatusRef,
            albumController: albumController,
            multiSelectController: multiSelectController,
            maxSelection: maxSelection,
          ),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LimitedPermissionBanner(
              strings: strings,
              controller: permissionLimitedController,
            ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  MediaGridView(
                    controller: multiSelectController,
                    selectedAlbumRef: selectedAlbumRef,
                    selectedMediaRef: selectedMediaRef,
                    loadingStatusRef: loadingStatusRef,
                    maxSelection: maxSelection,
                    onComplete: onComplete,
                    physics: physics,
                    strings: strings,
                  ),
                  AlbumListView(
                    albumsRef: albumsRef,
                    selectedAlbumRef: selectedAlbumRef,
                    controller: albumController,
                    physics: physics,
                  ),
                ],
              ),
            ),
            MultiSelectBanner(
              strings: strings,
              controller: multiSelectController,
              selectedMediaRef: selectedMediaRef,
              onComplete: onComplete,
              physics: physics,
            ),
          ],
        ),
        bottomSheet: PermissionBottomSheet(
          strings: strings,
          permission: permission,
          controller: permissionController,
        ),
      ),
    );
  }
}
