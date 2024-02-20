import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:get/get.dart';
import '../../data/utility/urls.dart';

class DeleteCartItemController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> deleteCartListItem(
    int productId,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final response = await NetworkCaller().getRequest(
      Urls.deleteCartList(productId),
    );
    _inProgress = false;
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
