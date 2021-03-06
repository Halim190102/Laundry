import 'package:flutter/material.dart';
import 'package:mini_project/View Model/db_data_manager.dart';
import 'package:mini_project/Views/Body_screen/Consumer/Body2_screen/body_2_empty.dart';
import 'package:mini_project/Views/Body_screen/Consumer/Body2_screen/body_2_list.dart';
import 'package:provider/provider.dart';

class Consume extends StatelessWidget {
  const Consume({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, data, child) {
        if (data.allData.isNotEmpty) {
          return Body2ListScreen(
            data: data,
          );
        } else {
          return const Body2EmptyScreen();
        }
      },
    );
  }
}
