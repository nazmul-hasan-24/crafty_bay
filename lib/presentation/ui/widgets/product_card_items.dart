import 'package:crafty_bay/data/models/product_model.dart';
import 'package:crafty_bay/presentation/ui/screens/product_details_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCardItem extends StatelessWidget {
  const ProductCardItem(
      {super.key,
      required this.product,
      this.addToWishList = true,
      this.width = 210,
      this.height = 210,
      this.alignment = CrossAxisAlignment.center});
  final ProductModel product;
  final bool addToWishList;
  final double width;
  final double height;
  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => ProductDeatilsScreen(
            productId: product.id!,
          )),
      borderRadius: BorderRadius.circular(16.0),
      child: FittedBox(
        child: SizedBox(
          height: height,
          width: width,
          child: Card(
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(color: Color.fromRGBO(147, 247, 185, 1)),
            ),
            child: Column(
              crossAxisAlignment: alignment,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    child: Image.network(product.image ?? ''),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        product.title ?? '',
                        style: const TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "৳ ${product.price ?? 0}",
                              style: const TextStyle(
                                  fontSize: 15,
                                  color: AppColors.primaryColor,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          Expanded(
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 14,
                                  color: Colors.amber,
                                ),
                                Text(
                                  '${product.star ?? 0}',
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black38),
                                ),
                              ],
                            ),
                          ),
                          Card(
                            color: AppColors.primaryColor,
                            shape: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4.0),
                                borderSide: BorderSide.none),
                            child: const Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.favorite_outline_rounded,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15.0,
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
