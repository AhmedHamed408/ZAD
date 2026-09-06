import 'package:flutter/material.dart';
import '../models/assistant_topic_model.dart';
import '../data/assistant_topics_data.dart';
import 'assistant_search_field.dart';
import 'assistant_category_card.dart';
import 'assistant_quick_question.dart';
import 'assistant_guide_card.dart';
import '../../../core/constants/app_colors.dart';
import '../../../localization/app_localizations.dart';

class ZadAssistantSheet extends StatefulWidget {
  final String? currentRoute;

  const ZadAssistantSheet({
    super.key,
    this.currentRoute,
  });

  @override
  State<ZadAssistantSheet> createState() => _ZadAssistantSheetState();
}

class _ZadAssistantSheetState extends State<ZadAssistantSheet> {
  late TextEditingController _searchController;
  String _searchQuery = '';
  AssistantCategoryType? _selectedCategory;
  String? _selectedQuickQuery;

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

  List<QuickQuestionItem> _getQuickQuestions(BuildContext context) {
    return [
      QuickQuestionItem(
        label: 'q_send'.tr(context),
        query: 'send',
        icon: Icons.send_rounded,
      ),
      QuickQuestionItem(
        label: 'q_receive'.tr(context),
        query: 'receive',
        icon: Icons.move_to_inbox_rounded,
      ),
      QuickQuestionItem(
        label: 'q_qr'.tr(context),
        query: 'qr',
        icon: Icons.qr_code_scanner_rounded,
      ),
      QuickQuestionItem(
        label: 'q_internet'.tr(context),
        query: 'internet',
        icon: Icons.wifi_rounded,
      ),
      QuickQuestionItem(
        label: 'q_history'.tr(context),
        query: 'history',
        icon: Icons.receipt_long_rounded,
      ),
      QuickQuestionItem(
        label: 'q_theme'.tr(context),
        query: 'theme',
        icon: Icons.palette_outlined,
      ),
      QuickQuestionItem(
        label: 'q_lang'.tr(context),
        query: 'language',
        icon: Icons.language_rounded,
      ),
      QuickQuestionItem(
        label: 'q_demo'.tr(context),
        query: 'demo',
        icon: Icons.info_outline_rounded,
      ),
    ];
  }

  String _getContextualTipText(BuildContext context) {
    final route = widget.currentRoute;
    if (route == null || route == '/home') {
      return 'أنت الآن في شاشة الرئيسية! يمكنك متابعة الرصيد، التحويل السريع، والاطلاع على أحدث المعاملات.';
    } else if (route == '/send') {
      return 'أنت في شاشة تحويل الأموال! أدخل الرقم أو اسم المستلم والمبلغ وسعر الصرف التلقائي.';
    } else if (route == '/receive') {
      return 'أنت في شاشة استقبال الأموال! شارك رمز QR الخاص بك أو اطلب مبلغ محدد.';
    } else if (route == '/qr') {
      return 'أنت في شاشة مسح ودفع QR! امسح الرمز للدفع الفوري أو أنشئ رمز استقبال خاص بك.';
    } else if (route == '/internet') {
      return 'أنت في شاشة باقات الإنترنت! اختر المزود (ليبيانا، هاتف ليبيا، المدار) واشحن في ثوانٍ.';
    } else if (route == '/history') {
      return 'أنت في سجل المعاملات! تتبع مدفوعاتك ومشترياتك مقسمة باليوم والأسبوع.';
    } else if (route == '/settings') {
      return 'أنت في شاشة الإعدادات! تخصص المظهر (داكن/فاتح)، اللغة، الخصوصية والملف الشخصي.';
    } else if (route == '/responsible') {
      return 'أنت في شاشة تحديد موقع المسجلين! تتبع المواقع الجغرافية المسجلة على الخريطة.';
    } else if (route == '/chat') {
      return 'أنت في شاشة المحادثات! تواصل مع جهات اتصالك وأرسل المعاملات المالية داخل الدردشة.';
    }
    return 'أهلاً بك في ZAD! اختر أي قسم أو ابحث لمعرفة كل تفاصيل ومميزات التطبيق.';
  }

  List<AssistantTopicModel> _getFilteredTopics() {
    List<AssistantTopicModel> results = List.from(AssistantTopicsData.topics);

    final activeQuery = _searchQuery.trim().toLowerCase();

    if (activeQuery.isNotEmpty) {
      results = results.where((topic) {
        final matchesKeyword = topic.keywords
            .any((kw) => kw.toLowerCase().contains(activeQuery));
        final matchesId = topic.id.toLowerCase().contains(activeQuery);
        final matchesStepTitle = topic.steps.any((s) =>
            s.title.toLowerCase().contains(activeQuery) ||
            s.description.toLowerCase().contains(activeQuery));

        return matchesKeyword || matchesId || matchesStepTitle;
      }).toList();
    } else if (_selectedCategory != null) {
      results = results
          .where((topic) => topic.category == _selectedCategory)
          .toList();
    }

    return results;
  }

  void _handleNavigate(String route) {
    Navigator.of(context).pop();
    Navigator.of(context).pushNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredTopics = _getFilteredTopics();
    final quickQuestions = _getQuickQuestions(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag handle & Header
          const SizedBox(height: 12),
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: isDark ? Colors.grey.shade700 : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 12),

          // Assistant Brand Header Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                // Glowing Avatar Icon
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accent.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accent.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lightbulb_rounded,
                    color: AppColors.accent,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 14),
                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'asst_title'.tr(context),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: isDark
                                  ? AppColors.darkTextPrimary
                                  : AppColors.lightTextPrimary,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Interactive Guide',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'asst_subtitle'.tr(context),
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
                // Close button
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkCard
                          : Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: isDark
                          ? AppColors.darkTextPrimary
                          : AppColors.lightTextPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 1),

          // Scrollable Body
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                // 1. Contextual Screen Tip Banner
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: isDark
                          ? [
                              AppColors.primary.withValues(alpha: 0.3),
                              AppColors.darkCard,
                            ]
                          : [
                              AppColors.primary.withValues(alpha: 0.08),
                              Colors.white,
                            ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.explore_rounded,
                        color: AppColors.primary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'asst_contextual_title'.tr(context),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              _getContextualTipText(context),
                              style: TextStyle(
                                fontSize: 12,
                                height: 1.4,
                                color: isDark
                                    ? AppColors.darkTextPrimary
                                    : AppColors.lightTextPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // 2. Search Field
                AssistantSearchField(
                  controller: _searchController,
                  onChanged: (val) {
                    setState(() {
                      _searchQuery = val;
                      if (val.isNotEmpty) {
                        _selectedCategory = null;
                        _selectedQuickQuery = null;
                      }
                    });
                  },
                  onClear: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                ),

                const SizedBox(height: 16),

                // 3. Quick Questions Section
                Text(
                  'asst_quick_q_title'.tr(context),
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: quickQuestions.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      final q = quickQuestions[index];
                      final isSelected = _selectedQuickQuery == q.query;
                      return AssistantQuickQuestionChip(
                        item: q,
                        isSelected: isSelected,
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedQuickQuery = null;
                              _searchQuery = '';
                              _searchController.clear();
                            } else {
                              _selectedQuickQuery = q.query;
                              _searchQuery = q.query;
                              _searchController.text = q.query;
                              _selectedCategory = null;
                            }
                          });
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 4. Categories Header & Grid
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'asst_categories_title'.tr(context),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                    if (_selectedCategory != null)
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedCategory = null;
                          });
                        },
                        child: const Text(
                          'عرض الكل',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.95,
                  ),
                  itemCount: AssistantTopicsData.categories.length,
                  itemBuilder: (context, index) {
                    final cat = AssistantTopicsData.categories[index];
                    final isSelected = _selectedCategory == cat.type;
                    return AssistantCategoryCard(
                      category: cat,
                      isSelected: isSelected,
                      onTap: () {
                        setState(() {
                          if (isSelected) {
                            _selectedCategory = null;
                          } else {
                            _selectedCategory = cat.type;
                            _searchQuery = '';
                            _searchController.clear();
                            _selectedQuickQuery = null;
                          }
                        });
                      },
                    );
                  },
                ),

                const SizedBox(height: 20),
                const Divider(height: 1, thickness: 1),
                const SizedBox(height: 16),

                // 5. Results Count & List of Guides
                Row(
                  children: [
                    Icon(
                      Icons.library_books_rounded,
                      size: 18,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'أدلة الشرح (${filteredTopics.length})',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.darkTextPrimary
                            : AppColors.lightTextPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                if (filteredTopics.isEmpty)
                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.darkCard : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: AppColors.accent,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'asst_no_results'.tr(context),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            height: 1.4,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 14),
                        OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _searchController.clear();
                              _searchQuery = '';
                              _selectedCategory = null;
                              _selectedQuickQuery = null;
                            });
                          },
                          child: const Text('إعادة ضبط البحث'),
                        ),
                      ],
                    ),
                  )
                else
                  ...filteredTopics.map((topic) {
                    final isFirstMatch =
                        _searchQuery.isNotEmpty || _selectedCategory != null;
                    return AssistantGuideCard(
                      topic: topic,
                      initiallyExpanded: isFirstMatch,
                      onNavigate: _handleNavigate,
                    );
                  }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
