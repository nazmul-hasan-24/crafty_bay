import 'dart:developer';

import 'package:crafty_bay/data/models/product_review_model.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import '../../data/utility/urls.dart';
import 'auth_controller.dart';

class ReviewListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ReviewListModelList _reviewListModel = ReviewListModelList();
  ReviewListModelList get reviewListModel => _reviewListModel;

  Future<bool> getReviewList(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response =
        await NetworkCaller().getRequest(Urls.listReviewByProduct(productId));
    log(AuthController.token.toString());
    _inProgress = false;
    if (response.isSuccess) {
      _reviewListModel = ReviewListModelList.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
