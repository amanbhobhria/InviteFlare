abstract class TransactionsState {}

class TransactionsLoading extends TransactionsState {}

class TransactionsLoaded extends TransactionsState {
  final List<Map<String, String>> transactions;
  TransactionsLoaded({required this.transactions});
}

class TransactionsError extends TransactionsState {
  final String message;
  TransactionsError(this.message);
}
