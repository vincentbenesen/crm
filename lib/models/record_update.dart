class RecordUpdate {
  late int userId;
  late String type;
  late String oldData;
  late String newData;
  late String createDate;

  RecordUpdate(
      this.userId, this.type, this.oldData, this.newData, this.createDate);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'type': type,
      'oldData': oldData,
      'newData': newData,
      'createDate': createDate,
    };
  }

  static RecordUpdate fromMap(Map<String, dynamic> map) {
    return RecordUpdate(map['userId'], map['type'], map['oldData'],
        map['newData'], map['date']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Record{userId: $userId, type: $type, oldData: $oldData, newData: $newData, createDate: $createDate}';
  }
}
