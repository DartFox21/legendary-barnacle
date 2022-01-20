import 'package:flutter/material.dart';
import 'package:godartadmin/const/colors.dart';
import 'package:godartadmin/view_models/login_vm.dart';
import 'package:godartadmin/widgets/buttons/login_btn.dart';
import 'package:godartadmin/widgets/texts/custom_text.dart';
import 'package:provider/src/provider.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _fKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _fKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: Colors.transparent,
                      child: Image.asset('images/chromelogo.png'),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: const [
                    Text('Login',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      text: 'Welcome back to the admin panel.',
                      color: lightGrey,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'abc@domain.com',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: true,
                  controller: _passController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Field is empty';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: 'Password',
                      hintText: '123',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12))),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 35,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: CustomButton(
                          onPressed: () async {
                            if (_fKey.currentState!.validate()) {
                              await context.read<LoginVM>().login(
                                    email: _usernameController.text.trim(),
                                    password: _passController.text.trim(),
                                  );
                            }
                          },
                          btnColor: const Color(0xFFFB5045),
                          child: context.watch<LoginVM>().isLoading
                              ? const Center(
                                  child: SizedBox(
                                    height: 25,
                                    width: 25,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 3,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : const CustomText(
                                  text: 'Login',
                                  color: Colors.white,
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
