import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mini_project/Component/Reusable%20TextField/reusable_textfield.dart';
import 'package:mini_project/Component/Reusble%20ListTile/reusable_listtile.dart';
import 'package:mini_project/Component/Theme/theme.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/home.dart';
import 'package:provider/provider.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  int selected = 1;
  int _onChange1 = 0;
  int _onChange2 = 0;

  num _selected = 0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final a = (_onChange1 * 600) + (_onChange2 * 400);
    final total = (a + (a * _selected)).toInt();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ThemesColor().primaryBar,
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            color: ThemesColor().primaryBody,
          ),
          Positioned(
            child: Container(
              margin: const EdgeInsets.only(top: 35, left: 35, right: 35),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/baju.png',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 20),
                      textField1(
                        type: TextInputType.number,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChange: (e) {
                          if (e!.isEmpty) {
                            setState(() {
                              _onChange1 = 0;
                            });
                          } else {
                            setState(() {
                              _onChange1 = int.parse(e);
                            });
                          }
                          return null;
                        },
                        lable: 'Jumlah Baju',
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/celana.png',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 20),
                      textField1(
                        type: TextInputType.number,
                        format: FilteringTextInputFormatter.digitsOnly,
                        onChange: (e) {
                          if (e!.isEmpty) {
                            setState(() {
                              _onChange2 = 0;
                            });
                          } else {
                            setState(() {
                              _onChange2 = int.parse(e);
                            });
                          }
                          return null;
                        },
                        lable: 'Jumlah Celana',
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/iron.png',
                        height: 50,
                        width: 50,
                      ),
                      Column(
                        children: [
                          listTile(
                            value: 0,
                            groupValue: selected,
                            title: 'YA',
                            change: (value) {
                              setState(() {
                                selected = value!;
                                _selected = 0.1;
                              });
                            },
                          ),
                          listTile(
                            value: 1,
                            groupValue: selected,
                            title: 'TIDAK',
                            change: (value) {
                              setState(() {
                                selected = value!;
                                _selected = 0;
                              });
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Image.asset(
                        'assets/image/uang.png',
                        height: 50,
                        width: 50,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        'Rp. $total',
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 20),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.brown,
                      minimumSize: const Size.fromHeight(40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    onPressed: () {
                      if ((_onChange1 != 0 || _onChange2 != 0) &&
                          a >= 6000 &&
                          _onChange1 <= 30 &&
                          _onChange2 <= 30) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content:
                                const Text('Kamu Yakin dengan Pesanannya ?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  final isiData = Provider.of<DataManager>(
                                      context,
                                      listen: false);
                                  isiData
                                      .addData(
                                    _onChange1.toString(),
                                    _onChange2.toString(),
                                    'Rp. $total',
                                    uid,
                                    _selected.toString(),
                                  )
                                      .then(
                                    (response) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text("Berhasil ditambahkan"),
                                          duration: Duration(seconds: 2),
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeScreen(),
                                        ),
                                      );
                                    },
                                  ).catchError(
                                    (err) => showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const Text("TERJADI ERROR"),
                                        content: const Text(
                                            "Tidak dapat menambahkan Data."),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("OKAY"),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          ),
                        );
                      } else if (_onChange1 > 30 ||
                          _onChange2 > 30 ||
                          (_onChange1 > 30 && _onChange2 > 30)) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                                "Maksimal Pesanan hanya 30 Potong Baju &\n30 Potong Celana"),
                            content:
                                const Text("Tidak dapat menambahkan Data."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OKAY"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text("Minimal Pesanan\nRp. 6.000"),
                            content:
                                const Text("Tidak dapat menambahkan Data."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OKAY"),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                    child: const Text(
                      'Pesan',
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
