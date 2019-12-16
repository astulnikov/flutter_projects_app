class Post {
  final String id;
  final String status;
  final String updatedAt;

  Post({this.id, this.status, this.updatedAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] as String,
      status: json['status'] as String,
      updatedAt: json['updatedAt'] as String,
    );
  }
}
