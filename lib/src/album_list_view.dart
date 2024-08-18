import 'package:fastpicker/src/linear_sheet.dart';
import 'package:fastpicker/src/models/album_model.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class AlbumListView extends StatelessWidget {
  final AnimationController controller;
  final ScrollPhysics? physics;
  final ValueNotifier<List<AlbumModel>> albumsRef;
  final ValueNotifier<AlbumModel> selectedAlbumRef;

  const AlbumListView({
    required this.controller,
    required this.albumsRef,
    required this.selectedAlbumRef,
    required this.physics,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LinearSheet(
      controller: controller,
      heightFactor: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: ValueListenableBuilder<List<AlbumModel>>(
          valueListenable: albumsRef,
          builder: (_, albums, __) {
            return ListView.separated(
              physics: physics,
              itemCount: albums.length,
              itemBuilder: (context, index) {
                return _AlbumRow(
                  album: albums[index],
                  onTap: (album) {
                    selectedAlbumRef.value = album;
                    controller.reverse();
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _AlbumRow extends StatelessWidget {
  final AlbumModel album;
  final void Function(AlbumModel) onTap;

  const _AlbumRow({
    required this.album,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      leading: AspectRatio(
        aspectRatio: 1,
        child: (album.thumbnail == null)
            ? const ColoredBox(color: Colors.grey)
            : AssetEntityImage(
                album.thumbnail!,
                isOriginal: false,
                fit: BoxFit.cover,
              ),
      ),
      title: Text(album.name),
      subtitle: Text(album.assetCount.toString()),
      onTap: () => onTap(album),
    );
  }
}
