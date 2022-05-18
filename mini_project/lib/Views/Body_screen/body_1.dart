import 'package:flutter/material.dart';
import 'package:mini_project/Views/Body_screen/Add_data_screen/add_data.dart';
import 'package:mini_project/Views/Body_screen/Container_screen/container_1.dart';
import 'package:mini_project/Views/Body_screen/Container_screen/container_2.dart';
import 'package:mini_project/Views/Body_screen/Container_screen/google_map.dart';

class Body1 extends StatelessWidget {
  const Body1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ayo Pesan Sekarang !!!'),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddData(),
                      ),
                    );
                  },
                  child: const Icon(Icons.add),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.brown,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(left: 35, top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ContainerProduct(),
            ),
            const GoogleMaps(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const ContainerAbout(),
            )
          ],
        ),
      ),
    );
  }
}
