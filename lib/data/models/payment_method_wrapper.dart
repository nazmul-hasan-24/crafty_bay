import 'package:crafty_bay/data/models/payment_method_list.dart';

class PaymentMethodWraper {
  List<PaymentMethodList>? paymentMethodList;
  int? payable;
  int? vat;
  int? total;

  PaymentMethodWraper(
      {this.paymentMethodList, this.payable, this.vat, this.total});

  PaymentMethodWraper.fromJson(Map<String, dynamic> json) {
    if (json['paymentMethod'] != null) {
      paymentMethodList = <PaymentMethodList>[];
      json['paymentMethod'].forEach((v) {
        paymentMethodList!.add(PaymentMethodList.fromJson(v));
      });
    }
    payable = json['payable'];
    vat = json['vat'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (paymentMethodList != null) {
      data['paymentMethod'] =
          paymentMethodList!.map((v) => v.toJson()).toList();
    }
    data['payable'] = payable;
    data['vat'] = vat;
    data['total'] = total;
    return data;
  }
}
