import 'package:crafty_bay/data/models/payment_method_list_model.dart';
import 'package:crafty_bay/data/servises/network_caller.dart';
import 'package:crafty_bay/data/utility/urls.dart';
import 'package:get/get.dart';

class CreateInvoiceController extends GetxController {
  bool _inProgress = true;
  bool get inProgress => _inProgress;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  PaymentMethodModelList _paymentMethodListModel = PaymentMethodModelList();
  PaymentMethodModelList get paymentMethodListModel => _paymentMethodListModel;

  Future<bool> createInvoice() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final response = await NetworkCaller().getRequest(Urls.createInvoice);
    if (response.isSuccess) {
      _paymentMethodListModel =
          PaymentMethodModelList.fromJson(response.responseData);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
