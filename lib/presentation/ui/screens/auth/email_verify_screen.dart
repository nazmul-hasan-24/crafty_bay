import 'package:crafty_bay/presentation/state_holders/send_email_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/otp_verification_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({
    super.key,
  });

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailTextEditingController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 160,
                ),
                const AppLogo(),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Welcome Back',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  "Please Enter Your Email Address",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 22,
                ),
                TextFormField(
                  controller: _emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(hintText: "Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter an email address';
                    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 22,
                ),
                GetBuilder<SendEmailOTPController>(builder: (controller) {
                  return Visibility(
                    visible: controller.inProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          bool result = await controller.sendOTPEmail(
                            _emailTextEditingController.text.trim(),
                          );
                          if (result) {
                            Get.to(
                              () => VerifyOTPScreen(
                                email: _emailTextEditingController.text.trim(),
                              ),
                            );
                          } else {
                            Get.showSnackbar(
                              GetSnackBar(
                                title: "Send OTP failed",
                                message: controller.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ),
                            );
                          }
                        }
                      },
                      child: const Text("Next"),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
