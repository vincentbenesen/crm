class Log {
  late int userId;
  late DateTime date;
  late String typeOfData;
  late String data;
  late String docId;

  Log(this.userId, this.date, this.typeOfData, this.data, [this.docId = '']);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'typeOfData': typeOfData,
      'data': data,
      'docId': docId,
    };
  }

  static Log fromMap(Map<String, dynamic> map) {
    return Log(map['userId'], map['date'], map['typeOfData'], map['data']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Record{userId: $userId, date: $date, type: $typeOfData, data: $data, documentId: $docId}';
  }
}
