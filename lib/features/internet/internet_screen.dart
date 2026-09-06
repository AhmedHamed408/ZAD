import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/internet_provider.dart';
import '../../providers/language_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import 'widgets/zad_country_card.dart';
import 'widgets/zad_package_card.dart';
import 'widgets/zad_purchase_summary_dialog.dart';

class InternetScreen extends StatefulWidget {
  const InternetScreen({super.key});

  @override
  State<InternetScreen> createState() => _InternetScreenState();
}

class _InternetScreenState extends State<InternetScreen> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _handleBuy(BuildContext context, dynamic package) async {
    final purchasedMsg = 'package_purchased'.tr(context);
    final messenger = ScaffoldMessenger.of(context);
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => ZadPurchaseSummaryDialog(package: package),
    );

    if (result == true && mounted) {
      messenger.showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.check_circle_rounded, color: Colors.white),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  '$purchasedMsg: ${package.name} (${package.countryFlag} ${package.country})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final langProvider = Provider.of<LanguageProvider>(context);
    final internetProvider = Provider.of<InternetProvider>(context);

    final langCode = langProvider.locale.languageCode;
    final selectedCountry = internetProvider.selectedCountryModel;
    final filteredCountries = internetProvider.filteredCountries;
    final packages = internetProvider.packagesForSelectedCountry;

    // Popular destination IDs
    final popularIds = ['eg', 'sa', 'ae', 'kw', 'qa', 'ma', 'ly', 'jo'];
    final popularCountries = internetProvider.allCountries
        .where((c) => popularIds.contains(c.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('mkt_title'.tr(context)),
        centerTitle: false,
        elevation: 0,
      ),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // 1. Marketplace Header & Subtitle
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'mkt_subtitle'.tr(context),
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Search Country TextField
                    TextField(
                      controller: _searchController,
                      onChanged: (val) {
                        internetProvider.setSearchQuery(val);
                      },
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'search_country_hint'.tr(context),
                        hintStyle: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                        prefixIcon:
                            const Icon(Icons.search_rounded, color: AppColors.accent),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear_rounded, size: 18),
                                onPressed: () {
                                  _searchController.clear();
                                  internetProvider.setSearchQuery('');
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: isDark
                            ? AppColors.darkSurface
                            : Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: isDark
                                ? AppColors.darkBorder
                                : AppColors.lightBorder,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide:
                              const BorderSide(color: AppColors.accent, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Popular Destinations (Horizontal Chips)
            if (internetProvider.searchQuery.isEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'popular_destinations'.tr(context),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  height: 46,
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: popularCountries.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final country = popularCountries[index];
                      final isSelected = country.id == selectedCountry.id;

                      return InkWell(
                        onTap: () {
                          internetProvider.selectCountry(country.id);
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent
                                : (isDark
                                    ? AppColors.darkCard
                                    : Colors.white),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : (isDark
                                      ? AppColors.darkBorder
                                      : AppColors.lightBorder),
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(country.flag,
                                  style: const TextStyle(fontSize: 16)),
                              const SizedBox(width: 6),
                              Text(
                                country.getLocalizedName(langCode),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.w500,
                                  color: isSelected
                                      ? Colors.white
                                      : (isDark
                                          ? AppColors.darkTextPrimary
                                          : AppColors.lightTextPrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            // 3. Country Selection List / Grid Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'all_countries'.tr(context),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    Text(
                      '${filteredCountries.length} / 22',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Country Cards Grid View
            if (filteredCountries.isEmpty)
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkCard : Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.public_off_rounded,
                          size: 44, color: AppColors.accent),
                      const SizedBox(height: 12),
                      Text(
                        'no_countries_found'.tr(context),
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton(
                        onPressed: () {
                          _searchController.clear();
                          internetProvider.setSearchQuery('');
                        },
                        child: Text('reset_search'.tr(context)),
                      ),
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 2.2,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final country = filteredCountries[index];
                      final isSelected = country.id == selectedCountry.id;

                      return ZadCountryCard(
                        country: country,
                        isSelected: isSelected,
                        languageCode: langCode,
                        onTap: () {
                          internetProvider.selectCountry(country.id);
                        },
                      );
                    },
                    childCount: filteredCountries.length,
                  ),
                ),
              ),

            // 4. Selected Country Header & Packages Section
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 24, 20, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 1),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Text(selectedCountry.flag,
                            style: const TextStyle(fontSize: 26)),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${selectedCountry.getLocalizedName(langCode)} (${selectedCountry.currencyCode})',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: isDark
                                      ? AppColors.darkTextPrimary
                                      : AppColors.lightTextPrimary,
                                ),
                              ),
                              Text(
                                'Available ZAD Data Packages (${selectedCountry.currencySymbol})',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isDark
                                      ? AppColors.darkTextSecondary
                                      : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Package Size Filter Chips (All, 10 GB, 25 GB, 50 GB)
                    Row(
                      children: [
                        _buildSizeFilterChip(context,
                            label: 'filter_all'.tr(context), sizeGb: null),
                        const SizedBox(width: 8),
                        _buildSizeFilterChip(context, label: '10 GB', sizeGb: 10),
                        const SizedBox(width: 8),
                        _buildSizeFilterChip(context, label: '25 GB', sizeGb: 25),
                        const SizedBox(width: 8),
                        _buildSizeFilterChip(context, label: '50 GB', sizeGb: 50),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Packages List
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final pkg = packages[index];
                    final isPurchased =
                        internetProvider.isPackagePurchased(pkg.id);

                    return ZadPackageCard(
                      package: pkg,
                      isPurchased: isPurchased,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/package-details',
                          arguments: pkg,
                        );
                      },
                      onBuyTap: () => _handleBuy(context, pkg),
                    );
                  },
                  childCount: packages.length,
                ),
              ),
            ),

            const SliverToBoxAdapter(
              child: SizedBox(height: 40),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSizeFilterChip(BuildContext context,
      {required String label, required int? sizeGb}) {
    final internetProvider = Provider.of<InternetProvider>(context);
    final isSelected = internetProvider.selectedSizeFilter == sizeGb;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return FilterChip(
      selected: isSelected,
      showCheckmark: false,
      label: Text(label),
      labelStyle: TextStyle(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        color: isSelected
            ? Colors.white
            : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
      ),
      selectedColor: AppColors.primary,
      backgroundColor: isDark ? AppColors.darkCard : Colors.grey.shade200,
      onSelected: (_) {
        internetProvider.setSizeFilter(sizeGb);
      },
    );
  }
}
