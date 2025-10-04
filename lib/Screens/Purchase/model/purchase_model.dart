class PurchaseModel {
  String? invoiceNumber;
  String? status;
  String? sellers;
  String? amount;
  String? createdBy;
  String? approvedBy;
  String? createdAt;
  String? approvedAt;

  PurchaseModel({
    required this.invoiceNumber,
    required this.status,
    required this.sellers,
    required this.amount,
    required this.createdBy,
    required this.approvedBy,
    required this.createdAt,
    required this.approvedAt,
  });
}
