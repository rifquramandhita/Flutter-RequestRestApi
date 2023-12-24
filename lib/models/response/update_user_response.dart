class UpdateUserResponse {
  final String updatedAt;

  UpdateUserResponse({required this.updatedAt});

  factory UpdateUserResponse.fromJson(Map<String, dynamic> json) {
    return UpdateUserResponse(updatedAt: json['updatedAt']);
  }
}
