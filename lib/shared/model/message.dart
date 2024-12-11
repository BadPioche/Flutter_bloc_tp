class Message {
  final int id;
  final String title;
  final String description;

  const Message({
    required this.id,
    required this.title,
    required this.description,
  });

  copyWith({required String title, required String description}) {
    return Message(id: id,title: title,description: description);
  }
}
