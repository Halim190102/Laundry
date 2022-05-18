import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:mini_project/Component/Theme/theme.dart';
import 'package:mini_project/Views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordControllerConfirm = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible1 = true;
  bool _passwordVisible2 = true;
  bool submit1 = true;
  bool submit2 = true;
  bool submit3 = true;
  bool isloading = false;

  late SharedPreferences logindata;
  late bool newRegis;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordControllerConfirm.dispose();
    super.dispose();
  }

  void checkRegis() async {
    logindata = await SharedPreferences.getInstance();
    newRegis = logindata.getBool('regis') ?? true;
    if (newRegis == false) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
          (route) => false);
    }
  }

  @override
  void initState() {
    super.initState();
    checkRegis();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: isloading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: ThemesColor().purple,
              padding: const EdgeInsets.all(35),
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 70),
                    Image.asset('assets/login_asset/icon_register.png'),
                    const SizedBox(height: 15),
                    const Text(
                      'Daftar',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(0, 2.5),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    textField(
                      controller: _emailController,
                      lable: 'Email',
                      valid: (value) {
                        if (value!.isEmpty) {
                          return 'Enter some Email';
                        } else if (!EmailValidator.validate(value)) {
                          return 'Masukkan format yang sesuai';
                        }
                        return null;
                      },
                      submit: submit1
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChange: (e) {
                        setState(() {
                          !submit1;
                        });
                        return null;
                      },
                      boolean: false,
                    ),
                    textField(
                      controller: _passwordController,
                      lable: 'Password',
                      valid: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be null';
                        } else if (value.length < 8) {
                          return 'Enter at least 8 Characters';
                        }
                        return null;
                      },
                      submit: submit2
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChange: (e) {
                        setState(() {
                          !submit2;
                        });
                        return null;
                      },
                      boolean: _passwordVisible1,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible1 = !_passwordVisible1;
                          });
                        },
                        icon: Icon(
                          _passwordVisible1
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    textField(
                      controller: _passwordControllerConfirm,
                      lable: 'Confirm Password',
                      valid: (value) {
                        if (value!.isEmpty) {
                          return 'Password cannot be null';
                        } else if (value.length < 8) {
                          return 'Enter at least 8 Characters';
                        } else if (value != _passwordController.text) {
                          return 'Password must be the same';
                        }
                        return null;
                      },
                      submit: submit3
                          ? AutovalidateMode.onUserInteraction
                          : AutovalidateMode.disabled,
                      onChange: (e) {
                        setState(() {
                          !submit3;
                        });
                        return null;
                      },
                      boolean: _passwordVisible2,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible2 = !_passwordVisible2;
                          });
                        },
                        icon: Icon(
                          _passwordVisible2
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 45),
                    InkWell(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        width: double.infinity,
                        child: Text(
                          'Simpan',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: ThemesColor().purple,
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      onTap: () async {
                        String email = _emailController.text.trim();
                        String pass = _passwordControllerConfirm.text.trim();
                        if (_key.currentState!.validate()) {
                          logindata.setString('email', email);
                          setState(() {
                            isloading = true;
                          });
                          try {
                            await _auth.createUserWithEmailAndPassword(
                                email: email, password: pass);
                            logindata.setBool('regis', false);
                            await Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation, secondaryAnimation) {
                                    return const HomeScreen();
                                  },
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return Align(
                                      child: SizeTransition(
                                        sizeFactor: animation,
                                        child: child,
                                      ),
                                    );
                                  },
                                  transitionDuration:
                                      const Duration(milliseconds: 750),
                                ),
                                (route) => false);
                            setState(() {
                              isloading = false;
                            });
                          } on FirebaseAuthException catch (e) {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text(' Ops! Registration Failed'),
                                content: Text('${e.message}'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(ctx).pop();
                                    },
                                    child: const Text('Okay'),
                                  )
                                ],
                              ),
                            );
                          }
                          setState(() {
                            isloading = false;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 75),
                  ],
                ),
              ),
            ),
    );
  }
}
