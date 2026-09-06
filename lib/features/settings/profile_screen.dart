import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showComingSoonDialog(BuildContext context, String fieldName) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('coming_soon'.tr(context)),
          content: Text('feature_coming_soon'.tr(context)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK', style: TextStyle(color: AppColors.accent)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileTile(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(icon, color: AppColors.accent),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.edit_outlined, size: 20, color: AppColors.accent),
          onPressed: () => _showComingSoonDialog(context, label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('user_profile'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 10),

              // Avatar Header
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 54,
                      backgroundImage: NetworkImage(
                        user?.profileImage ?? 'https://i.pravatar.cc/300?img=11',
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => _showComingSoonDialog(context, 'Profile Picture'),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: AppColors.accent,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              _buildProfileTile(
                context,
                label: 'full_name'.tr(context),
                value: user?.name ?? 'Ahmed Hassan',
                icon: Icons.person_outline_rounded,
              ),

              _buildProfileTile(
                context,
                label: 'phone_number'.tr(context),
                value: user?.phone ?? '01012345678',
                icon: Icons.phone_android_rounded,
              ),

              _buildProfileTile(
                context,
                label: 'email'.tr(context),
                value: user?.email ?? 'ahmed.hassan@zad.com',
                icon: Icons.email_outlined,
              ),

              _buildProfileTile(
                context,
                label: 'national_id'.tr(context),
                value: user?.nationalId ?? '29801011234567',
                icon: Icons.badge_outlined,
              ),

              _buildProfileTile(
                context,
                label: 'date_of_birth'.tr(context),
                value: user?.birthDate ?? '1998-01-15',
                icon: Icons.calendar_today_outlined,
              ),

              _buildProfileTile(
                context,
                label: 'Address',
                value: user?.address ?? '15 Tahrir Square, Downtown, Cairo',
                icon: Icons.home_work_outlined,
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
