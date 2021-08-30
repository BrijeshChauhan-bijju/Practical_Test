class ApiError {
  String? message;
  String? documentationUrl;
  int? status;

  ApiError({
      this.message,
    this.status,
      this.documentationUrl});

  ApiError.fromJson(dynamic json) {
    message = json['message'];
    status = json['status'];
    documentationUrl = json['documentation_url'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['message'] = message;
    map['status'] = status;
    map['documentation_url'] = documentationUrl;
    return map;
  }

}