import 'package:crafty_bay/data/models/network_caller_response_data.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController {
  bool _inProgress = false;

  String _errorMessage = '';

  bool get inProgress => _inProgress;

  String get errorMessage => _errorMessage;

  Future<bool> addToCart(
      int productId, String color, String size, int quantity) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "product_id": productId,
      "color": color,
      "size": size,
      "qty": quantity,
    };
    final ResponseData response = await NetworkCaller().postRequest(
        Urls.addToCart,
        body: inputParams,
        token: AuthController.token);
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
