import 'package:flutter/material.dart';

class Body2EmptyScreen extends StatelessWidget {
  const Body2EmptyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/image/cloud.png',
            height: 170,
            width: 170,
            color: Colors.white,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Opps!!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text('Belum Ada Pesanan')
            ],
          )
        ],
      ),
    );
  }
}
