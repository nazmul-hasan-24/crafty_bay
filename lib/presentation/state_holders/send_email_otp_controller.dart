import 'package:crafty_bay/data/models/network_caller_response_data.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class SendEmailOTPController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Future<bool> sendOTPEmail(String email) async {
    _inProgress = true;
    update();
    final ResponseData response =
        await NetworkCaller().getRequest(Urls.sentEmailOtp(email));
    _inProgress = false;
    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
