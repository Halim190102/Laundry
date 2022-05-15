import 'package:flutter/material.dart';

class ContainerProduct extends StatelessWidget {
  const ContainerProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
            const Text(
              'Rp. 600 per Potong',
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
            const Text(
              'Rp. 400 per Potong',
            ),
          ],
        ),
        const SizedBox(height: 3),
        Row(
          children: [
            Image.asset(
              'assets/image/iron.png',
              height: 30,
              width: 30,
            ),
            const SizedBox(width: 20),
            const Text(
              'Jika Disetrika Ditambah 10%',
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
