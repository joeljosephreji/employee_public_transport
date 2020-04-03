class Response {
  dynamic about;
  int status;
  bool success;

  Response({this.about, this.status, this.success});

  factory Response.fromJSON(Map<String, dynamic> data) {
    return Response(
        about: data['about'], status: data['status'], success: data['success']);
  }
}
