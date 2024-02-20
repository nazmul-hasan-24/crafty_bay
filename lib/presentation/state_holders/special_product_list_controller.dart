import 'package:crafty_bay/data/models/products_list_model.dart';
import 'package:crafty_bay/data/models/network_caller_response_data.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class SpecialProductsListController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  ProductsListModel _productsListModel = ProductsListModel();
  ProductsListModel get productsListModel => _productsListModel;

  Future<bool> getSpecialProductsList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final ResponseData response =
        await NetworkCaller().getRequest(Urls.specialProductList);
    _inProgress = false;
    if (response.isSuccess) {
      _productsListModel = ProductsListModel.fromJson(response.responseData);
      update();
      return isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    update();
    return isSuccess;
  }
}
