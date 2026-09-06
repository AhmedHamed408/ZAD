import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/transaction_provider.dart';
import '../../localization/app_localizations.dart';
import '../../core/constants/app_colors.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/models/transaction_model.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Widget _buildGroupSection(
    BuildContext context, {
    required String title,
    required List<TransactionModel> transactions,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final filtered = transactions.where((t) {
      if (_searchQuery.isEmpty) return true;
      return t.senderName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          t.receiverName.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (t.note?.toLowerCase().contains(_searchQuery.toLowerCase()) ?? false);
    }).toList();

    if (filtered.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 10),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              letterSpacing: 1,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.only(bottom: 16),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: filtered.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final tx = filtered[index];
              final bool isReceived = tx.type == TransactionType.received;
              final bool isPackage = tx.type == TransactionType.package;
              final personName = isPackage
                  ? tx.receiverName
                  : (isReceived ? tx.senderName : tx.receiverName);
              final personAvatar = isPackage
                  ? tx.receiverAvatar
                  : (isReceived ? tx.senderAvatar : tx.receiverAvatar);

              final typeText = isPackage
                  ? 'Package'
                  : (isReceived ? 'received'.tr(context) : 'sent'.tr(context));

              return ListTile(
                onTap: () {
                  if (isPackage) {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                      ),
                      builder: (modalContext) {
                        return Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade400,
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundImage: NetworkImage(personAvatar),
                                  ),
                                  const SizedBox(width: 12),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        personName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const Text(
                                        'ZAD Mobile Data Purchase',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Divider(),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Package Plan:'),
                                  Text(
                                    tx.note ?? 'Internet Package',
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Amount Paid:'),
                                  Text(
                                    '-${CurrencyFormatter.format(tx.amount, currency: tx.currency)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.error,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Transaction ID:'),
                                  Text(
                                    tx.id,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Date & Time:'),
                                  Text(
                                    CurrencyFormatter.formatDate(tx.date),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 24),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => Navigator.pop(modalContext),
                                  child: const Text('Close'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  } else {
                    final otherId = isReceived ? tx.senderId : tx.receiverId;
                    Navigator.pushNamed(
                      context,
                      '/chat',
                      arguments: {
                        'userId': otherId,
                        'userName': personName,
                        'userAvatar': personAvatar,
                      },
                    );
                  }
                },
                leading: CircleAvatar(
                  radius: 22,
                  backgroundImage: NetworkImage(personAvatar),
                ),
                title: Text(
                  personName,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
                subtitle: Text(
                  '$typeText${tx.note != null ? ' • ${tx.note}' : ''}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${isReceived ? '+' : '-'}${CurrencyFormatter.format(tx.amount, currency: tx.currency)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: isReceived ? AppColors.success : AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (tx.status != TransactionStatus.completed) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                            decoration: BoxDecoration(
                              color: (tx.status == TransactionStatus.pending
                                      ? AppColors.warning
                                      : AppColors.error)
                                  .withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              tx.status == TransactionStatus.pending ? 'Pending' : 'Failed',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: tx.status == TransactionStatus.pending
                                    ? AppColors.warning
                                    : AppColors.error,
                              ),
                            ),
                          ),
                          const SizedBox(width: 4),
                        ],
                        Text(
                          CurrencyFormatter.formatShortDate(tx.date),
                          style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppColors.darkTextSecondary
                                : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final txProvider = Provider.of<TransactionProvider>(context);

    final todayTx = txProvider.getTodayTransactions();
    final yesterdayTx = txProvider.getYesterdayTransactions();
    final earlierTx = txProvider.getEarlierTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Text('transaction_history'.tr(context)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
          child: Column(
            children: [
              // Search Input
              TextField(
                controller: _searchController,
                onChanged: (val) => setState(() => _searchQuery = val),
                decoration: InputDecoration(
                  hintText: 'search_transactions'.tr(context),
                  prefixIcon: const Icon(Icons.search_rounded),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear_rounded),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 16),

              _buildGroupSection(
                context,
                title: 'today'.tr(context),
                transactions: todayTx,
              ),

              _buildGroupSection(
                context,
                title: 'yesterday'.tr(context),
                transactions: yesterdayTx,
              ),

              _buildGroupSection(
                context,
                title: 'earlier'.tr(context),
                transactions: earlierTx,
              ),

              if (todayTx.isEmpty && yesterdayTx.isEmpty && earlierTx.isEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: Center(
                    child: Text(
                      'no_transactions'.tr(context),
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
