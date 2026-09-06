import 'package:flutter/material.dart';
import '../../../data/models/internet_package_model.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_styles.dart';
import '../../../core/utils/currency_formatter.dart';
import '../../../localization/app_localizations.dart';

class ZadPackageCard extends StatelessWidget {
  final InternetPackageModel package;
  final bool isPurchased;
  final VoidCallback onTap;
  final VoidCallback onBuyTap;

  const ZadPackageCard({
    super.key,
    required this.package,
    required this.isPurchased,
    required this.onTap,
    required this.onBuyTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(AppStyles.cardRadius),
        border: Border.all(
          color: package.badge == 'best_value'
              ? AppColors.accent
              : (isDark ? AppColors.darkBorder : AppColors.lightBorder),
          width: package.badge == 'best_value' ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppStyles.cardRadius),
        child: Column(
          children: [
            // Top Badge Banner Row if badge exists
            if (package.badge != null || isPurchased)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                color: isPurchased
                    ? AppColors.success.withValues(alpha: 0.15)
                    : (package.badge == 'best_value'
                        ? AppColors.accent.withValues(alpha: 0.15)
                        : Colors.amber.withValues(alpha: 0.15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          isPurchased
                              ? Icons.check_circle_rounded
                              : (package.badge == 'best_value'
                                  ? Icons.star_rounded
                                  : Icons.local_fire_department_rounded),
                          size: 14,
                          color: isPurchased
                              ? AppColors.success
                              : (package.badge == 'best_value'
                                  ? AppColors.accent
                                  : Colors.amber.shade800),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isPurchased
                              ? 'Active ✓'
                              : (package.badge == 'best_value'
                                  ? 'best_value_badge'.tr(context)
                                  : 'popular_badge'.tr(context)),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: isPurchased
                                ? AppColors.success
                                : (package.badge == 'best_value'
                                    ? AppColors.accent
                                    : Colors.amber.shade800),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'demo_package_notice'.tr(context),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Card Body
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Country flag & Package title
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              package.countryFlag,
                              style: const TextStyle(fontSize: 22),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  package.name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: isDark
                                        ? AppColors.darkTextPrimary
                                        : AppColors.lightTextPrimary,
                                  ),
                                ),
                                Text(
                                  package.country,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? AppColors.darkTextSecondary
                                        : AppColors.lightTextSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Data GB Large Pill
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            package.data,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Key Specs Row (Data, Validity, Speed)
                    Row(
                      children: [
                        _buildSpecTile(
                          context,
                          icon: Icons.wifi_rounded,
                          label: 'data_allowance'.tr(context),
                          value: package.data,
                        ),
                        const SizedBox(width: 12),
                        _buildSpecTile(
                          context,
                          icon: Icons.calendar_month_rounded,
                          label: 'validity'.tr(context),
                          value: '${package.validityDays} ${'days'.tr(context)}',
                        ),
                        const SizedBox(width: 12),
                        _buildSpecTile(
                          context,
                          icon: Icons.speed_rounded,
                          label: 'Speed',
                          value: '5G / 4G+',
                        ),
                      ],
                    ),

                    const Divider(height: 24),

                    // Price & Buy Button Footer Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              CurrencyFormatter.format(package.price,
                                  currency: package.currency),
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: isDark ? AppColors.accent : AppColors.primary,
                              ),
                            ),
                            Text(
                              '${package.currencySymbol} / 30 ${'days'.tr(context)}',
                              style: TextStyle(
                                fontSize: 11,
                                color: isDark
                                    ? AppColors.darkTextSecondary
                                    : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),

                        ElevatedButton.icon(
                          onPressed: onBuyTap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                isPurchased ? AppColors.success : AppColors.accent,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          icon: Icon(
                            isPurchased
                                ? Icons.check_circle_rounded
                                : Icons.shopping_bag_outlined,
                            size: 16,
                          ),
                          label: Text(
                            isPurchased
                                ? 'Active ✓'
                                : 'buy_package'.tr(context),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : Colors.grey.shade50,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.accent),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark
                    ? AppColors.darkTextPrimary
                    : AppColors.lightTextPrimary,
              ),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10,
                color: isDark
                    ? AppColors.darkTextSecondary
                    : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
