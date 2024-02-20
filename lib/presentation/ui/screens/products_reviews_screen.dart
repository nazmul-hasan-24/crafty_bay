import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/add_review_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/review_card/review_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductReviewsScreen extends StatefulWidget {
  const ProductReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ProductReviewsScreen> createState() => _ProductReviewsScreenState();
}

class _ProductReviewsScreenState extends State<ProductReviewsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ReviewListController>().getReviewList(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
        // leading: Icon(Icons.arrow_back_ios),
      ),
      body: GetBuilder<ReviewListController>(
        builder: (controller) {
          if (controller.inProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7)
                      .copyWith(top: 6),
                  child: Visibility(
                    visible:
                        controller.reviewListModel.reviewList?.isNotEmpty ??
                            false,
                    replacement: const Center(
                      child: Text('Reviews not available'),
                    ),
                    child: ListView.builder(
                      clipBehavior: Clip.antiAlias,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          controller.reviewListModel.reviewList?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ReviewCard(
                          reviewData:
                              controller.reviewListModel.reviewList![index],
                        );
                      },
                    ),
                  ),
                ),
              ),
              totalAndCreateReviewsSection(
                  controller.reviewListModel.reviewList?.length ?? 0),
            ],
          );
        },
      ),
    );
  }

  Container totalAndCreateReviewsSection(int totalReviews) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Reviews (${totalReviews.toString()})',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.grey.shade700,
            ),
          ),
          SizedBox(
            width: 80,
            height: 50,
            child: FilledButton(
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
              ),
              onPressed: () {
                if (Get.find<AuthController>().isTokenNotNull == false) {
                  AuthController.goToLogin();
                  return;
                }
                Get.to(
                  () => AddReviewScreen(
                    productId: widget.productId,
                  ),
                );
              },
              child: const Icon(
                Icons.add,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
