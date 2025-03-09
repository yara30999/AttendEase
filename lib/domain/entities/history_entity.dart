class HistoryEntity {
  final String id;
  final String userId;
  final String groupId;
  final DateTime? checkIn;
  final DateTime? checkOut;

  HistoryEntity({
    required this.id,
    required this.userId,
    required this.groupId,
    this.checkIn,
    this.checkOut,
  });
}
