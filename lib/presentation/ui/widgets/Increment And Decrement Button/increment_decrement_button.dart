import 'dart:developer';

import 'package:crafty_bay/data/models/cart_item.dart';
import 'package:crafty_bay/presentation/state_holders/cart_list_controller.dart';
import 'package:crafty_bay/presentation/state_holders/increment_decrement_controller.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IncrementAndDecrementButton extends StatefulWidget {
  const IncrementAndDecrementButton(
      {super.key, this.cartItem, required this.index});
  final CartItemData? cartItem;
  final int index;

  @override
  State<IncrementAndDecrementButton> createState() =>
      _IncrementAndDecrementButtonState();
}

class _IncrementAndDecrementButtonState
    extends State<IncrementAndDecrementButton> {
  late ValueNotifier<int> noOfItems =
      ValueNotifier(widget.cartItem?.quantity ?? 0);
  @override
  Widget build(BuildContext context) {
    log("Incremnt and decrement");

    return GetBuilder<IncrementDecrementController>(
        builder: (incrementDecrementController) {
      return Wrap(
        alignment: WrapAlignment.center,
        children: [
          Card(
            elevation: 0,
            color: incrementDecrementController.counter == [0]
                ? AppColors.primaryColor.withOpacity(0.6)
                : AppColors.primaryColor,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4.0),
              borderSide: BorderSide.none,
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: InkWell(
                onTap: () {
                  incrementDecrementController.decrement(widget.index);
                  Get.find<CartListController>().updateQuantity(
                      widget.cartItem?.id ?? 0, noOfItems.value);
                },
                child: const Icon(
                  Icons.remove,
                  color: Color.fromARGB(255, 255, 255, 255),
                  size: 13,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              incrementDecrementController.counter.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: Colors.black,
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 28,
            width: 35,
            child: Stack(
              children: [
                Card(
                  semanticContainer: true,
                  elevation: 0,
                  color: AppColors.primaryColor,
                  shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: BorderSide.none,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        incrementDecrementController.increment(widget.index);
                        Get.find<CartListController>().updateQuantity(
                            widget.cartItem?.id ?? 0, noOfItems.value);
                      },
                      child: const Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 255, 255, 255),
                        size: 13,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    });
  }
}
