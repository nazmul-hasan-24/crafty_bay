import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/delete_cart_item_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductsItem extends StatefulWidget {
  const CartProductsItem({
    super.key,
    required this.height,
    required this.width,
    required this.cartItem,
  });
  final CartItemData cartItem;
  final double height;
  final double width;

  @override
  State<CartProductsItem> createState() => _CartProductsItemState();
}

class _CartProductsItemState extends State<CartProductsItem> {
  late ValueNotifier<int> noOfItems = ValueNotifier(widget.cartItem.quantity);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (widget.height * 0.20),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 0.5,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide.none),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                widget.cartItem.product?.image ?? '',
                width: (widget.width * 0.29),
                height: (widget.height * 0.85),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.cartItem.product?.title ?? '',
                            style: const TextStyle(color: Colors.black87),
                            maxLines: 1,
                          ),
                          IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return deleteProduct;
                                },
                              );
                            },
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Size ${widget.cartItem.size ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Text(
                        'Colour ${widget.cartItem.color ?? ''}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '৳${widget.cartItem.product?.price ?? 0}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor,
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: noOfItems,
                            builder: (context, value, _) {
                              return ItemCount(
                                initialValue: value,
                                minValue: 1,
                                maxValue: 20,
                                decimalPlaces: 0,
                                step: 1,
                                color: AppColors.primaryColor,
                                onChanged: (v) {
                                  noOfItems.value = v.toInt();
                                  Get.find<CartListController>().updateQuantity(
                                      widget.cartItem.id!, noOfItems.value);
                                },
                              );
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  AlertDialog get deleteProduct {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.spaceAround,
      title: const Text('Delete'),
      content: const Text(
        'Do you wanna delete this item?',
        style: TextStyle(color: AppColors.primaryColor),
      ),
      actions: [
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'No',
              style: TextStyle(color: Colors.black),
            )),
        TextButton(
          onPressed: () async {
            Get.find<DeleteCartItemController>()
                .deleteCartListItem(widget.cartItem.productId!)
                .then((value) => Get.find<CartListController>().getCartList());
            Get.back();
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
