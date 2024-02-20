import 'package:crafty_bay/data/models/create_profile_param.dart';
import 'package:crafty_bay/data/models/profile_data_modell.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProfileDataModel _profile = ProfileDataModel();
  ProfileDataModel get profile => _profile;

  Future<bool> createProfileData(
      String token, CreateProfileParams params) async {
    _inProgress = true;
    update();
    final response = await NetworkCaller()
        .postRequest(Urls.createProfile, token: token, body: params.toJson());
    _inProgress = false;
    if (response.isSuccess) {
      _profile = ProfileDataModel.fromJson(response.responseData['data']);
      await Get.find<AuthController>().saveUserDetails(token, _profile);
      print(response.statusCode);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
