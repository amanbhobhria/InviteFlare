import 'package:get/get.dart';

class TransactionsController extends GetxController {
  var isLoading = true.obs;
  var error = ''.obs;
  var transactions = <Map<String, String>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadTransactions();
  }

  void loadTransactions() async {
    try {
      isLoading.value = true;
      error.value = '';

      await Future.delayed(const Duration(seconds: 1)); // Simulate API call

      transactions.value = [
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
    } catch (e) {
      error.value = 'Failed to load transactions';
    } finally {
      isLoading.value = false;
    }
  }
}
