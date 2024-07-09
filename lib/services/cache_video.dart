import 'dart:developer';
import 'dart:io';

import 'package:chat_app/config/helpers/helpers_database.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoService {
  Future<String?> videoCache({String? link}) async {
    final path = File("${helpersFunctions.pathDocument}/${link.hashCode}.jpg");
    if (path.existsSync()) {
      log("message $link");
      return VideoThumbnail.thumbnailFile(
          video: link ?? "",
          thumbnailPath:
              "${helpersFunctions.pathDocument}/${link.hashCode}.jpg",
          imageFormat: ImageFormat.JPEG,
          maxHeight: 150,
          quality: 50);
    } else {
      await path.create();
      return VideoThumbnail.thumbnailFile(
          video: link ?? "",
          thumbnailPath:
              "${helpersFunctions.pathDocument}/${link.hashCode}.jpg",
          imageFormat: ImageFormat.JPEG,
          maxHeight: 150,
          quality: 50);
    }
  }
}
