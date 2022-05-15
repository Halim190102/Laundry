import 'package:flutter/material.dart';

class ContainerAbout extends StatelessWidget {
  const ContainerAbout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 5),
        const Text(
          'Alamat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          children: const [
            Icon(Icons.location_city),
            SizedBox(width: 20),
            Text(
              'Jl. Medan - Banda Aceh, Batuphat Timur,\nKec. Muara Satu, Kota Lhokseumawe, Aceh',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Icon(Icons.phone),
            SizedBox(width: 20),
            Text(
              '0812-6071-4075',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: const [
            Icon(Icons.email_outlined),
            SizedBox(width: 20),
            Text(
              '190102hr@gmail.com',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}
