import 'package:flutter/widgets.dart';
import 'package:flutter_pemobile_getx/domain/entities/person/person.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/get_person_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/remove_person_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/save_person_usecase.dart';
import 'package:flutter_pemobile_getx/utils/state_enum.dart';
import 'package:get/get.dart';

class PersonController extends GetxController {
  final GetPerson getPersonUseCase;
  final SavePerson savePersonUseCase;
  final RemovePerson removePersonUseCase;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final handphoneController = TextEditingController();
  final addressController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxBool obscurePassword = true.obs;
  final RxBool obscureConfirmPassword = true.obs;
  final RxBool isEditMode = false.obs;
  final RxBool isLoading = false.obs;

  final Rx<RequestState> _state = RequestState.initial.obs;
  final RxString _message = ''.obs;
  final Rxn<List<Person>> _personEntity = Rxn<List<Person>>();

  RequestState get state => _state.value;
  String get message => _message.value;
  List<Person>? get personEntity => _personEntity.value;

  bool get isError => _state.value == RequestState.error;
  bool get isLoaded => _state.value == RequestState.loaded;
  bool get hasData =>
      _personEntity.value != null && _personEntity.value!.isNotEmpty;

  PersonController({
    required this.getPersonUseCase,
    required this.savePersonUseCase,
    required this.removePersonUseCase,
  });

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    handphoneController.dispose();
    addressController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> getPerson() async {
    _state.value = RequestState.loading;
    update();

    final result = await getPersonUseCase.execute();

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = '';
        _personEntity.value = success;
      },
    );

    update();
  }

  Future<void> savePerson(Person person) async {
    _state.value = RequestState.loading;
    update();

    final result = await savePersonUseCase.execute(person);

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = success;
        getPerson();
      },
    );

    update();
  }

  Future<void> removePerson(Person person) async {
    _state.value = RequestState.loading;
    update();

    final result = await removePersonUseCase.execute(person);

    result.fold(
      (failure) {
        _state.value = RequestState.error;
        _message.value = failure.message;
      },
      (success) {
        _state.value = RequestState.loaded;
        _message.value = success;
        getPerson();
      },
    );

    update();
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    obscureConfirmPassword.value = !obscureConfirmPassword.value;
  }

  void setLoading(bool loading) {
    isLoading.value = loading;
  }

  void setEditMode(bool editMode) {
    isEditMode.value = editMode;

    if (!editMode) {
      nameController.clear();
      emailController.clear();
      handphoneController.clear();
      addressController.clear();
      passwordController.clear();
      confirmPasswordController.clear();
    }
  }

  void clearError() {
    if (_state.value == RequestState.error) {
      _state.value = RequestState.initial;
      _message.value = '';
      update();
    }
  }
}
