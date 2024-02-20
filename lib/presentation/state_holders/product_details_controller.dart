import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/data/models/product_details_model.dart';
import 'package:crafty_bay/data/models/network_caller_response_data.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProductDetailsModel _productDetailsModel = ProductDetailsModel();
  ProductDetailsModel get productDetailsModel => _productDetailsModel;

  ProductDetailsData get productDetails =>
      _productDetailsModel.productDetailsData!.firstWhere((element) => true);

  Future<bool> getProductDetails(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(
        Urls.productDetails(productId),
        token: AuthController.token);
    if (response.isSuccess) {
      _productDetailsModel =
          ProductDetailsModel.fromJson(response.responseData ?? '');

      update();
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
