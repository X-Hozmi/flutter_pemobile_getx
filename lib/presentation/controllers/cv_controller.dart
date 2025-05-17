import 'package:get/get.dart';
import 'package:flutter_pemobile_getx/domain/entities/profile_entity.dart';
import 'package:flutter_pemobile_getx/domain/usecases/profile_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/social_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/work_experience_usecase.dart';
import 'package:flutter_pemobile_getx/utils/state_enum.dart';

class CVController extends GetxController {
  final GetProfile getProfileUseCase;
  final GetSocials getSocialsUseCase;
  final GetWorkExperiences getWorkExperiencesUseCase;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final Rxn<ProfileEntity> _profileEntity = Rxn<ProfileEntity>();
  final RxList<Map<String, dynamic>> _socials = RxList<Map<String, dynamic>>([
    {},
  ]);
  final RxList<Map<String, dynamic>> _workExperiences =
      RxList<Map<String, dynamic>>([{}]);

  RequestState get state => _state.value;
  String get message => _message.value;
  ProfileEntity? get profileEntity => _profileEntity.value;
  List<Map<String, dynamic>> get socials => _socials;
  List<Map<String, dynamic>> get workExperiences => _workExperiences;

  CVController({
    required this.getProfileUseCase,
    required this.getSocialsUseCase,
    required this.getWorkExperiencesUseCase,
  });

  Future<void> getProfile() async {
    _state.value = RequestState.loading;
    update();

    final result = await getProfileUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = '';
        _profileEntity.value = success;
      },
    );

    update();
  }

  Future<void> getSocials() async {
    _state.value = RequestState.loading;
    update();

    final result = await getSocialsUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = '';
        _socials.value = success;
      },
    );

    update();
  }

  Future<void> getWorkExperiences() async {
    _state.value = RequestState.loading;
    update();

    final result = await getWorkExperiencesUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = '';
        _workExperiences.value = success;
      },
    );

    update();
  }
}
