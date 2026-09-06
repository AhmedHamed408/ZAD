import 'package:flutter/material.dart';
import '../models/assistant_topic_model.dart';
import '../../../core/constants/app_colors.dart';

class AssistantTopicsData {
  static const List<AssistantCategoryModel> categories = [
    AssistantCategoryModel(
      type: AssistantCategoryType.account,
      titleKey: 'asst_cat_account',
      icon: Icons.person_outline_rounded,
      color: Colors.indigo,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.money,
      titleKey: 'asst_cat_money',
      icon: Icons.account_balance_wallet_outlined,
      color: AppColors.accent,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.internet,
      titleKey: 'asst_cat_internet',
      icon: Icons.wifi_rounded,
      color: Colors.orange,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.qr,
      titleKey: 'asst_cat_qr',
      icon: Icons.qr_code_scanner_rounded,
      color: Colors.purple,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.history,
      titleKey: 'asst_cat_history',
      icon: Icons.receipt_long_rounded,
      color: Colors.blue,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.chat,
      titleKey: 'asst_cat_chat',
      icon: Icons.chat_rounded,
      color: Colors.teal,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.settings,
      titleKey: 'asst_cat_settings',
      icon: Icons.settings_outlined,
      color: Colors.blueGrey,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.theme,
      titleKey: 'asst_cat_theme',
      icon: Icons.palette_outlined,
      color: Colors.deepPurple,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.language,
      titleKey: 'asst_cat_language',
      icon: Icons.language_rounded,
      color: Colors.amber,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.responsible,
      titleKey: 'asst_cat_responsible',
      icon: Icons.location_on_outlined,
      color: Colors.redAccent,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.security,
      titleKey: 'asst_cat_security',
      icon: Icons.security_rounded,
      color: Colors.teal,
    ),
    AssistantCategoryModel(
      type: AssistantCategoryType.demo,
      titleKey: 'asst_cat_demo',
      icon: Icons.info_outline_rounded,
      color: Colors.amber,
    ),
  ];

  static const List<AssistantTopicModel> topics = [
    // 1. Home Guide
    AssistantTopicModel(
      id: 'home_guide',
      titleKey: 't_home_title',
      subtitleKey: 't_home_sub',
      icon: Icons.home_rounded,
      themeColor: AppColors.primary,
      category: AssistantCategoryType.account,
      keywords: ['home', 'balance', 'currency', 'main', 'الرئيسية', 'رصيد', 'عملة'],
      routeToNavigate: '/home',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Available Balance & Visibility',
          description: 'View your real-time total wallet balance. Tap the eye icon (👁) to toggle balance visibility (••••••••) anytime.',
          icon: Icons.visibility_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Multi-Currency Switcher',
          description: 'Tap currency chips (EGP 🇪🇬, SAR 🇸🇦, AED 🇦🇪, KWD 🇰🇼, QAR 🇶🇦...) to instantly convert your balance display across 22 Arab countries.',
          icon: Icons.currency_exchange_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Send & Receive Actions',
          description: 'Access the primary green Send button or white Receive button for one-tap money transfer workflows.',
          icon: Icons.swap_horiz_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Quick Actions Carousel',
          description: 'Quick access to QR Pay, Internet Marketplace, History, and Responsible Location Lookup.',
          icon: Icons.grid_view_rounded,
        ),
        AssistantStepModel(
          stepNumber: 5,
          title: 'Recent Transactions & See All',
          description: 'Review your latest 5 transactions with green (+) income and red (-) expense indicators, or tap See All.',
          icon: Icons.history_rounded,
        ),
      ],
    ),

    // 2. Send Money Guide
    AssistantTopicModel(
      id: 'send_guide',
      titleKey: 't_send_title',
      subtitleKey: 't_send_sub',
      icon: Icons.arrow_upward_rounded,
      themeColor: AppColors.accent,
      category: AssistantCategoryType.money,
      keywords: ['send', 'transfer', 'money', 'إرسال', 'ابعت', 'تحويل', 'فلوس'],
      routeToNavigate: '/send',
      actionButtonTextKey: 'btn_start_send',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Step 1: Select Recipient',
          description: 'Search by registered name or phone number (e.g. 01012345678), or pick from the ZAD contact avatar list.',
          icon: Icons.person_search_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Step 2: Enter Amount & Currency',
          description: 'Specify the amount to send and select your preferred currency. Your available balance is checked automatically.',
          icon: Icons.attach_money_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Step 3: Add Note (Optional)',
          description: 'Attach a brief message or memo for the transfer (e.g., "Dinner split", "Rent payment").',
          icon: Icons.note_add_outlined,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Step 4: Review Transfer',
          description: 'Check recipient information, transfer amount, and confirm the 0 EGP (FREE) transfer fee.',
          icon: Icons.fact_check_rounded,
        ),
        AssistantStepModel(
          stepNumber: 5,
          title: 'Step 5: Confirm & Success',
          description: 'Tap Confirm Transfer to execute instant deduction. View the success checkmark and copy the Transaction ID.',
          icon: Icons.check_circle_rounded,
        ),
      ],
    ),

    // 3. Receive Money Guide
    AssistantTopicModel(
      id: 'receive_guide',
      titleKey: 't_receive_title',
      subtitleKey: 't_receive_sub',
      icon: Icons.arrow_downward_rounded,
      themeColor: AppColors.accent,
      category: AssistantCategoryType.money,
      keywords: ['receive', 'request', 'qr', 'استقبال', 'استلم', 'طلب', 'فلوس'],
      routeToNavigate: '/receive',
      actionButtonTextKey: 'btn_start_receive',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Display Personal QR Code',
          description: 'Your unique ZAD payment QR code and registered phone number are displayed on screen.',
          icon: Icons.qr_code_2_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Specify Requested Amount',
          description: 'Input a specific requested amount and currency to generate an exact payment QR request.',
          icon: Icons.request_quote_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Share or Scan',
          description: 'Let the sender scan your screen directly or tap Request Money to copy the payment request link.',
          icon: Icons.share_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Instant Balance Credit',
          description: 'Received payments update your available wallet balance in real time and append to History.',
          icon: Icons.account_balance_wallet_rounded,
        ),
      ],
    ),

    // 4. QR Code Guide
    AssistantTopicModel(
      id: 'qr_guide',
      titleKey: 't_qr_title',
      subtitleKey: 't_qr_sub',
      icon: Icons.qr_code_scanner_rounded,
      themeColor: Colors.purple,
      category: AssistantCategoryType.qr,
      keywords: ['qr', 'scan', 'generate', 'باركود', 'كود', 'مسح', 'إنشاء'],
      routeToNavigate: '/qr',
      actionButtonTextKey: 'btn_try_qr',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Scan QR Mode',
          description: 'Align any merchant or contact QR code inside the viewfinder box for simulated instant scan.',
          icon: Icons.center_focus_strong_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Demo Scan Action',
          description: 'Tap Demo Scan to simulate scanning a payment request and automatically navigate to Send Review.',
          icon: Icons.play_arrow_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Generate QR Mode',
          description: 'Switch tabs to generate your personal payment QR code with an optional requested amount.',
          icon: Icons.qr_code_2_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Demo Environment Notice',
          description: 'Note: QR scanner and generation features operate in simulated Demo Mode inside this prototype.',
          icon: Icons.info_outline_rounded,
        ),
      ],
    ),

    // 5. Internet Packages Guide
    AssistantTopicModel(
      id: 'internet_guide',
      titleKey: 't_internet_title',
      subtitleKey: 't_internet_sub',
      icon: Icons.wifi_rounded,
      themeColor: Colors.orange,
      category: AssistantCategoryType.internet,
      keywords: ['internet', 'package', 'data', 'esim', 'انترنت', 'باقة', 'نت', 'شحن'],
      routeToNavigate: '/internet',
      actionButtonTextKey: 'btn_browse_packages',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Select Destination Country',
          description: 'Choose from Arab region countries (Egypt 🇪🇬, Saudi Arabia 🇸🇦, UAE 🇦🇪, Kuwait 🇰🇼, etc.).',
          icon: Icons.flag_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Compare Plan Specs',
          description: 'Review Data allowance (GB), Voice minutes, Validity days, and price in local currency.',
          icon: Icons.tune_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Package Details & Features',
          description: 'Tap any package to inspect full features, terms, and purchase confirmation.',
          icon: Icons.article_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Instant Activation & History',
          description: 'Upon confirmation, package price is deducted from balance, plan is marked Active, and receipt is added to History.',
          icon: Icons.check_circle_outline_rounded,
        ),
      ],
    ),

    // 6. History & Receipts Guide
    AssistantTopicModel(
      id: 'history_guide',
      titleKey: 't_history_title',
      subtitleKey: 't_history_sub',
      icon: Icons.receipt_long_rounded,
      themeColor: Colors.blue,
      category: AssistantCategoryType.history,
      keywords: ['history', 'transactions', 'receipt', 'سجل', 'معاملات', 'تاريخ', 'إيصال'],
      routeToNavigate: '/history',
      actionButtonTextKey: 'btn_open_history',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Date Grouping Sections',
          description: 'Transactions are automatically grouped under Today, Yesterday, and Earlier for easy tracking.',
          icon: Icons.calendar_month_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Visual Category Indicators',
          description: 'Green (+) for received money, Red (-) for sent money, and Blue Wifi icon for internet packages.',
          icon: Icons.label_important_outline_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Search & Filter',
          description: 'Filter transaction list by contact name, note, or Transaction ID.',
          icon: Icons.search_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Receipt Details & Chat Link',
          description: 'Tap any transaction row to open the full digital receipt sheet or jump straight into direct contact chat.',
          icon: Icons.receipt_rounded,
        ),
      ],
    ),

    // 7. Conversations Guide (💬 FAB)
    AssistantTopicModel(
      id: 'conversations_guide',
      titleKey: 't_conv_title',
      subtitleKey: 't_conv_sub',
      icon: Icons.chat_rounded,
      themeColor: AppColors.accent,
      category: AssistantCategoryType.chat,
      keywords: ['conversations', 'contacts', 'fab', 'chat', 'محادثات', 'شات', 'جهات اتصال'],
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Lower FAB (💬 Conversations)',
          description: 'Tap the green floating action button on the bottom right of any screen to open Conversations.',
          icon: Icons.touch_app_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Contact Directory Overview',
          description: 'View all ZAD contacts with profile pictures, online status dots, and last message timestamps.',
          icon: Icons.contacts_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Payment Status Badges',
          description: 'Recent payment transactions inside conversations are tagged with transaction icons and amounts.',
          icon: Icons.mark_as_unread_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Open Chat',
          description: 'Tap any contact row to open the full Chat screen with direct messaging.',
          icon: Icons.chat_bubble_outline_rounded,
        ),
      ],
    ),

    // 8. Chat & Payments Guide
    AssistantTopicModel(
      id: 'chat_guide',
      titleKey: 't_chat_title',
      subtitleKey: 't_chat_sub',
      icon: Icons.forum_rounded,
      themeColor: Colors.teal,
      category: AssistantCategoryType.chat,
      keywords: ['chat', 'messaging', 'messages', 'شات', 'محادثة', 'رسائل'],
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Direct Messaging',
          description: 'Send and receive real-time text messages with ZAD contacts.',
          icon: Icons.send_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Embedded Payment Cards',
          description: 'Money transfers sent to contacts appear as stylized payment payload cards displaying amount and status.',
          icon: Icons.payments_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Demo Calls Notice',
          description: 'Voice and Video calling buttons show a Demo dialog ("Calling features will be available in a future update").',
          icon: Icons.phone_disabled_rounded,
        ),
      ],
    ),

    // 9. Settings Guide
    AssistantTopicModel(
      id: 'settings_guide',
      titleKey: 't_settings_title',
      subtitleKey: 't_settings_sub',
      icon: Icons.settings_rounded,
      themeColor: Colors.blueGrey,
      category: AssistantCategoryType.settings,
      keywords: ['settings', 'preferences', 'profile', 'إعدادات', 'حساب', 'تطبيقات'],
      routeToNavigate: '/settings',
      actionButtonTextKey: 'btn_open_settings',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'User Profile Summary',
          description: 'Tap the pencil edit button on your profile card to view full account details (National ID, Address, Email).',
          icon: Icons.badge_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Responsible Location Lookup',
          description: 'Access simulated GPS contact location lookup using phone numbers.',
          icon: Icons.location_on_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Language & Theme Switchers',
          description: 'Instantly select your preferred language (Arabic, English, French, Italian) and Theme mode (Light, Dark, System).',
          icon: Icons.tune_rounded,
        ),
        AssistantStepModel(
          stepNumber: 4,
          title: 'Logout & Security',
          description: 'Log out safely to end session or test authentication with different demo credentials.',
          icon: Icons.logout_rounded,
        ),
      ],
    ),

    // 10. Language Guide
    AssistantTopicModel(
      id: 'language_guide',
      titleKey: 't_lang_title',
      subtitleKey: 't_lang_sub',
      icon: Icons.language_rounded,
      themeColor: Colors.amber,
      category: AssistantCategoryType.language,
      keywords: ['language', 'arabic', 'english', 'french', 'italian', 'لغة', 'عربي', 'انجليزي', 'فرنسي', 'ايطالي'],
      routeToNavigate: '/settings',
      actionButtonTextKey: 'btn_open_settings',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: '4 Supported Languages',
          description: 'ZAD supports Arabic (🇪🇬 العربية), English (🇺🇸 English), French (🇫🇷 Français), and Italian (🇮🇹 Italiano).',
          icon: Icons.translate_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Native RTL Layout Support',
          description: 'Selecting Arabic instantly transforms the entire application UI to native Right-to-Left (RTL) orientation.',
          icon: Icons.format_textdirection_r_to_l_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Persistent Storage',
          description: 'Language selection is automatically saved in SharedPreferences and persists across app restarts.',
          icon: Icons.save_rounded,
        ),
      ],
    ),

    // 11. Theme Guide
    AssistantTopicModel(
      id: 'theme_guide',
      titleKey: 't_theme_title',
      subtitleKey: 't_theme_sub',
      icon: Icons.palette_outlined,
      themeColor: Colors.deepPurple,
      category: AssistantCategoryType.theme,
      keywords: ['theme', 'dark', 'light', 'mode', 'مظهر', 'داكن', 'فاتح', 'ثيم'],
      routeToNavigate: '/settings',
      actionButtonTextKey: 'btn_open_settings',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Light Mode',
          description: 'Clean off-white surfaces (Color 0xFFF8FAFC), crisp white cards, navy typography, and emerald accents.',
          icon: Icons.wb_sunny_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Dark Mode',
          description: 'Deep midnight navy background (Color 0xFF0A0E1A), slate cards (Color 0xFF1E293B), and emerald highlights.',
          icon: Icons.nightlight_round,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Local Theme Persistence',
          description: 'Your selected theme mode (Light, Dark, or System Default) is saved locally.',
          icon: Icons.phonelink_setup_rounded,
        ),
      ],
    ),

    // 12. Responsible Location Guide
    AssistantTopicModel(
      id: 'responsible_guide',
      titleKey: 't_resp_title',
      subtitleKey: 't_resp_sub',
      icon: Icons.location_on_outlined,
      themeColor: Colors.redAccent,
      category: AssistantCategoryType.responsible,
      keywords: ['responsible', 'location', 'gps', 'map', 'موقع', 'مسؤول', 'تتبع', 'خريطة'],
      routeToNavigate: '/responsible',
      actionButtonTextKey: 'btn_try_responsible',
      isDemoNotice: true,
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: '100% Mock / Demo Data Notice',
          description: 'IMPORTANT: Location data is completely mocked and simulated for demonstration purposes. No real GPS tracking occurs.',
          icon: Icons.warning_amber_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Phone Number Lookup',
          description: 'Enter a registered ZAD phone number (e.g. 01123456789) and tap Search Location.',
          icon: Icons.search_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Live Map & Coordinates Result',
          description: 'View mock city, district address, GPS coordinates, last updated timestamp, and interactive map graphic preview.',
          icon: Icons.map_rounded,
        ),
      ],
    ),

    // 13. Login Guide
    AssistantTopicModel(
      id: 'login_guide',
      titleKey: 't_login_title',
      subtitleKey: 't_login_sub',
      icon: Icons.lock_outline_rounded,
      themeColor: AppColors.primary,
      category: AssistantCategoryType.account,
      keywords: ['login', 'signin', 'password', 'دخول', 'تسجيل', 'كلمة سر'],
      routeToNavigate: '/login',
      actionButtonTextKey: 'btn_go_login',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Phone & Password Input',
          description: 'Sign in using your registered phone number (01012345678) and password (123456).',
          icon: Icons.phone_android_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Demo Hint Box',
          description: 'The login screen contains a pre-filled demo login credentials hint card for instant testing.',
          icon: Icons.lightbulb_outline_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Forgot Password & Signup',
          description: 'Access the 3-step password reset wizard or tap Sign Up to register a new account.',
          icon: Icons.password_rounded,
        ),
      ],
    ),

    // 14. Sign Up Guide
    AssistantTopicModel(
      id: 'signup_guide',
      titleKey: 't_signup_title',
      subtitleKey: 't_signup_sub',
      icon: Icons.person_add_outlined,
      themeColor: AppColors.accent,
      category: AssistantCategoryType.security,
      keywords: ['signup', 'register', 'kyc', 'تسجيل', 'حساب جديد', 'هوية'],
      routeToNavigate: '/signup',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Registration Form',
          description: 'Input your full name, phone number, email, national ID (14 digits), and date of birth.',
          icon: Icons.assignment_outlined,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'KYC Document Upload Demo',
          description: 'Upload ID Front, ID Back, and Selfie verification cards (Simulated upload status).',
          icon: Icons.badge_outlined,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Route to OTP Verification',
          description: 'Tap Submit Registration to proceed to 6-digit OTP security verification.',
          icon: Icons.arrow_forward_rounded,
        ),
      ],
    ),

    // 15. OTP Guide
    AssistantTopicModel(
      id: 'otp_guide',
      titleKey: 't_otp_title',
      subtitleKey: 't_otp_sub',
      icon: Icons.mark_email_read_outlined,
      themeColor: Colors.amber,
      category: AssistantCategoryType.security,
      keywords: ['otp', 'verification', 'code', 'رمز', 'تحقق', 'كود'],
      routeToNavigate: '/otp',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: '6-Digit Auto-Focus Fields',
          description: 'Input the 6-digit verification code with automatic focus movement between input boxes.',
          icon: Icons.pin_outlined,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Countdown Timer',
          description: '60-second expiration timer with instant Resend OTP action upon expiration.',
          icon: Icons.timer_outlined,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'Demo Code (123456)',
          description: 'Use the prefilled demo code 123456 for instant verification.',
          icon: Icons.key_rounded,
        ),
      ],
    ),

    // 16. Transaction Details Guide
    AssistantTopicModel(
      id: 'txdetail_guide',
      titleKey: 't_txdetail_title',
      subtitleKey: 't_txdetail_sub',
      icon: Icons.receipt_rounded,
      themeColor: Colors.blue,
      category: AssistantCategoryType.history,
      keywords: ['receipt', 'detail', 'status', 'id', 'تفاصيل', 'حالة', 'معاملة'],
      routeToNavigate: '/history',
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'Digital Receipt Breakdown',
          description: 'Inspect Transaction ID, Sender, Receiver, Amount, Currency, Note, and Timestamp.',
          icon: Icons.receipt_long_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Transaction Status Badges',
          description: 'Completed (✓ Success), Pending (⏳ In Progress), Failed (❌ Declined).',
          icon: Icons.verified_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'One-Tap Copy ID',
          description: 'Tap the copy icon next to the Transaction ID to copy it to your device clipboard.',
          icon: Icons.copy_rounded,
        ),
      ],
    ),

    // 17. Demo Mode Guide
    AssistantTopicModel(
      id: 'demo_guide',
      titleKey: 't_demo_title',
      subtitleKey: 't_demo_sub',
      icon: Icons.info_outline_rounded,
      themeColor: Colors.amber,
      category: AssistantCategoryType.demo,
      keywords: ['demo', 'prototype', 'mock', 'ديمو', 'تجريبي', 'عن التطبيق'],
      isDemoNotice: true,
      steps: [
        AssistantStepModel(
          stepNumber: 1,
          title: 'ZAD Fintech Prototype Overview',
          description: 'ZAD (زاد) is a high-fidelity digital wallet prototype designed to showcase production-grade fintech UI/UX.',
          icon: Icons.laptop_mac_rounded,
        ),
        AssistantStepModel(
          stepNumber: 2,
          title: 'Simulated Environment',
          description: 'All balances, transfers, QR codes, package purchases, KYC uploads, and GPS locations are mock data running locally inside the app.',
          icon: Icons.developer_mode_rounded,
        ),
        AssistantStepModel(
          stepNumber: 3,
          title: 'No Real Banking Risk',
          description: 'No real financial transactions, payment gateways, or backend APIs are connected. Explore all features safely!',
          icon: Icons.security_rounded,
        ),
      ],
    ),
  ];
}
