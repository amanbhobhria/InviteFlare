import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/transactions_event.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/transactions_state.dart';
import 'package:invite_flare/features/profile/presentation/blocs/transactions_bloc.dart';



class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => TransactionsBloc()..add(LoadTransactions()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Payment History",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: BlocBuilder<TransactionsBloc, TransactionsState>(
          builder: (context, state) {
            if (state is TransactionsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TransactionsLoaded) {
              final transactions = state.transactions;
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: transactions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final txn = transactions[index];
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildRow("Transaction ID", txn["transactionId"]!),
                          _buildRow("Recipient Name", txn["recipient"]!),
                          _buildRow("Date", txn["date"]!),
                          _buildRow("Plan", txn["plan"]!),
                          _buildRow("Status", txn["status"]!),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is TransactionsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );

  Widget _buildRow(String heading, String value) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              heading,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: const TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
}
