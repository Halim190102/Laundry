import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:mini_project/Component/Theme/theme.dart';
import 'package:mini_project/Views/Login_screen/register.dart';
import 'package:mini_project/Views/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  bool _passwordVisible = true;
  bool submit1 = true;
  bool submit2 = true;
  bool isloading = false;

  late SharedPreferences logindata;
  late bool newUser;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void checkLogin() async {
    logindata = await SharedPreferences.getInstance();
    newUser = logindata.getBool('login') ?? true;
    if (newUser == false) {
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
    checkLogin();
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
                  children: [
                    const SizedBox(height: 70),
                    Image.asset('assets/login_asset/icon_login.png'),
                    const SizedBox(height: 15),
                    const Text(
                      'Selamat Datang',
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
                      boolean: _passwordVisible,
                      icon: IconButton(
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                          tag: 1,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterScreen(),
                                ),
                              );
                            },
                            child: const Text(
                              'Daftar',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.deepOrange,
                              shadowColor: Colors.black,
                              onSurface: Colors.green,
                              elevation: 5,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            String email = _emailController.text;
                            String pass = _passwordController.text;
                            if (_key.currentState!.validate()) {
                              logindata.setString('email', email);
                              setState(() {
                                isloading = true;
                              });
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: email, password: pass);
                                logindata.setBool('login', false);
                                await Navigator.pushAndRemoveUntil(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                          secondaryAnimation) {
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
                                    title: const Text("Ops! Login Failed"),
                                    content: Text('${e.message}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
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
                          icon: const Icon(Icons.login_rounded),
                          label: const Text('Masuk'),
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.teal,
                            shadowColor: Colors.black,
                            onSurface: Colors.green,
                            elevation: 5,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
