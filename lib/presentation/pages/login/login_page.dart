import 'package:flutter/material.dart';
import 'package:flutter_pemobile_getx/presentation/controllers/auth_controller.dart';
import 'package:get/get.dart';

part 'parts/auth_login.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tinggiLayar = MediaQuery.of(context).size.height;
    final lebarLayar = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          key: const Key('loginPageColumn'),
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Center(
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/images/logo.png',
                            width: 300,
                            height: 300,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // coverage:ignore-start
            AuthLogin(tinggiLayar, lebarLayar),
            // coverage:ignore-end
          ],
        ),
      ),
    );
  }
}
