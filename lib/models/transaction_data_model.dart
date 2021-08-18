class TransactionDataModel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  TransactionDataModel(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}
