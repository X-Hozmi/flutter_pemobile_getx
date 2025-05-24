import 'package:flutter_pemobile_getx/app_router.dart';
import 'package:flutter_pemobile_getx/data/datasources/auth_local_data_sources.dart';
import 'package:flutter_pemobile_getx/data/datasources/cv_local_data_sources.dart';
import 'package:flutter_pemobile_getx/data/datasources/db/database_helper.dart';
import 'package:flutter_pemobile_getx/data/datasources/person_local_data_source.dart';
import 'package:flutter_pemobile_getx/data/repositories/auth_repository_impl.dart';
import 'package:flutter_pemobile_getx/data/repositories/cv_repository_impl.dart';
import 'package:flutter_pemobile_getx/data/repositories/person_repository_impl.dart';
import 'package:flutter_pemobile_getx/domain/repositories/auth_repository.dart';
import 'package:flutter_pemobile_getx/domain/repositories/cv_repository.dart';
import 'package:flutter_pemobile_getx/domain/repositories/person/person_repository.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/get_person_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/remove_person_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/person/save_person_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/profile_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/social_usecase.dart';
import 'package:flutter_pemobile_getx/domain/usecases/work_experience_usecase.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/auth_controller.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/cv_controller.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/person_controller.dart';
import 'package:flutter_pemobile_getx/presentation/widgets/controllers/hover_controller.dart';
import 'package:get/get.dart';

void init() {
  // Helpers
  Get.lazyPut<DatabaseHelper>(() => DatabaseHelper(), fenix: true);

  // Data Sources
  Get.lazyPut<CVLocalDataSource>(() => CVLocalDataSourceImpl(), fenix: true);

  Get.lazyPut<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
    fenix: true,
  );

  Get.lazyPut<PersonLocalDataSource>(
    () => PersonLocalDataSourceImpl(databaseHelper: Get.find<DatabaseHelper>()),
    fenix: true,
  );

  // Repositories
  Get.lazyPut<CVRepository>(
    () => CVRepositoryImpl(localDataSource: Get.find<CVLocalDataSource>()),
    fenix: true,
  );

  Get.lazyPut<AuthRepository>(
    () => AuthRepositoryImpl(localDataSource: Get.find<AuthLocalDataSource>()),
    fenix: true,
  );

  Get.lazyPut<PersonRepository>(
    () => PersonRepositoryImpl(
      localDataSource: Get.find<PersonLocalDataSource>(),
    ),
    fenix: true,
  );

  // Use Cases
  Get.lazyPut(() => GetProfile(Get.find<CVRepository>()), fenix: true);
  Get.lazyPut(() => GetSocials(Get.find<CVRepository>()), fenix: true);
  Get.lazyPut(() => GetWorkExperiences(Get.find<CVRepository>()), fenix: true);

  Get.lazyPut(() => GetPerson(Get.find<PersonRepository>()), fenix: true);
  Get.lazyPut(() => SavePerson(Get.find<PersonRepository>()), fenix: true);
  Get.lazyPut(() => RemovePerson(Get.find<PersonRepository>()), fenix: true);

  // Controllers
  Get.lazyPut(
    () => CVController(
      getProfileUseCase: Get.find<GetProfile>(),
      getSocialsUseCase: Get.find<GetSocials>(),
      getWorkExperiencesUseCase: Get.find<GetWorkExperiences>(),
    ),
  );

  Get.lazyPut(
    () => AuthController(
      authRepository: Get.find<AuthRepository>(),
      router: goRouter,
    ),
    fenix: true,
  );

  Get.lazyPut(
    () => PersonController(
      getPersonUseCase: Get.find<GetPerson>(),
      savePersonUseCase: Get.find<SavePerson>(),
      removePersonUseCase: Get.find<RemovePerson>(),
    ),
  );

  Get.lazyPut(() => HoverController());
}
