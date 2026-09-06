import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/user_model.dart';
import '../../providers/wallet_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/widgets/custom_text_field.dart';

class SendMoneyScreen extends StatefulWidget {
  const SendMoneyScreen({super.key});

  @override
  State<SendMoneyScreen> createState() => _SendMoneyScreenState();
}

class _SendMoneyScreenState extends State<SendMoneyScreen> {
  UserModel? _selectedRecipient;
  final TextEditingController _amountController = TextEditingController(text: '1500');
  final TextEditingController _noteController = TextEditingController(text: 'Dinner');
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _selectedRecipient = MockData.mockUsers.first; // Default to Mohamed Ali
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _handleContinue() {
    if (_selectedRecipient == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User not found. Please select a valid ZAD registered recipient.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final double amount = double.tryParse(_amountController.text.trim()) ?? 0.0;
    if (amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid amount greater than zero.'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    final walletProvider = Provider.of<WalletProvider>(context, listen: false);

    // Insufficient balance check
    if (amount > walletProvider.convertedBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Insufficient Balance. Available balance: ${walletProvider.convertedBalance.toStringAsFixed(2)} ${walletProvider.selectedCurrency.symbol}',
          ),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      '/send-review',
      arguments: {
        'recipient': _selectedRecipient,
        'amount': amount,
        'currency': walletProvider.selectedCurrencyCode,
        'note': _noteController.text.trim(),
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final walletProvider = Provider.of<WalletProvider>(context);

    // Filter contacts based on search query
    final filteredUsers = MockData.mockUsers.where((u) {
      if (_searchQuery.isEmpty) return true;
      final q = _searchQuery.toLowerCase().trim();
      final nameMatch = u.name.toLowerCase().contains(q);
      final phoneMatch = u.phone.contains(q);
      final aliasMatch = (u.id == 'user_002' && (q == '01023456789' || q == '01123456789'));
      return nameMatch || phoneMatch || aliasMatch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('send_money'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'select_recipient'.tr(context),
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 12),

              // Search Bar by Name or Phone
              TextField(
                controller: _searchController,
                onChanged: (query) {
                  setState(() {
                    _searchQuery = query;
                    if (filteredUsers.isNotEmpty) {
                      _selectedRecipient = filteredUsers.first;
                    } else {
                      _selectedRecipient = null;
                    }
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search by name or phone (e.g. 01012345678)',
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _searchQuery = '';
                              _selectedRecipient = MockData.mockUsers.first;
                            });
                          },
                        )
                      : null,
                ),
              ),

              const SizedBox(height: 16),

              // Horizontal Contacts Picker
              if (filteredUsers.isNotEmpty)
                SizedBox(
                  height: 95,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: filteredUsers.length,
                    itemBuilder: (context, index) {
                      final u = filteredUsers[index];
                      final isSelected = u.id == _selectedRecipient?.id;

                      return GestureDetector(
                        onTap: () {
                          setState(() => _selectedRecipient = u);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 14),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent.withValues(alpha: 0.16)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSelected ? AppColors.accent : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundImage: NetworkImage(u.profileImage),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                u.name.split(' ').first,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  color: isSelected
                                      ? AppColors.accent
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

              const SizedBox(height: 16),

              // Selected Recipient Card or "User Not Found" Card
              if (_selectedRecipient != null)
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(_selectedRecipient!.profileImage),
                    ),
                    title: Text(
                      _selectedRecipient!.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(_selectedRecipient!.phone),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.check_circle_rounded, color: AppColors.success, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'ZAD User',
                            style: TextStyle(
                              color: AppColors.success,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              else
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

              const SizedBox(height: 24),

              // Amount & Currency Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      labelText: 'amount'.tr(context),
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      prefixIcon: const Icon(Icons.attach_money_rounded),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Currency',
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: isDark ? AppColors.darkSurface : Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                            ),
                          ),
                          child: DropdownButton<String>(
                            value: walletProvider.selectedCurrencyCode,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            onChanged: (code) {
                              if (code != null) walletProvider.selectCurrency(code);
                            },
                            items: walletProvider.currencies
                                .map((c) => DropdownMenuItem(
                                      value: c.code,
                                      child: Text('${c.flag} ${c.code}'),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Optional Note Input
              CustomTextField(
                labelText: 'note'.tr(context),
                hintText: 'e.g. Dinner split, Rent, Coffee',
                controller: _noteController,
                prefixIcon: const Icon(Icons.note_add_outlined),
              ),

              const SizedBox(height: 36),

              CustomButton(
                text: 'continue_btn'.tr(context),
                onPressed: _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
