class Log {
  late int userId;
  late DateTime date;
  late String typeOfAction;
  late String data;

  Log(this.userId, this.date, this.typeOfAction, this.data);

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'date': date,
      'typeOfAction': typeOfAction,
      'data': data,
    };
  }
}
