import 'package:flutter/material.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/user_model.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

class ResponsibleScreen extends StatefulWidget {
  const ResponsibleScreen({super.key});

  @override
  State<ResponsibleScreen> createState() => _ResponsibleScreenState();
}

class _ResponsibleScreenState extends State<ResponsibleScreen> {
  final TextEditingController _phoneController = TextEditingController(text: '01123456789');
  UserModel? _foundUser;
  MockLocationData? _foundLocation;
  bool _hasSearched = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSearch() async {
    final query = _phoneController.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _isLoading = true;
      _hasSearched = false;
      _foundUser = null;
      _foundLocation = null;
    });

    await Future.delayed(const Duration(milliseconds: 700));

    // Match query with mock users & locations dataset
    UserModel? matchedUser;
    for (var u in MockData.mockUsers) {
      if (u.phone == query || (u.id == 'user_002' && (query == '01023456789' || query == '01123456789'))) {
        matchedUser = u;
        break;
      }
    }

    final locData = MockLocations.userLocations[query] ??
        ((query == '01023456789') ? MockLocations.userLocations['01123456789'] : null);

    setState(() {
      _isLoading = false;
      _hasSearched = true;
      _foundUser = matchedUser;
      _foundLocation = locData;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: Text('responsible'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Safety Disclaimer Notice Box
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.warning.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.warning.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.shield_outlined, color: AppColors.warning, size: 26),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '🔒 DEMO FEATURE: Location tracking is simulated using mock static data. No real GPS data is collected or transmitted.',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'responsible_desc'.tr(context),
                style: TextStyle(
                  fontSize: 14,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),

              const SizedBox(height: 20),

              CustomTextField(
                labelText: 'search_phone'.tr(context),
                hintText: '01123456789',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone_android_rounded),
              ),

              const SizedBox(height: 16),

              CustomButton(
                text: 'search'.tr(context),
                icon: Icons.search_rounded,
                isLoading: _isLoading,
                onPressed: _handleSearch,
              ),

              const SizedBox(height: 28),

              if (_hasSearched) ...[
                if (_foundUser != null || _foundLocation != null) ...[
                  // User Location Result Card
                  Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage(
                                  _foundUser?.profileImage ?? 'https://i.pravatar.cc/300?img=12',
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _foundUser?.name ?? _foundLocation?.userName ?? 'Egyptian Contact',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      _foundUser?.phone ?? _phoneController.text,
                                      style: const TextStyle(
                                        color: AppColors.accent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.success.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Text(
                                  'GPS Active',
                                  style: TextStyle(
                                    color: AppColors.success,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const Divider(height: 28),

                          Row(
                            children: [
                              const Icon(Icons.location_on_rounded,
                                  color: AppColors.error, size: 22),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _foundLocation?.city ?? _foundUser?.location ?? 'Cairo, Egypt',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 4),
                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              'Address: ${_foundLocation?.address ?? _foundUser?.address ?? "Egyptian District"}',
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ),

                          if (_foundLocation != null) ...[
                            const SizedBox(height: 4),
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                'Coordinates: Lat ${_foundLocation!.latitude}, Lng ${_foundLocation!.longitude}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ),
                          ],

                          const SizedBox(height: 10),

                          Padding(
                            padding: const EdgeInsets.only(left: 30),
                            child: Text(
                              '${'last_updated'.tr(context)} ${_foundLocation?.lastUpdated ?? "2 minutes ago"}',
                              style: const TextStyle(
                                fontSize: 11,
                                color: AppColors.accent,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Map View Graphic Placeholder Container
                          Container(
                            height: 180,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.blueGrey.shade100,
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                image: NetworkImage(
                                  'https://maps.googleapis.com/maps/api/staticmap?center=Cairo,Egypt&zoom=13&size=600x300&sensor=false',
                                ),
                                fit: BoxFit.cover,
                                opacity: 0.8,
                              ),
                            ),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withValues(alpha: 0.25),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: const BoxDecoration(
                                        color: AppColors.error,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.person_pin_circle_rounded,
                                        color: Colors.white,
                                        size: 32,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '📍 ${_foundUser?.name ?? _foundLocation?.userName ?? "Contact"} is here',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else ...[
                  // Not found card
                  Card(
                    color: AppColors.error.withValues(alpha: 0.08),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Icon(Icons.error_outline_rounded, color: AppColors.error, size: 28),
                          SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'User not found',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.error,
                                    fontSize: 15,
                                  ),
                                ),
                                SizedBox(height: 2),
                                Text(
                                  'This phone number is not registered with ZAD.',
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
