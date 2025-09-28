import 'package:flutter/material.dart';
import 'package:invite_flare/export.dart';
import 'package:invite_flare/module/card/card/controller/sub_category_controller.dart';

class SubCategoryScreen extends StatelessWidget {
  final controller = Get.put(SubCategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Text('Sub Category Screen'),
      ),
      body: Center(
        child: Text('Sub Category Content Here'),
      ),
    );
  }
}
