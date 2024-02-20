import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class RemoveWishListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;
  String _errorMessage = '';

  Future<bool> removeWishListItem(
    int productId,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller().getRequest(
      Urls.removeWishList(productId),
    );
    _inProgress = false;
    if (response.isSuccess) {
      isSuccess = true;
      update();
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
