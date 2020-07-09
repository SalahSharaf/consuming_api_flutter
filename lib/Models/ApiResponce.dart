class ApiResponse<T> {
  T data;
  String errorMessage;
  bool error = false;

  ApiResponse(this.data, this.error,this.errorMessage);
}
