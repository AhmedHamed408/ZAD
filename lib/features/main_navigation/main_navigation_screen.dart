import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../localization/app_localizations.dart';
import '../../providers/language_provider.dart';
import '../../core/constants/app_colors.dart';
import '../home/home_screen.dart';
import '../internet/internet_screen.dart';
import '../qr/qr_screen.dart';
import '../history/history_screen.dart';
import '../settings/settings_screen.dart';
import '../assistant/widgets/zad_assistant_sheet.dart';
import '../chat/widgets/zad_conversations_sheet.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({super.key, this.initialIndex = 0});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  final List<Widget> _screens = const [
    HomeScreen(),
    InternetScreen(),
    QrScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _showAssistantPanel(BuildContext context) {
    final routes = ['/home', '/internet', '/qr', '/history', '/settings'];
    final currentRoute = routes[_currentIndex];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ZadAssistantSheet(currentRoute: currentRoute),
    );
  }

  void _showConversationsSheet(BuildContext context) {
    ZadConversationsSheet.show(context);
  }

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final navItems = [
      _NavItem(
        icon: Icons.home_outlined,
        activeIcon: Icons.home_rounded,
        labelKey: 'home',
      ),
      _NavItem(
        icon: Icons.wifi_rounded,
        activeIcon: Icons.signal_wifi_4_bar_rounded,
        labelKey: 'internet',
      ),
      _NavItem(
        icon: Icons.qr_code_scanner_rounded,
        activeIcon: Icons.qr_code_2_rounded,
        labelKey: 'qr',
      ),
      _NavItem(
        icon: Icons.receipt_long_outlined,
        activeIcon: Icons.receipt_long_rounded,
        labelKey: 'history',
      ),
      _NavItem(
        icon: Icons.settings_outlined,
        activeIcon: Icons.settings_rounded,
        labelKey: 'settings',
      ),
    ];

    return Directionality(
      textDirection: languageProvider.isRTL ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),

        // Stacked Floating Action Buttons on Lower-Right Side
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Upper FAB: ZAD Assistant (💡)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.amber.shade700.withValues(alpha: 0.35),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: FloatingActionButton.small(
                  heroTag: 'fab_assistant_main',
                  onPressed: () => _showAssistantPanel(context),
                  backgroundColor: isDark ? AppColors.darkSurface : Colors.amber.shade700,
                  elevation: 4,
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    color: Colors.amberAccent,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Lower FAB: ZAD Conversations (💬)
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: FloatingActionButton(
                  heroTag: 'fab_conversations_main',
                  onPressed: () => _showConversationsSheet(context),
                  backgroundColor: AppColors.accent,
                  elevation: 6,
                  child: const Icon(
                    Icons.chat_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        ),

        // Redesigned Premium Fintech Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                blurRadius: 16,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(navItems.length, (index) {
                  final isSelected = _currentIndex == index;
                  final item = navItems[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    behavior: HitTestBehavior.opaque,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.easeOutCubic,
                      padding: EdgeInsets.symmetric(
                        horizontal: isSelected ? 14 : 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.accent.withValues(alpha: 0.16)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected ? item.activeIcon : item.icon,
                            color: isSelected
                                ? AppColors.accent
                                : (isDark
                                    ? AppColors.darkTextSecondary
                                    : Colors.grey.shade600),
                            size: 24,
                          ),
                          if (isSelected) ...[
                            const SizedBox(width: 6),
                            Text(
                              item.labelKey.tr(context),
                              style: const TextStyle(
                                color: AppColors.accent,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String labelKey;

  _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.labelKey,
  });
}
