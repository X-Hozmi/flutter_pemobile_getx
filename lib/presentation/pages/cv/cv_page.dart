// import 'dart:developer';
// import 'dart:html' as html;
// import 'dart:typed_data';
// import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/cv_controller.dart';
import 'package:flutter_pemobile_getx/utils/state_enum.dart';
import 'package:flutter_pemobile_getx/utils/url_launch.dart';
import 'package:flutter_pemobile_getx/presentation/widgets/controllers/hover_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'parts/about_section.dart';
part 'parts/compentencies_section.dart';
part 'parts/educations_section.dart';
part 'parts/experiences_section.dart';
part 'parts/header.dart';
part 'parts/info_rows.dart';
part 'parts/skill_chips.dart';
part 'parts/social_links.dart';

class CVPage extends StatefulWidget {
  const CVPage({super.key});

  @override
  State<CVPage> createState() => _CVPageState();
}

class _CVPageState extends State<CVPage> {
  final CVController cvController = Get.find<CVController>();

  @override
  void initState() {
    super.initState();
    cvController.getProfile();
    cvController.getSocials();
    cvController.getWorkExperiences();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (cvController.state == RequestState.loading) {
        return const Center(child: CircularProgressIndicator());
      } else if (cvController.state == RequestState.loaded) {
        return SingleChildScrollView(
          child: SizedBox(
            // width: 800,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildHeader(context, cvController),
                    const SizedBox(height: 32),
                    InkWell(
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap:
                          () => urlLauncher(
                            Uri.parse(
                              cvController.profileEntity!.profile['linkedin'],
                            ),
                          ),
                      child: Column(
                        children: [buildAboutSection(context, cvController)],
                      ),
                    ),
                    const SizedBox(height: 32),
                    buildExperienceSection(context, cvController),
                    const SizedBox(height: 32),
                    buildEducationSection(context, cvController),
                  ],
                ),
              ),
            ),
          ),
        );
      }
      return const SizedBox();
    });
  }
}
