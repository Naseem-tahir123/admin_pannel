import 'package:get/get.dart';

class IsSaleController extends GetxController {
  RxBool isSale = false.obs;

  void isSaleToggle(bool value) {
    isSale.value = value;
    update();
  }

  // is sale old value
  void setIsSaleOldValue(bool value) {
    isSale.value = value;
    update();
  }
}
