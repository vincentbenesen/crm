class ProgressData {
  late int userId;
  late String title;
  late String estimateDate;
  late String finishDate;
  late String documentId;

  ProgressData(this.userId, this.title, this.estimateDate, this.finishDate,
      [documentId = '']);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'title': title,
      'estimateDate': estimateDate,
      'finishDate': finishDate
    };
  }

  static ProgressData fromMap(Map<String, dynamic> map) {
    return ProgressData(
        map['userId'], map['title'], map['estimateDate'], map['finishDate']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'ProgressData{userId: $userId, title: $title, estimateDate: $estimateDate, finishDate: $finishDate}';
  }
}
