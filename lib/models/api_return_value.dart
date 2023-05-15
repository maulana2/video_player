class ApiReturnValue<T> {
  final int? code;
  final T? value;
  final String? message;

  ApiReturnValue({this.code, this.value, this.message});
}
