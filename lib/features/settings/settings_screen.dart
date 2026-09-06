import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showComingSoon(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title),
        content: Text('feature_coming_soon'.tr(context)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: AppColors.accent)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('settings'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Profile Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(
                          user?.profileImage ?? 'https://i.pravatar.cc/300?img=11',
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.name ?? 'Ahmed Hassan',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              user?.phone ?? '01012345678',
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'ID: ${user?.nationalId ?? "29801011234567"}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Pencil Edit Icon -> Navigates to Profile Screen
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/profile');
                        },
                        icon: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_outlined,
                            color: AppColors.accent,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // "Responsible" Location Lookup Section Card
              Card(
                color: isDark ? AppColors.darkSurface : Colors.blue.shade50,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  onTap: () {
                    Navigator.pushNamed(context, '/responsible');
                  },
                  leading: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.location_on_rounded, color: Colors.white),
                  ),
                  title: Text(
                    'responsible'.tr(context),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'responsible_desc'.tr(context),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
                ),
              ),

              const SizedBox(height: 24),

              // Preferences Header
              Text(
                'Preferences',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 10),

              // Language Selector Tile
              Card(
                child: ListTile(
                  leading: const Icon(Icons.language_rounded, color: AppColors.accent),
                  title: Text('language'.tr(context)),
                  subtitle: Text(
                    languageProvider.locale.languageCode == 'ar'
                        ? 'العربية (Arabic)'
                        : languageProvider.locale.languageCode == 'en'
                            ? 'English'
                            : languageProvider.locale.languageCode == 'fr'
                                ? 'Français (French)'
                                : 'Italiano (Italian)',
                  ),
                  trailing: DropdownButton<String>(
                    value: languageProvider.locale.languageCode,
                    underline: const SizedBox.shrink(),
                    onChanged: (lang) {
                      if (lang != null) {
                        languageProvider.setLanguage(lang);
                      }
                    },
                    items: const [
                      DropdownMenuItem(value: 'ar', child: Text('🇪🇬 العربية')),
                      DropdownMenuItem(value: 'en', child: Text('🇺🇸 English')),
                      DropdownMenuItem(value: 'fr', child: Text('🇫🇷 Français')),
                      DropdownMenuItem(value: 'it', child: Text('🇮🇹 Italiano')),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Theme Mode Selector Tile
              Card(
                child: ListTile(
                  leading: const Icon(Icons.palette_outlined, color: AppColors.accent),
                  title: Text('theme'.tr(context)),
                  subtitle: Text(
                    themeProvider.themeMode == ThemeMode.light
                        ? 'light'.tr(context)
                        : themeProvider.themeMode == ThemeMode.dark
                            ? 'dark'.tr(context)
                            : 'system'.tr(context),
                  ),
                  trailing: DropdownButton<ThemeMode>(
                    value: themeProvider.themeMode,
                    underline: const SizedBox.shrink(),
                    onChanged: (mode) {
                      if (mode != null) {
                        themeProvider.setThemeMode(mode);
                      }
                    },
                    items: [
                      DropdownMenuItem(
                        value: ThemeMode.light,
                        child: Text('light'.tr(context)),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.dark,
                        child: Text('dark'.tr(context)),
                      ),
                      DropdownMenuItem(
                        value: ThemeMode.system,
                        child: Text('system'.tr(context)),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Settings & Security Header
              Text(
                'Security & App Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 10),

              Card(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.notifications_outlined),
                      title: Text('notifications'.tr(context)),
                      onTap: () => _showComingSoon(context, 'notifications'.tr(context)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.security_rounded),
                      title: Text('security'.tr(context)),
                      onTap: () => _showComingSoon(context, 'security'.tr(context)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.privacy_tip_outlined),
                      title: Text('privacy'.tr(context)),
                      onTap: () => _showComingSoon(context, 'privacy'.tr(context)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.help_outline_rounded),
                      title: Text('help_support'.tr(context)),
                      onTap: () => _showComingSoon(context, 'help_support'.tr(context)),
                    ),
                    const Divider(height: 1),
                    ListTile(
                      leading: const Icon(Icons.info_outline_rounded),
                      title: Text('about_zad'.tr(context)),
                      subtitle: Text('app_version'.tr(context)),
                      onTap: () => _showComingSoon(context, 'about_zad'.tr(context)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // Logout Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () async {
                    await authProvider.logout();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(
                          context, '/login', (route) => false);
                    }
                  },
                  icon: const Icon(Icons.logout_rounded, color: AppColors.error),
                  label: Text(
                    'logout'.tr(context),
                    style: const TextStyle(
                      color: AppColors.error,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.error),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppStyles.buttonRadius),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
