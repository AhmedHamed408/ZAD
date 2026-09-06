import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/zad_logo.dart';
import '../../data/models/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Ahmed Hassan');
  final _phoneController = TextEditingController(text: '01012345678');
  final _emailController = TextEditingController(text: 'ahmed.hassan@zad.com');
  final _nationalIdController = TextEditingController(text: '29801011234567');
  final _dobController = TextEditingController(text: '1998-01-15');
  final _passwordController = TextEditingController(text: '123456');
  final _confirmPasswordController = TextEditingController(text: '123456');

  bool _idFrontUploaded = false;
  bool _idBackUploaded = false;
  bool _selfieUploaded = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _nationalIdController.dispose();
    _dobController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Passwords do not match'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final newUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: _nameController.text,
      phone: _phoneController.text,
      email: _emailController.text,
      nationalId: _nationalIdController.text,
      birthDate: _dobController.text,
      profileImage: 'https://i.pravatar.cc/300?img=11',
      balance: 25450.00,
      currency: 'EGP',
      location: 'Cairo, Egypt',
    );

    // Navigate to OTP with user arguments
    Navigator.pushNamed(context, '/otp', arguments: newUser);
  }

  Widget _buildUploadCard({
    required String title,
    required bool isUploaded,
    required VoidCallback onTap,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isUploaded
              ? AppColors.success.withValues(alpha: 0.1)
              : (isDark ? AppColors.darkSurface : Colors.white),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isUploaded
                ? AppColors.success
                : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
            width: isUploaded ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isUploaded
                    ? AppColors.success
                    : AppColors.accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                isUploaded ? Icons.check_circle_rounded : icon,
                color: isUploaded ? Colors.white : AppColors.accent,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    isUploaded
                        ? 'image_uploaded'.tr(context)
                        : 'select_image'.tr(context),
                    style: TextStyle(
                      fontSize: 12,
                      color: isUploaded
                          ? AppColors.success
                          : (isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.camera_alt_outlined,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : AppColors.lightTextSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('create_account'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Column(
                    children: [
                      ZadLogo(
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(height: 12),
                    ],
                  ),
                ),
                Text(
                  'signup_subtitle'.tr(context),
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                CustomTextField(
                  labelText: 'full_name'.tr(context),
                  controller: _nameController,
                  prefixIcon: const Icon(Icons.person_outline_rounded),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'phone_number'.tr(context),
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  prefixIcon: const Icon(Icons.phone_android_rounded),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'email'.tr(context),
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: const Icon(Icons.email_outlined),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'national_id'.tr(context),
                  controller: _nationalIdController,
                  keyboardType: TextInputType.number,
                  prefixIcon: const Icon(Icons.badge_outlined),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'date_of_birth'.tr(context),
                  controller: _dobController,
                  prefixIcon: const Icon(Icons.calendar_today_outlined),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'password'.tr(context),
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 16),

                CustomTextField(
                  labelText: 'confirm_password'.tr(context),
                  controller: _confirmPasswordController,
                  obscureText: _obscurePassword,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
                const SizedBox(height: 24),

                // KYC Image Upload Section Title
                const Text(
                  'Identity Verification (KYC Demo)',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 12),

                _buildUploadCard(
                  title: 'upload_id_front'.tr(context),
                  isUploaded: _idFrontUploaded,
                  icon: Icons.credit_card_rounded,
                  onTap: () {
                    setState(() => _idFrontUploaded = !_idFrontUploaded);
                  },
                ),
                const SizedBox(height: 12),

                _buildUploadCard(
                  title: 'upload_id_back'.tr(context),
                  isUploaded: _idBackUploaded,
                  icon: Icons.credit_card_outlined,
                  onTap: () {
                    setState(() => _idBackUploaded = !_idBackUploaded);
                  },
                ),
                const SizedBox(height: 12),

                _buildUploadCard(
                  title: 'selfie_verification'.tr(context),
                  isUploaded: _selfieUploaded,
                  icon: Icons.face_rounded,
                  onTap: () {
                    setState(() => _selfieUploaded = !_selfieUploaded);
                  },
                ),
                const SizedBox(height: 32),

                CustomButton(
                  text: 'submit_registration'.tr(context),
                  onPressed: _handleSubmit,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
