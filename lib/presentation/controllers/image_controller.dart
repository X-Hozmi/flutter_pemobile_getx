import 'dart:io';

import 'package:flutter_pemobile_getx/utils/state_enum.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ImageController extends GetxController {
  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final RxString _imagePath = ''.obs;
  final RxString _videoPath = ''.obs;
  var _videoPlayerController = VideoPlayerController.file(File(''));

  RequestState get state => _state.value;
  String get message => _message.value;
  String get imagePath => _imagePath.value;
  String get videoPath => _videoPath.value;
  VideoPlayerController get videoPlayerController => _videoPlayerController;

  ImageController();

  Future<void> openCamera() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    _imagePath.value = pickedImage?.path ?? '';
  }

  Future<void> openVideo() async {
    final pickedVideo = await ImagePicker().pickVideo(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
    );
    _videoPath.value = pickedVideo?.path ?? '';

    _videoPlayerController = VideoPlayerController.file(File(_videoPath.value));

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
  }
}
