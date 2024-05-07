/// Abstraction that allows model to be deserialized / decoded
///
/// [T] is the data type used as the return type for the [fromJson]
abstract class BaseNetworkDeserializable<T> {
  /// Returns the data of type [T] after decoding / deserializing the [json]
  ///
  /// This is used to decoding / deserializing and transmit the [data] to the serverside
  /// or store it as a serialized string
  ///
  T fromJson(Map<String, dynamic> json);
}
