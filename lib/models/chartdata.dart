class ChartData {
  late String title;
  late int value;

  ChartData(this.title, this.value);

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'value': value,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'ChartData{title: $title, value: $value}';
  }
}
