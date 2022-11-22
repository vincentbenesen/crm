class ProgressData {
  late int userId;
  late String title;
  late String estimateDate;
  late String finishDate;
  late String documentId;

  ProgressData(this.userId, this.title, this.estimateDate, this.finishDate,
      [this.documentId = '']);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'estimateDate': estimateDate,
      'finishDate': finishDate,
      'documentId': documentId
    };
  }

  static ProgressData fromMap(Map<String, dynamic> map) {
    return ProgressData(map['userId'], map['title'], map['estimateDate'],
        map['finishDate'], map['documentId']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'ProgressData{userId: $userId, title: $title, estimateDate: $estimateDate, finishDate: $finishDate, documentId: $documentId}';
  }
}
