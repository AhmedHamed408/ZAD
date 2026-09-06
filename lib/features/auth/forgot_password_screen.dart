import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  int _currentStep = 1;
  final _phoneController = TextEditingController(text: '01012345678');
  final _otpController = TextEditingController(text: '123456');
  final _newPasswordController = TextEditingController(text: '123456');
  final _confirmPasswordController = TextEditingController(text: '123456');

  bool _obscure = true;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep == 1) {
      if (_phoneController.text.isEmpty) return;
      setState(() => _currentStep = 2);
    } else if (_currentStep == 2) {
      if (_otpController.text != '123456' && _otpController.text.length != 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Use demo OTP: 123456')),
        );
        return;
      }
      setState(() => _currentStep = 3);
    } else if (_currentStep == 3) {
      if (_newPasswordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Password reset successfully! Please log in.'),
          backgroundColor: AppColors.success,
        ),
      );
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reset_password'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Step Progress Indicator Bar
              Row(
                children: List.generate(3, (index) {
                  final stepNum = index + 1;
                  final isActive = stepNum <= _currentStep;
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      decoration: BoxDecoration(
                        color: isActive ? AppColors.accent : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 32),

              if (_currentStep == 1) ...[
                const Text(
                  'Step 1: Enter Phone Number',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Enter your registered phone number to receive a password reset OTP code.'),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'phone_number'.tr(context),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_android_rounded),
                ),
              ] else if (_currentStep == 2) ...[
                const Text(
                  'Step 2: Verify OTP Code',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Enter the 6-digit OTP code sent to your phone (Demo Code: 123456).'),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'OTP Code',
                  controller: _otpController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.pin_outlined),
                ),
              ] else ...[
                const Text(
                  'Step 3: New Password',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text('Create a strong new password for your ZAD account.'),
                const SizedBox(height: 24),
                CustomTextField(
                  labelText: 'new_password'.tr(context),
                  controller: _newPasswordController,
                  obscureText: _obscure,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  ),
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  labelText: 'confirm_new_password'.tr(context),
                  controller: _confirmPasswordController,
                  obscureText: _obscure,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                ),
              ],

              const SizedBox(height: 40),
              CustomButton(
                text: _currentStep == 3 ? 'save_password'.tr(context) : 'continue_btn'.tr(context),
                onPressed: _nextStep,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
