import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/state_holders/home_banner_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/category_controller.dart';
import 'package:crafty_bay/presentation/state_holders/main_bottom_nav_controller.dart';
import 'package:crafty_bay/presentation/state_holders/new_product_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/popular_products_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/special_product_list_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/email_verify_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/products_list_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/assets_path.dart';
import 'package:crafty_bay/presentation/ui/widgets/all_category_item.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/circle_icon_button.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/image_carousel_widget.dart';
import 'package:crafty_bay/presentation/ui/widgets/home/selection_title.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_items.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchTextFiled,
              const SizedBox(
                height: 14,
              ),
              GetBuilder<HomeBannerController>(builder: (homeBannerController) {
                return Visibility(
                  visible: homeBannerController.inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: BannerCarousel(
                    bannerList:
                        homeBannerController.bannerListModel.bannerList ?? [],
                  ),
                );
              }),
              SelectionTitl(
                onTapSeeAll: () {
                  Get.find<MainBottomNavController>().changeIndex(1);
                },
                title: "All Categories",
              ),
              allCategoryList,
              SelectionTitl(
                title: "Popular",
                onTapSeeAll: () {
                  Get.to(
                    () => const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<PopularProductsListController>(
                  builder: (popularProductsListController) {
                return Visibility(
                    visible: popularProductsListController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: productsList(popularProductsListController
                            .productsListModel.productList ??
                        []));
              }),
              const SizedBox(
                height: 8,
              ),
              SelectionTitl(
                title: "Special",
                onTapSeeAll: () {
                  Get.to(
                    () => const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<SpecialProductsListController>(
                  builder: (specialProductsListController) {
                return Visibility(
                    visible: specialProductsListController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: productsList(specialProductsListController
                            .productsListModel.productList ??
                        []));
              }),
              const SizedBox(
                height: 8,
              ),
              SelectionTitl(
                title: "New",
                onTapSeeAll: () {
                  Get.to(
                    () => const ProductListScreen(),
                  );
                },
              ),
              GetBuilder<NewProductsListController>(
                  builder: (newProductListController) {
                return Visibility(
                    visible: newProductListController.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: productsList(newProductListController
                            .productsListModel.productList ??
                        []));
              }),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox get allCategoryList {
    return SizedBox(
      height: 150,
      child: GetBuilder<CategoryController>(builder: (categoryController) {
        return Visibility(
          visible: categoryController.inProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.separated(
            shrinkWrap: true,
            primary: false,
            itemCount:
                categoryController.categoryListModel.categoryList?.length ?? 0,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return AllCategoryItem(
                category:
                    categoryController.categoryListModel.categoryList![index],
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
              width: 8,
            ),
          ),
        );
      }),
    );
  }

  SizedBox productsList(List<ProductModel> productsList) {
    return SizedBox(
        height: 190,
        child: ListView.separated(
          shrinkWrap: true,
          primary: false,
          itemCount: productsList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductCardItem(product: productsList[index]);
          },
          separatorBuilder: (_, __) => const SizedBox(
            width: 8,
          ),
        ));
  }

  TextFormField get searchTextFiled {
    return TextFormField(
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search),
          fillColor: Colors.grey.shade200,
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none),
          hintText: 'Search'),
    );
  }

  AppBar get appBar {
    return AppBar(
      title: Image.asset(AssetsPath.logoNav),
      actions: [
        CircleIconButton(
          onTap: () async {
            await AuthController.clearAuthData();
            Get.offAll(() => const EmailVerificationScreen());
          },
          iconData: Icons.person_2_outlined,
        ),
        CircleIconButton(
          onTap: () async {},
          iconData: Icons.call,
        ),
        CircleIconButton(
          onTap: () {},
          iconData: Icons.notifications_active_outlined,
        ),
      ],
    );
  }
}
