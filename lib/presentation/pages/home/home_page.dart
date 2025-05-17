import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  final String url =
      'https://media2.dev.to/dynamic/image/width=1000,height=420,fit=cover,gravity=auto,format=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2Ffxfmwr62jp7uz11xgqmq.png';

  final String title = 'A Comprehensive Introduction to CI/CD Pipelines';

  final String description =
      'Pipelines for continuous integration, delivery, and deployment are extremely useful when producing high-quality software promptly. Basically, the automation of CI/CD helps you create better code more quickly and securely. In this article, I’ll describe what CI/CD means, the CI/CD pipeline workflow, the benefits, how to implement a good CI/CD pipeline, and how CI/CD fits into the DevOps universe.';

  final String definitions = """
  CI/CD is the acronym for the words Continuous Integration, Continuous Delivery, and Continuous Deployment which are modern development techniques that help optimize software development processes. The CI/CD process involves automatically integrating code updates from several developers into a single codebase.

  Using CI/CD, teams can provide updates to their code more frequently and coherently, and errors are found earlier. Thus the coding, testing, and development procedures have been streamlined thanks to CI/CD.
  """;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.network(url),
        Container(
          margin: EdgeInsets.all(20),
          child: Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Introduction',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(description, textAlign: TextAlign.justify),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'CI/CD Definition',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(definitions, textAlign: TextAlign.justify),
        ),
      ],
    );
  }
}
