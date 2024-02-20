import 'package:crafty_bay/data/models/create_profile_param.dart';
import 'package:crafty_bay/presentation/state_holders/complete_profile_controller.dart';
import 'package:crafty_bay/presentation/state_holders/verify_otp_controller.dart';
import 'package:crafty_bay/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final TextEditingController _fulltNameTEController = TextEditingController();
  final TextEditingController _cusAddressController = TextEditingController();
  final TextEditingController _cityTEController = TextEditingController();
  final _stateTEC = TextEditingController();
  final _postCodeTEc = TextEditingController();
  final _countryTEC = TextEditingController();
  final TextEditingController _mobileTEC = TextEditingController();
  final _faxTEC = TextEditingController();
  final _shipNameTec = TextEditingController();
  final _shipAddressTEController = TextEditingController();
  final _shipCityTEC = TextEditingController();
  final _shipStateTEX = TextEditingController();
  final _shipPostCodeTEC = TextEditingController();
  final _shipCountryTEC = TextEditingController();
  final _shipPhoneTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                  height: 48,
                ),
                const AppLogo(
                  height: 80,
                ),
                const SizedBox(
                  height: 24,
                ),
                Text(
                  'Complete Profile',
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 28),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Get started with us with your details',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: _fulltNameTEController,
                  decoration: const InputDecoration(
                    labelText: 'Full name',
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your full name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _cusAddressController,
                  decoration: const InputDecoration(labelText: 'Address'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter Address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _cityTEController,
                  decoration: const InputDecoration(labelText: 'City'),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter City';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _stateTEC,
                  decoration: const InputDecoration(labelText: 'State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your state name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _postCodeTEc,
                  decoration: const InputDecoration(labelText: 'Post code'),
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Enter your Post code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _countryTEC,
                  decoration: const InputDecoration(labelText: 'Country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your country name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _mobileTEC,
                  decoration: const InputDecoration(labelText: 'Phone number'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your phone number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _faxTEC,
                  decoration: const InputDecoration(labelText: 'Fax number'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your fax Number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipNameTec,
                  decoration:
                      const InputDecoration(labelText: 'Shippping Name'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter shipping name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipAddressTEController,
                  decoration:
                      const InputDecoration(labelText: 'Shipping Address'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your shippping address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipCityTEC,
                  decoration: const InputDecoration(labelText: 'Shipping city'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your shipping city name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipStateTEX,
                  decoration: const InputDecoration(labelText: 'Ship State'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your shipping state name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipPostCodeTEC,
                  decoration:
                      const InputDecoration(labelText: 'Shipping post code'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your shipping post code';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipCountryTEC,
                  decoration:
                      const InputDecoration(labelText: 'Shipping country'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your County name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: _shipPhoneTEC,
                  decoration:
                      const InputDecoration(labelText: 'Shipping phone'),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter your shipping number';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 24,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CompleteProfileController>(
                      builder: (completeProfileController) {
                    return Visibility(
                      visible: completeProfileController.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final createProfileParams = CreateProfileParams(
                              cusName: _fulltNameTEController.text.trim(),
                              cusAdd: _cusAddressController.text.trim(),
                              cusCity: _cityTEController.text.trim(),
                              cusState: _stateTEC.text.trim(),
                              cusPostcode: _postCodeTEc.text.trim(),
                              cusCountry: _countryTEC.text.trim(),
                              cusPhone: _mobileTEC.text,
                              cusFax: _faxTEC.text.trim(),
                              shipName: _shipNameTec.text.trim(),
                              shipAdd: _shipAddressTEController.text.trim(),
                              shipCity: _shipCityTEC.text,
                              shipState: _shipStateTEX.text.trim(),
                              shipPostcode: _shipPostCodeTEC.text.trim(),
                              shipCountry: _shipCountryTEC.text.trim(),
                              shipPhone: _shipPhoneTEC.text.trim(),
                            );
                            final bool result = await completeProfileController
                                .createProfileData(
                                    Get.find<VerifyOTPController>().token,
                                    createProfileParams);
                            if (result) {
                              Get.offAll(() => const MainBottomNavScreen());
                            } else {
                              Get.showSnackbar(GetSnackBar(
                                title: 'Complete profile failed',
                                message: completeProfileController.errorMessage,
                                duration: const Duration(seconds: 2),
                                isDismissible: true,
                              ));
                            }
                          }
                        },
                        child: const Text('Complete'),
                      ),
                    );
                  }),
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
    _fulltNameTEController.dispose();
    _cusAddressController.dispose();
    _cityTEController.dispose();
    _mobileTEC.dispose();
    _shipAddressTEController.dispose();
    super.dispose();
  }
}
