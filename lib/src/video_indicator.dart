import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';

class VideoIndicator extends StatelessWidget {
  final AssetEntity mediaAsset;

  const VideoIndicator(
    this.mediaAsset, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Visibility(
      visible: mediaAsset.type == AssetType.video,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.videocam_rounded,
              color: Colors.white,
              size: 16,
              shadows: [BoxShadow(blurRadius: 1)],
            ),
            Text(
              mediaAsset.videoDuration.toString().substring(0, 7),
              style: theme.textTheme.bodySmall?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                shadows: [const BoxShadow(blurRadius: 1)],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
