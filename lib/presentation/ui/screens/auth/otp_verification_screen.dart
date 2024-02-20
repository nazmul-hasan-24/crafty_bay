import 'package:crafty_bay/presentation/state_holders/otp_tirmer_controller.dart';
import 'package:crafty_bay/presentation/state_holders/send_email_otp_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/auth/complete_profile_screen.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.email});

  final String email;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final otpTimer = Get.find<OTPTimerController>();
  @override
  void initState() {
    super.initState();
    otpTimer.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 120,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Enter OTP Code',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'A 6 digit OTP code has been sent',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 24,
                ),
                PinCodeTextField(
                  controller: _otpTEController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter OTP";
                    } else if (value.length != 6) {
                      return "OTP must be 6 digits";
                    }
                    return null;
                  },
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      activeFillColor: Colors.transparent,
                      inactiveFillColor: Colors.transparent,
                      inactiveColor: AppColors.primaryColor,
                      selectedFillColor: Colors.transparent,
                      selectedColor: Colors.purple),
                  animationDuration: const Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,
                  appContext: context,
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<VerifyOTPController>(
                      builder: (verifyOtpController) {
                    return Visibility(
                      visible: verifyOtpController.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await verifyOtpController
                                .verifyOTP(widget.email, _otpTEController.text);
                            if (response) {
                              if (verifyOtpController
                                  .shouldNavigateCompleteProfile) {
                                Get.to(() => const CompleteProfileScreen());
                                otpTimer.onClose();
                              } else {
                                Get.offAll(() => const MainBottomNavScreen());
                                otpTimer.onClose();
                              }
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: 'OTP verification failed',
                                message: verifyOtpController.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ));
                            }
                          }
                        },
                        child: const Text('Next'),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                GetBuilder<OTPTimerController>(builder: (oTPTimerController) {
                  return RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        const TextSpan(text: 'This code will expire in: '),
                        TextSpan(
                          text: '${otpTimer.count}',
                          style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                TextButton(
                  onPressed: () async {
                    Get.find<SendEmailOTPController>()
                        .sendOTPEmail(widget.email);
                    if (otpTimer.count == 0.obs) {
                      otpTimer.count.value = 120;
                    }
                  },
                  child: Text(
                    'Resend Code',
                    style: TextStyle(
                        color: otpTimer.count.value == 0
                            ? AppColors.primaryColor
                            : Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _otpTEController.dispose();
  }
}
