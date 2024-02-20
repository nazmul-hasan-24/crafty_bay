import 'package:crafty_bay/presentation/state_holders/add_review_controller.dart';
import 'package:crafty_bay/presentation/state_holders/review_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddReviewScreen extends StatefulWidget {
  const AddReviewScreen({super.key, required this.productId});

  final int productId;

  @override
  State<AddReviewScreen> createState() => _AddReviewScreenState();
}

class _AddReviewScreenState extends State<AddReviewScreen> {
  final TextEditingController _productIdTEController = TextEditingController();
  final TextEditingController _ratingTEController = TextEditingController();
  final TextEditingController _writeReviewTEController =
      TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _productIdTEController.text = widget.productId.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Review'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 36, right: 36, top: 60),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextFormField(
                  controller: _ratingTEController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: 'Rating', hintText: ' 0/5'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter rating number 1 to 5 !';
                    } else if (!RegExp(r'^[1-5]$').hasMatch(value)) {
                      return 'Enter single digit 1 to 5 !';
                    }
                    return null; // Return null if the input is valid
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _writeReviewTEController,
                  textInputAction: TextInputAction.done,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    hintText: 'Write Review',
                  ),
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return 'Please enter text';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<AddReviewController>(
                      builder: (reviewController) {
                    return Visibility(
                      visible: reviewController.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            final response = await reviewController.addReview(
                              widget.productId,
                              int.parse(
                                _ratingTEController.text.trim(),
                              ),
                              _writeReviewTEController.text.trim(),
                            );
                            if (response) {
                              if (mounted) {
                                Navigator.pop(context);
                              }

                              Get.find<ReviewListController>()
                                  .getReviewList(widget.productId);
                            } else {
                              Get.showSnackbar(
                                GetSnackBar(
                                  title: 'Create review failed',
                                  message: reviewController.errorMessage,
                                  duration: const Duration(seconds: 2),
                                  isDismissible: true,
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productIdTEController.clear();
    _ratingTEController.clear();
    _writeReviewTEController.clear();
    super.dispose();
  }
}
