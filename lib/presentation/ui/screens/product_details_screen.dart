import 'dart:developer';

import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/data/models/product_details_data.dart';
import 'package:crafty_bay/presentation/state_holders/add_to_cart_controller.dart';
import 'package:crafty_bay/presentation/state_holders/add_wish_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/auth_controller.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/product_details_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/email_verify_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/products_reviews_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/colors_selector.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/product_details_carousel.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_details/size_selector.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDeatilsScreen extends StatefulWidget {
  const ProductDeatilsScreen(
      {super.key, required this.productId, this.cartItem});
  final int productId;
  final CartItemData? cartItem;

  @override
  State<ProductDeatilsScreen> createState() => _ProductDeatilsScreenState();
}

class _ProductDeatilsScreenState extends State<ProductDeatilsScreen> {
  ValueNotifier<int> noOfItems = ValueNotifier(1);
  List<Color> colors = [
    Colors.purple,
    Colors.black,
    Colors.amber,
    Colors.red,
    Colors.lightGreen,
  ];

  List<String> sizes = [
    'S',
    'L',
    'M',
    'XL',
    'XXL',
    'XXXL',
  ];

  Color? _selectedColor;
  String? _selectedSize;

  late ValueNotifier<int> noOfItem = ValueNotifier(widget.cartItem!.quantity);

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    log(
      AuthController.token.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if (productDetailsController.inProgress == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (productDetailsController
              .productDetailsModel.productDetailsData!.isEmpty) {
            return const Center(
              child: Text(
                'Sorry! This Product Not Available',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ProductDetailsImageCarousel(
                        urls: [
                          productDetailsController.productDetails.img1 ?? '',
                          productDetailsController.productDetails.img2 ?? '',
                          productDetailsController.productDetails.img3 ?? '',
                          productDetailsController.productDetails.img4 ?? '',
                        ],
                      ),
                      productDeatailsBody(
                          productDetailsController.productDetails),
                    ],
                  ),
                ),
              ),
              addToCart(
                  price:
                      productDetailsController.productDetails.product?.price ??
                          '0')
            ],
          );
        },
      ),
    );
  }

  Padding productDeatailsBody(ProductDetailsData productDetails) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  productDetails.product?.title ?? '',
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ValueListenableBuilder(
                      valueListenable: noOfItems,
                      builder: (context, value, _) {
                        return ItemCount(
                          initialValue: value,
                          textStyle: const TextStyle(color: Colors.black),
                          minValue: 1,
                          maxValue: 20,
                          decimalPlaces: 0,
                          step: 1,
                          color: AppColors.primaryColor,
                          onChanged: (v) {
                            noOfItems.value = v.toInt();
                            Get.find<CartListController>().updateQuantity(
                                widget.cartItem?.id ?? 0, noOfItems.value);
                          },
                        );
                      }),
                ],
              )
            ],
          ),
          const SizedBox(height: 8.0),
          Wrap(
            spacing: 5.0,
            crossAxisAlignment: WrapCrossAlignment.start,
            alignment: WrapAlignment.center,
            children: [
              const Icon(
                Icons.star,
                size: 18,
                color: Colors.amber,
              ),
              Text(
                (productDetails.product!.star ?? 0).toStringAsPrecision(2),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
              InkWell(
                borderRadius: BorderRadius.circular(8),
                child: const Text(
                  "Reviews",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600),
                ),
                onTap: () {
                  Get.to(() => ProductReviewsScreen(
                        productId: widget.productId,
                      ));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 0, color: AppColors.primaryColor),
                  ),
                  child: InkWell(
                    onTap: () async {
                      bool response = await Get.find<AddToWishListController>()
                          .addToWishList(widget.productId);
                      if (response) {
                        Get.showSnackbar(
                          const GetSnackBar(
                            title: 'Success',
                            message: 'This product has been added to wishlist',
                            duration: Duration(seconds: 2),
                            isDismissible: true,
                          ),
                        );
                      } else {
                        Get.showSnackbar(GetSnackBar(
                          title: 'Add to wishList failed',
                          message: Get.find<AddToCartController>().errorMessage,
                          duration: const Duration(seconds: 2),
                          isDismissible: true,
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                    child: const Icon(
                      Icons.favorite_outline_rounded,
                      color: Colors.white,
                      fill: 0.8,
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          const Text(
            "Colour",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black54),
          ),
          ColorSelector(
            colors: productDetails.color
                    ?.split(',')
                    .map((e) => getColorFromString(e))
                    .toList() ??
                [],
            onChange: (selectedColor) {
              _selectedColor = selectedColor;
            },
          ),
          const SizedBox(height: 5.0),
          const Text(
            "Size",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black54),
          ),
          SizeSelector(
              sizes: productDetails.size?.split(',') ?? [],
              onChange: (size) {
                _selectedSize = size;
              }),
          const SizedBox(height: 12.0),
          const Text(
            "Descriptions",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black54),
          ),
          const SizedBox(height: 12.0),
          Text(
            productDetails.des ?? '',
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }

  Container addToCart({required String price}) {
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Price",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                '৳$price',
                style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            width: 120,
            child:
                GetBuilder<AddToCartController>(builder: (addToCartController) {
              return Visibility(
                visible: addToCartController.inProgress == false,
                replacement: const Center(
                  child: CircularProgressIndicator(),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    if (_selectedColor != null && _selectedSize != null) {
                      if (Get.find<AuthController>().isTokenNotNull) {
                        final stringColor = colorToString(_selectedColor!);
                        final response = await addToCartController.addToCart(
                            widget.productId,
                            stringColor,
                            _selectedSize!,
                            noOfItems.value);
                        if (response) {
                          Get.showSnackbar(const GetSnackBar(
                            title: 'Success',
                            message: 'This product has been added to cart',
                            duration: Duration(seconds: 2),
                          ));
                        } else {
                          Get.showSnackbar(GetSnackBar(
                            title: 'Add to cart failed',
                            message: addToCartController.errorMessage,
                            duration: const Duration(seconds: 2),
                          ));
                        }
                      } else {
                        Get.to(() => const EmailVerificationScreen());
                      }
                    } else {
                      Get.showSnackbar(const GetSnackBar(
                        title: 'Add to cart failed',
                        message: 'Please select color and size',
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  style: const ButtonStyle(
                      padding: MaterialStatePropertyAll<EdgeInsetsGeometry>(
                          EdgeInsets.zero)),
                  child: const Text(
                    "Add to cart",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }

  Color getColorFromString(String color) {
    color = color.toLowerCase();
    if (color == 'red') {
      return Colors.red;
    } else if (color == 'white') {
      return Colors.white;
    } else if (color == 'green') {
      return Colors.green;
    }
    return Colors.grey;
  }

  String colorToString(Color color) {
    if (color == Colors.red) {
      return 'Red';
    } else if (color == Colors.white) {
      return 'White';
    } else if (color == Colors.green) {
      return 'Green';
    }
    return 'Grey';
  }
}
