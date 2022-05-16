import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/Login_screen/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomSheets extends StatefulWidget {
  const BottomSheets({Key? key}) : super(key: key);

  @override
  State<BottomSheets> createState() => _BottomSheetsState();
}

class _BottomSheetsState extends State<BottomSheets> {
  late SharedPreferences logindata;

  String email = '';

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(
      () {
        email = logindata.getString('email').toString();
      },
    );
  }

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  void initState() {
    super.initState();
    initial();
  }

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<DataManager>(context).allData;
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/image/user.png'),
          ),
          const SizedBox(height: 25),
          Text(
            email,
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 15),
          ListTile(
            title: const Text('Pengaturan'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          ListTile(
            title: const Text('FAQ'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {},
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () async {
                  logindata.setBool('login', true);
                  logindata.setBool('regis', true);
                  logindata.remove('email');
                  data.clear();
                  await _signOut();
                  if (_firebaseAuth.currentUser == null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.brown,
                ),
                child: const Text('Keluar'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
