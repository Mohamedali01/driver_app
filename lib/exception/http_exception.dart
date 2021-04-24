class HttpException implements Exception {
  String? text;

  HttpException(this.text);

  @override
  String toString() {

    return text!;
  }
}