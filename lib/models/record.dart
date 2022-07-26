class Record {
  int userId;
  int fieldId;
  String type;
  String data;

  Record(this.userId, this.fieldId, this.type, this.data);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'fieldId': fieldId,
      'type': type,
      'data': data,
    };
  }

  static Record fromMap(Map<String, dynamic> map) {
    return Record(map['userId'], map['fieldId'], map['type'], map['data']);
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Record{userId: $userId, fieldId: $fieldId, type: $type, data: $data}';
  }
}
