import 'package:crafty_bay/presentation/state_holders/create_invoice_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/payment_webview_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<CreateInvoiceController>().createInvoice();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: GetBuilder<CreateInvoiceController>(
          builder: (createInvoiceController) {
        if (createInvoiceController.inProgress) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        final invoiceWrapper =
            createInvoiceController.paymentMethodListModel.data!.first;
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 120,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Total: ${invoiceWrapper.total}',
                            style: textStyle),
                        Text('VAT: ${invoiceWrapper.vat}', style: textStyle),
                        Text('Payable: ${invoiceWrapper.payable}',
                            style: textStyle),
                      ],
                    )
                  ],
                ),
                ListView.separated(
                  primary: false,
                  shrinkWrap: true,
                  itemCount: invoiceWrapper.paymentMethodList?.length ?? 0,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () {
                        Get.to(() => PaymentWebViewScreen(
                            url: invoiceWrapper.paymentMethodList![index]
                                .redirectGatewayURL!));
                      },
                      leading: Image.network(
                          invoiceWrapper.paymentMethodList![index].logo ?? ''),
                      title: Text(
                          invoiceWrapper.paymentMethodList![index].name ?? ''),
                      trailing: const Icon(Icons.arrow_forward_outlined),
                    );
                  },
                  separatorBuilder: (_, __) => const Divider(),
                )
              ],
            ),
          ),
        );
      }),
    );
  }

  TextStyle get textStyle {
    return const TextStyle(
        fontWeight: FontWeight.w400, color: Colors.black, fontSize: 15);
  }
}
