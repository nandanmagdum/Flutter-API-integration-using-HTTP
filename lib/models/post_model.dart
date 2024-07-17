class Post {
  final String title;
  final String body;
  final int userId;
  final int id;

  Post({required this.title, required this.body, required this.userId, required this.id});

  factory Post.fromJson(Map<String, dynamic> json) => Post(
      title: json['title'] as String,
      body: json['body'] as String,
      userId: json['userId'] as int,
      id: json['id'] as int
      );
}
