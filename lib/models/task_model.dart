class Task {
  int id;
  String title;
  DateTime date;
  String prioirty;
  int status;

  Task(this.title, this.date, this.prioirty, this.status);

  Task.withId({this.id, this.title, this.date, this.prioirty, this.status});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    if (id != null) map['id'] = id;
    map['title'] = title;
    map['date'] = date.toIso8601String();
    map['prioirty'] = prioirty;
    map['status'] = status;
    return map;
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task.withId(
      id: map['id'],
      title: map['title'],
      date: DateTime.parse(map['date']),
      prioirty: map['prioirty'],
      status: map['status'],
    );
  }
}
