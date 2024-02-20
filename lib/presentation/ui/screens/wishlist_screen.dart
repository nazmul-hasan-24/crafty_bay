import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/state_holders/wish_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/wishlist/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({
    super.key,
  });

  @override
  State<WishListScreen> createState() => _CartListScreenState();
}

class _CartListScreenState extends State<WishListScreen> {
  final WishListController wishListController = Get.find<WishListController>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<WishListController>().getWishList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => Get.find<MainBottomNavController>().backToHome(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Wish List"),
          leading: IconButton(
            onPressed: () {
              Get.find<MainBottomNavController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: InkWell(
          onTap: () => Get.to(() => ProductDeatilsScreen(
                productId:
                    Get.find<ProductDetailsController>().productDetails.id ?? 0,
              )),
          child: GetBuilder<WishListController>(builder: (wishListController) {
            if (wishListController.inProgress == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              primary: false,
              itemCount:
                  wishListController.wishListModel.wishItemList?.length ?? 0,
              itemBuilder: (context, index) {
                return WishListCard(
                  wishItemData:
                      wishListController.wishListModel.wishItemList![index],
                  productId: wishListController
                          .wishListModel.wishItemList?[index].product?.id ??
                      0,
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
