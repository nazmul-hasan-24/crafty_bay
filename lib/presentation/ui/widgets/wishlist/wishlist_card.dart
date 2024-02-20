import 'package:crafty_bay/data/models/wish_list_item.dart';
import 'package:crafty_bay/presentation/state_holders/remove_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListCard extends StatefulWidget {
  const WishListCard(
      {super.key, required this.wishItemData, required this.productId});
  final WishItemData wishItemData;
  final int productId;

  @override
  State<WishListCard> createState() => _WishListCardState();
}

class _WishListCardState extends State<WishListCard> {
  final con = Get.find<WishListController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final wihshData = widget.wishItemData.product;
    return SizedBox(
      height: height * 0.15,
      child: Card(
        margin: const EdgeInsets.all(8),
        elevation: 0.8,
        // padding: const EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.only(right: 6, bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(
                widget.wishItemData.product?.image ?? '',
                width: 110,
                height: 200,
                alignment: Alignment.centerLeft,
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          wihshData?.title ?? '',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ' ৳${wihshData?.price ?? ''}',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            height: 27,
                            width: 27,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                  width: 0, color: AppColors.primaryColor),
                            ),
                            child: InkWell(
                              onDoubleTap: () {},
                              onTap: () async {
                                bool response =
                                    await Get.find<RemoveWishListController>()
                                        .removeWishListItem(widget.productId)
                                        .then((value) =>
                                            Get.find<WishListController>()
                                                .getWishList());
                                if (response) {
                                  Get.showSnackbar(
                                    const GetSnackBar(
                                      title: 'Success',
                                      message:
                                          'This product has been removed from wishlist',
                                      duration: Duration(seconds: 2),
                                      isDismissible: true,
                                    ),
                                  );
                                } else {
                                  Get.showSnackbar(GetSnackBar(
                                    title: 'Removed this product failed',
                                    message:
                                        Get.find<RemoveWishListController>()
                                            .errorMessage,
                                    duration: const Duration(seconds: 2),
                                    isDismissible: true,
                                    backgroundColor: Colors.red,
                                  ));
                                }
                              },
                              child: const Icon(
                                Icons.favorite_outline_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
