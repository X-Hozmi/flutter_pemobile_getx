import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/domain/entities/project/project.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/project_controller.dart';
import 'package:flutter_pemobile_getx/utils/constant.dart';
import 'package:flutter_pemobile_getx/utils/state_enum.dart';
import 'package:flutter_pemobile_getx/utils/url_launch.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:responsive_framework/responsive_framework.dart';

part 'parts/fetch_languages.dart';
part 'parts/build_projects_card.dart';
part 'parts/build_projects_content.dart';

class ProjectPage extends StatelessWidget {
  ProjectPage({super.key});

  final ProjectController projectController = Get.find<ProjectController>();

  @override
  Widget build(BuildContext context) {
    if (projectController.projects.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        projectController.getProjects();
      });
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => buildProjectsContent(context, projectController)),
          ],
        ),
      ),
    );
  }
}
