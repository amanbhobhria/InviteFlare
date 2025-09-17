import 'package:get/get.dart';

class MainController extends GetxController {
  final RxInt _pageNo = 0.obs;

  int get pageNo => _pageNo.value;
  set pageNo(int value) => _pageNo.value = value;

  void updatePage(int index) {
    pageNo = index;
  }
}
