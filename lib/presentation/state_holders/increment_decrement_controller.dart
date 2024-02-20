import 'package:get/get.dart';

class IncrementDecrementController extends GetxController {
  List<int> counter = List.filled(500, 1).obs;

  void increment(int index) {
    counter[index]++;
    update();
  }

  void decrement(int index) {
    if (counter[index] > 1) {
      counter[index]--;
      update();
    }
  }
}
