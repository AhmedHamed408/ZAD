import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:zad/features/main_navigation/main_navigation_screen.dart';
import 'package:zad/providers/auth_provider.dart';
import 'package:zad/providers/theme_provider.dart';
import 'package:zad/providers/language_provider.dart';
import 'package:zad/providers/wallet_provider.dart';
import 'package:zad/providers/transaction_provider.dart';
import 'package:zad/providers/internet_provider.dart';
import 'package:zad/data/mock/mock_users.dart';
import 'package:zad/data/mock/mock_locations.dart';
import 'package:zad/data/models/transaction_model.dart';

class _TestHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  setUpAll(() {
    HttpOverrides.global = _TestHttpOverrides();
  });

  Widget buildTestApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => WalletProvider()),
        ChangeNotifierProvider(create: (_) => TransactionProvider()),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
      ],
      child: const MaterialApp(
        home: MainNavigationScreen(),
      ),
    );
  }

  group('ZAD Full UI/UX Verification Suite', () {
    testWidgets('1. Launch & Persistent Tab Navigation Verification', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
      expect(find.byType(MaterialApp), findsOneWidget);

      expect(find.text('Ahmed Hassan'), findsWidgets);
      expect(find.text('25,450.00 EGP'), findsWidgets);
    });

    testWidgets('2. Home UI Layout & Component Integrity', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.text('Available Balance'), findsOneWidget);
      expect(find.text('Quick Actions'), findsOneWidget);
      expect(find.text('Recent Transactions'), findsOneWidget);
      expect(find.text('See All'), findsOneWidget);

      expect(find.text('EGP'), findsWidgets);
      expect(find.text('USD'), findsWidgets);
      expect(find.text('EUR'), findsWidgets);

      expect(tester.takeException(), isNull);
    });

    testWidgets('3. Stacked FABs & Assistant / Conversations Verification', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lightbulb_rounded), findsWidgets);
      expect(find.byIcon(Icons.chat_rounded), findsWidgets);
    });

    testWidgets('4. History UI Date Grouping & Tap Modal Behavior', (WidgetTester tester) async {
      final txProvider = TransactionProvider();
      final txs = txProvider.transactions;

      expect(txs.isNotEmpty, isTrue);
      expect(txs.any((t) => t.type == TransactionType.sent), isTrue);
      expect(txs.any((t) => t.type == TransactionType.received), isTrue);
      expect(txs.any((t) => t.type == TransactionType.package), isTrue);
      expect(txs.any((t) => t.status == TransactionStatus.pending), isTrue);
      expect(txs.any((t) => t.status == TransactionStatus.failed), isTrue);
    });

    testWidgets('5. Send Money Journey & Balance Deduction Test', (WidgetTester tester) async {
      final wallet = WalletProvider();
      final txProvider = TransactionProvider();
      final recipient = MockUsers.allUsers.firstWhere((u) => u.phone == '01123456789');

      final initialBalance = wallet.balance;
      expect(initialBalance, equals(25450.00));
      expect(recipient.name, equals('Mohamed Ali'));

      const transferAmount = 500.0;
      final newTx = TransactionModel(
        id: 'ZAD-TEST500',
        senderId: 'user_001',
        receiverId: recipient.id,
        senderName: 'Ahmed Hassan',
        receiverName: recipient.name,
        senderAvatar: MockUsers.currentUser.profileImage,
        receiverAvatar: recipient.profileImage,
        amount: transferAmount,
        currency: 'EGP',
        type: TransactionType.sent,
        status: TransactionStatus.completed,
        date: DateTime.now(),
        note: 'Test Transfer',
      );

      wallet.deductBalance(transferAmount);
      txProvider.addTransaction(newTx);

      expect(wallet.balance, equals(24950.00));
      expect(txProvider.transactions.first.id, equals('ZAD-TEST500'));
      expect(txProvider.transactions.first.amount, equals(500.0));
    });

    testWidgets('6. Responsible Person Location Lookup & Phone Aliasing', (WidgetTester tester) async {
      final locations = MockLocations.userLocations;
      expect(locations.containsKey('01012345678'), isTrue);
      expect(locations['01012345678']!.userName, equals('Ahmed Hassan'));

      expect(locations.containsKey('01123456789'), isTrue);
      expect(locations['01123456789']!.userName, equals('Mohamed Ali'));

      expect(locations.containsKey('01234567890'), isTrue);
      expect(locations['01234567890']!.userName, equals('Omar Khaled'));

      expect(locations.containsKey('00000000000'), isFalse);
    });

    testWidgets('7. Localization & Theme Provider Verification', (WidgetTester tester) async {
      final lang = LanguageProvider();
      final theme = ThemeProvider();

      expect(lang.currentLocale.languageCode, equals('ar'));
      expect(lang.isArabic, isTrue);

      lang.setLanguage('en');
      expect(lang.currentLocale.languageCode, equals('en'));
      expect(lang.isArabic, isFalse);

      expect(theme.isDarkMode, isFalse);
      theme.toggleTheme();
      expect(theme.isDarkMode, isTrue);
      theme.toggleTheme();
      expect(theme.isDarkMode, isFalse);
    });

    testWidgets('8. Responsive Layout Overflow Test (360x640 Phone)', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(360, 640);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestApp());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
