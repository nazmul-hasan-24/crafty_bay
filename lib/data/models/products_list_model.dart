import 'package:crafty_bay/data/models/product_model.dart';

class ProductsListModel {
  String? msg;
  List<ProductModel>? productList;

  ProductsListModel({this.msg, this.productList});

  ProductsListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <ProductModel>[];
      json['data'].forEach((v) {
        productList!.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (productList != null) {
      data['data'] = productList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
