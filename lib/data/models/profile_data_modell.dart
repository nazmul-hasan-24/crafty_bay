import 'package:crafty_bay/data/models/profile_data.dart';

class ProfileDataModel {
  String? msg;
  ProfileData? profileData;

  ProfileDataModel({this.msg, this.profileData});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    profileData =
        json['data'] != null ? ProfileData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (profileData != null) {
      data['data'] = profileData!.toJson();
    }
    return data;
  }
}
