import 'package:crafty_bay/data/models/payment_method_wrapper.dart';

class PaymentMethodModelList {
  String? msg;
  List<PaymentMethodWraper>? data;

  PaymentMethodModelList({this.msg, this.data});

  PaymentMethodModelList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      data = <PaymentMethodWraper>[];
      json['data'].forEach((v) {
        data!.add(PaymentMethodWraper.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
