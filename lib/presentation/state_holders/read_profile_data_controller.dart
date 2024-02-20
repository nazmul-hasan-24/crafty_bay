import 'package:crafty_bay/data/models/profile_data_modell.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileDataController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  bool _isProfileCompleted = false;
  bool get isProfileCompleted => _isProfileCompleted;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProfileDataModel _profile = ProfileDataModel();
  ProfileDataModel get profile => _profile;

  Future<bool> readProfileData(String token) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.readProfile, token: token);
    _inProgress = false;
    if (response.isSuccess) {
      final profileData = response.responseData['data'];
      if (profileData == null) {
        _isProfileCompleted = false;
      } else {
        _profile = ProfileDataModel.fromJson(profileData);
        _isProfileCompleted = true;
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
