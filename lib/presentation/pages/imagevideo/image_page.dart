import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/image_controller.dart';
import 'package:flutter_pemobile_getx/presentation/pages/imagevideo/video_page.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ImageVideoPage extends StatelessWidget {
  ImageVideoPage({super.key});

  final imageController = Get.find<ImageController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Images & Videos'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.image), text: 'Image Page'),
              Tab(icon: Icon(Icons.video_camera_back), text: 'Video Page'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            ImagePageContent(imageController: imageController),
            VideoPage(),
          ],
        ),
      ),
    );
  }
}

class ImagePageContent extends StatelessWidget {
  final ImageController imageController;

  const ImagePageContent({super.key, required this.imageController});

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
                  (imageController.imagePath == '' &&
                          imageController.videoPath == '')
                      ? Image.asset('assets/images/no_image.png')
                      : (imageController.imagePath != '')
                      ? Image.file(File(imageController.imagePath))
                      : VideoPlayer(imageController.videoPlayerController),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await imageController.openCamera();
                  },
                  child: const Text('Take Picture'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () async {
                    await imageController.openVideo();
                  },
                  child: const Text('Record Video'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
