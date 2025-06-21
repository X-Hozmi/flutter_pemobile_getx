import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/image_controller.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatelessWidget {
  VideoPage({super.key});

  final imageController = Get.find<ImageController>();
  final videoPlayerController = VideoPlayerController.file(File(''));

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              width: Size.infinite.width,
              height: 400,
              child:
                  imageController.videoPath == ''
                      ? Image.asset('assets/images/no_video.png')
                      : VideoPlayer(imageController.videoPlayerController),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                imageController.openVideo();
              },
              child: const Text('Record Video'),
            ),
          ],
        ),
      ),
    );
  }
}
