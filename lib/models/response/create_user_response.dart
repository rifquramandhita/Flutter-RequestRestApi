class CreateUserResponse {
  final String name;
  final String job;
  final String id;
  final String createdAt;

  CreateUserResponse(
      {required this.name,
      required this.job,
      required this.id,
      required this.createdAt});

  factory CreateUserResponse.fromJson(Map<String, dynamic> json) {
    return CreateUserResponse(
        name: json['name'],
        job: json['job'],
        id: json['id'],
        createdAt: json['createdAt']);
  }
}
