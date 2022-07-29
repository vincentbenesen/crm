import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  late int userId;
  late int fieldId;
  late String type;
  late String data;

  Record(this.userId, this.fieldId, this.type, this.data);
  Record.empty();
  Record.fromFocumentSnapshot(DocumentSnapshot snapshot) {
    userId = snapshot['userId'];
    fieldId = snapshot['fieldId'];
    type = snapshot['type'];
    data = snapshot['data'];
  }

  Map<String, dynamic> toMap(int highestUserId) {
    return {
      'userId': highestUserId,
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
