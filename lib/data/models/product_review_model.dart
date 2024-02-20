import 'package:crafty_bay/data/models/review_data.dart';

class ReviewListModelList {
  String? msg;
  List<ReviewData>? reviewList;

  ReviewListModelList({this.msg, this.reviewList});

  ReviewListModelList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewData>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (reviewList != null) {
      data['data'] = reviewList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
