import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/Body_screen/Consumer/Body2_screen/Dialog_screen/dialog.dart';

class Body2ListScreen extends StatefulWidget {
  const Body2ListScreen({Key? key, required this.data}) : super(key: key);
  final DataManager data;

  @override
  State<Body2ListScreen> createState() => _Body2ListScreenState();
}

class _Body2ListScreenState extends State<Body2ListScreen> {
  final uid = FirebaseAuth.instance.currentUser!.uid;

  bool messege = true;

  @override
  Widget build(BuildContext context) {
    final _allData = widget.data;
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: _allData.jumlahData,
      itemBuilder: (context, i) {
        final data = _allData.allData[i];
        var id = data.id;
        return InkWell(
          onLongPress: () async {
            await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                content: const Text('Kamu Yakin ingin menghapusnya ?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        messege = false;
                      });
                    },
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () {
                      _allData.deleteData(
                        id,
                        uid,
                      );
                      Navigator.pop(context);
                      setState(() {
                        messege = true;
                      });
                    },
                    child: const Text('Yes'),
                  ),
                ],
              ),
            );
            messege == true
                ? ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Berhasil dihapus"),
                      duration: Duration(milliseconds: 500),
                    ),
                  )
                : null;
          },
          child: Card(
            elevation: 10,
            color: const Color.fromARGB(255, 255, 160, 125),
            shadowColor: const Color.fromARGB(255, 125, 150, 61),
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Color.fromARGB(255, 255, 160, 125),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 65,
                  child: ListTile(
                    title: const Text(
                      'Pesanan',
                    ),
                    subtitle: Text(
                      data.createdAt,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1.4,
                  color: Colors.black54,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 22,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: const Icon(
                          Icons.info_outline_rounded,
                          size: 18,
                          color: Colors.black54,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => DialogInformation(
                              isi: data,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
