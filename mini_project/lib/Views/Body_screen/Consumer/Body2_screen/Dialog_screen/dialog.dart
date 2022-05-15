import 'package:flutter/material.dart';
import 'package:mini_project/Model/model_data.dart';

class DialogInformation extends StatelessWidget {
  const DialogInformation({Key? key, required this.isi}) : super(key: key);
  final IsiData isi;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 35, top: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Image.asset(
                  'assets/image/baju.png',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 20),
                Text(
                  isi.baju.toString() + ' potong',
                ),
              ],
            ),
            const SizedBox(height: 3),
            Row(
              children: [
                Image.asset(
                  'assets/image/celana.png',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 20),
                Text(
                  isi.celana.toString() + ' potong',
                ),
              ],
            ),
            const SizedBox(height: 3),
            isi.icon.toString() == '0.1'
                ? Row(
                    children: [
                      Image.asset(
                        'assets/image/iron.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 20),
                      const Text('Disetrika'),
                    ],
                  )
                : Row(
                    children: [
                      Image.asset(
                        'assets/image/!iron.png',
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 20),
                      const Text('Tidak Disetrika'),
                    ],
                  ),
            const SizedBox(height: 3),
            Row(
              children: [
                Image.asset(
                  'assets/image/uang.png',
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 20),
                Text(
                  isi.harga.toString(),
                ),
                const SizedBox(height: 5),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
