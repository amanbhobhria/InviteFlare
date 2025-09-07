import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/transactions_event.dart';
import 'package:invite_flare/features/profile/presentation/blocs/events/transactions_state.dart';

class TransactionsBloc extends Bloc<TransactionsEvent, TransactionsState> {
  TransactionsBloc() : super(TransactionsLoading()) {
    on<LoadTransactions>(_onLoadTransactions);
  }

  void _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionsState> emit) async {
    emit(TransactionsLoading());

    await Future.delayed(const Duration(seconds: 1)); // simulate API delay

    // ✅ Demo data
    final transactions = [
      {
        "transactionId": "TXN123456",
        "recipient": "John Doe",
        "date": "2025-09-03",
        "plan": "Premium",
        "status": "Success",
      },
      {
        "transactionId": "TXN987654",
        "recipient": "Jane Smith",
        "date": "2025-08-30",
        "plan": "Basic",
        "status": "Pending",
      },
      {
        "transactionId": "TXN654321",
        "recipient": "Alex Johnson",
        "date": "2025-08-15",
        "plan": "Standard",
        "status": "Failed",
      },
    ];

    emit(TransactionsLoaded(transactions: transactions));
  }
}
