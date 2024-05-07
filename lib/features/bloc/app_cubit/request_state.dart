/// Values that represents the current state of the endpoint request operation.
enum RequestStatus {
  /// Initial state
  init,

  /// loading state; used to show loading
  loading,

  /// loaded state; hides loading and shows data
  loaded,

  /// error state; shows error widget
  error,

  /// unauthorized state; logs out the user
  unAuthorized,
}

/// Class that handles state, value and possible errors generated during a
/// network data transmission.
///
/// Parameters:
/// - T: model which represents the type of the state.
class RequestState<T> {
  /// Variable that represents the current state of the response operation
  final RequestStatus status;

  final int? statusCode;

  /// Storages the current value of the operation. Its type is defined by
  /// the class itself.
  final T? value;

  /// Variable which stores possible error messages during network operations
  final String? message;

  /// [exceptionStatusCode] hold type of exception thrown  from [NetworkingProvider]
  final int? exceptionStatusCode;
  final Map<String, dynamic> errorMessages;

  const RequestState._({
    required this.status,
    this.value,
    this.message,
    this.statusCode,
    this.exceptionStatusCode,
    this.errorMessages=const {},
  });

  /// Initial state. It doesn't stores anykind of data or error message.
  const RequestState.init()
      : this._(
          status: RequestStatus.init,
        );

  /// Loading state, between initialization & data.
  /// It also receives the previous value if available.
  const RequestState.loading([T? previousValue])
      : this._(
          value: previousValue,
          status: RequestStatus.loading,
        );

  /// The request has been completed, and data has been received from the service.
  /// Data's type is checked.
  RequestState.loaded([T? data, String? message, int? statusCode])
      : this._(
          status: RequestStatus.loaded,
          value: data,
          message: message ?? '',
          statusCode: statusCode ?? 0,
        );

  /// An error has been generated in the network request process
  /// The error message is saved inside the [message] variable.
  const RequestState.error(String error,
      {int? statusCode, Map<String, dynamic> errorMessages=const {}})
      : this._(
            status: RequestStatus.error,
            message: error,
            statusCode: statusCode,
            errorMessages: errorMessages);

  /// An un authorized error has been generated in the network request process
  /// The error message is saved inside the [message] variable.
  const RequestState.unAuthorized(String error)
      : this._(
          status: RequestStatus.unAuthorized,
          message: error,
        );

  List<Object?> get props => [
        status.index,
        value.toString(),
        message,
      ];

  @override
  String toString() => '($status: $value, $message)';
}
