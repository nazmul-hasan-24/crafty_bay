import 'package:crafty_bay/presentation/state_holders/product_controller.dart';
import 'package:crafty_bay/presentation/ui/widgets/product_card_items.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key, this.category, this.categoryId});
  final String? category;
  final int? categoryId;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.category != null) {
      Get.find<ProductController>()
          .getProductsList(categoryId: widget.categoryId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category ?? 'Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        child: GetBuilder<ProductController>(
          builder: (context) {
            return GetBuilder<ProductController>(
              builder: (productController) {
                return Visibility(
                  visible: productController.inProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: Visibility(
                    visible: productController
                            .productsListModel.productList?.isNotEmpty ??
                        false,
                    replacement: const Center(
                      child: Text(
                        "Empty Product List",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    child: GridView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: productController
                              .productsListModel.productList?.length ??
                          0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 0.98,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 5),
                      itemBuilder: (context, index) {
                        return FittedBox(
                          child: ProductCardItem(
                            product: productController
                                .productsListModel.productList![index],
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
