import 'package:photo_manager/photo_manager.dart';

class AlbumModel {
  final String id;
  final String name;
  final int assetCount;
  final int albumType;
  final DateTime? lastModified;
  final RequestType type;
  final AssetEntity? thumbnail;
  final List<AssetEntity> assets;

  const AlbumModel.raw({
    required this.id,
    required this.name,
    required this.assetCount,
    required this.albumType,
    required this.lastModified,
    required this.type,
    required this.thumbnail,
    required this.assets,
  });

  factory AlbumModel() {
    return const AlbumModel.raw(
      id: '',
      name: '',
      assetCount: 0,
      albumType: 1,
      lastModified: null,
      type: RequestType.common,
      thumbnail: null,
      assets: [],
    );
  }

  AlbumModel copyWith({
    String? id,
    String? name,
    int? assetCount,
    int? albumType,
    DateTime? lastModified,
    RequestType? type,
    AssetEntity? thumbnail,
    List<AssetEntity>? assets,
  }) {
    return AlbumModel.raw(
      id: id ?? this.id,
      name: name ?? this.name,
      assetCount: assetCount ?? this.assetCount,
      albumType: albumType ?? this.albumType,
      lastModified: lastModified ?? this.lastModified,
      type: type ?? this.type,
      thumbnail: thumbnail ?? this.thumbnail,
      assets: assets ?? this.assets,
    );
  }
}
