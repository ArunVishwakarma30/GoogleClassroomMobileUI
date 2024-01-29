class Assignment {
  int id;
  String title;
  String description;
  dynamic attachment;
  int points;
  DateTime dueDate;
  String topic;

  Assignment(this.id, this.title, this.description, this.attachment,
      this.points, this.dueDate, this.topic);
}
