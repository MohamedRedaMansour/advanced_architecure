/// Abstraction that allows model to be encoded / serialized
///
/// [T] is the data type used as the return type for the [fromJson]
abstract class BaseNetworkSerializable<T> {
  /// Returns the json map the after encoding / serializing the data of type [T]
  ///
  /// This is used to encode / serialize and transmit the data to the serverside or
  /// store it as a serialized string
  ///
  Map<String, dynamic> toJson();
}
