part of '../login_page.dart';

class AuthLogin extends StatefulWidget {
  const AuthLogin(this.tinggiLayar, this.lebarLayar, {super.key});

  final double tinggiLayar;
  final double lebarLayar;

  @override
  State<AuthLogin> createState() => _AuthLoginState();
}

class _AuthLoginState extends State<AuthLogin> {
  final _formKey = GlobalKey<FormState>();

  final obscureText = false.obs;

  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30.0),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: ShaderMask(
                shaderCallback:
                    (bounds) => const LinearGradient(
                      colors: [Color(0xFF0176BC), Color(0xFF3298AF)],
                    ).createShader(bounds),
                child: const Text(
                  'Selamat Datang!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[100]!),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Email atau Handphone",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextFormField(
                        key: const Key('authLoginTextFormFieldEmail'),
                        controller: controller.emailController,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Masukkan email atau handphone",
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          suffixIcon: Icon(
                            Icons.email,
                            color: Colors.grey[400],
                          ),
                          prefixText:
                              controller.emailController.text.isNotEmpty &&
                                      !controller.emailController.text.contains(
                                        RegExp(r'[a-z]'),
                                      ) &&
                                      !controller.emailController.text
                                          .startsWith('0') &&
                                      !controller.emailController.text
                                          .startsWith('@')
                                  ? '+62'
                                  : null,
                          prefixStyle: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Harap mengisi email atau handphone!';
                          }
                          // Validasi untuk email
                          if (value.contains('@')) {
                            if (!controller.validateEmail(value)) {
                              return 'Email tidak valid!';
                            }
                          } else {
                            // Validasi untuk nomor handphone
                            if (value.length < 10) {
                              return 'Nomor handphone harus 10 digit!';
                            }
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Password",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Obx(
                        () => TextFormField(
                          key: const Key('authLoginTextFormFieldPassword'),
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Masukkan Password",
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey[400],
                              ),
                              onPressed: () {
                                obscureText.toggle();
                              },
                            ),
                          ),
                          obscureText: !obscureText.value,
                          validator:
                              (value) =>
                                  value!.isEmpty
                                      ? 'Harap mengisi password!'
                                      : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: const Color.fromRGBO(1, 118, 188, 1),
                    ),
                    child: ElevatedButton(
                      key: const Key('authLoginButton'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await controller.login();
                        }
                      },
                      child: const Text(
                        "Masuk",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
