class RecordUpdate {
  late int userId;
  late int fieldId;
  late String type;
  late String oldData;
  late String newData;
  late DateTime date;

  RecordUpdate(this.userId, this.fieldId, this.type, this.oldData, this.newData,
      this.date);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fieldId': fieldId,
      'type': type,
      'oldData': oldData,
      'newData': newData,
      'date': date,
    };
  }

  static RecordUpdate fromMap(Map<String, dynamic> map) {
    return RecordUpdate(map['userId'], map['fieldId'], map['type'],
        map['oldData'], map['newData'], map['date']);
  }
}
