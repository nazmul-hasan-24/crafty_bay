import 'dart:async';
import 'package:get/get.dart';

class OTPTimerController extends GetxController {
  RxInt count = RxInt(120);
  Timer? _timer;
  Timer? get timer => _timer;

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (count.value > 0) {
          count.value--;
          update();
          print(count.value);
        } else {
          return;
        }
      },
    );
  }

  void cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  @override
  void onClose() {
    cancelTimer();
    super.onClose();
  }
}
