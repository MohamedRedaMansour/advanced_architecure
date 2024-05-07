import 'package:dio/dio.dart';

import '../../constants/api_constants/apis.dart';
import 'network_manager.dart';
import 'networking_models/base_network_models/base_network_deserializable.dart';
import 'networking_models/base_network_models/base_response.dart';



/// Wraps all related network decoding method
class NetworkDecoder {
  static NetworkDecoder shared = NetworkDecoder();

  /// Decodes `Map<String, dynamic>` / `List<dynamic>` into given object of type [K] wrapped in [BaseResponse]
  ///
  /// [responseType] of type [T] is used to map the json object to data model and must a subclass of [BaseNetworkDeserializable]
  /// [responseType] must be provided which is instance of type T used to call `fromJson()` method
  /// throws [TypeError] when dynamic type error happens.
  BaseResponse<K?> decode<T extends BaseNetworkDeserializable, K>({
    required Response<dynamic> response,
    required T responseType,
  }) {
    try {
      final data = response.data as Map<String, dynamic>;
      K? dataList;
      if (data['data'] != null && data['data'] is List) {
        final List list = data['data'] as List;
        if(list.isNotEmpty) {
          dataList = List<T>.from(
            list
                .map(
                  (item) => responseType.fromJson(item as Map<String, dynamic>),
            )
                .toList(),
          ) as K?;
        }
          return BaseResponse<K?>(
              code: response.statusCode,
              message: data[NetworkConst.messageKey] as String?,
              data: dataList,
              success: data[NetworkConst.success] as bool?,
          );

      } else {
        final K? wrapperObj = data['data'] != null
            ? responseType.fromJson(data['data'] as Map<String, dynamic>) as K?
            :  responseType.fromJson(data) as K?;
        print('############# ${wrapperObj.toString()}');
        return BaseResponse<K?>(
          code: response.statusCode,
          message: data[NetworkConst.messageKey] as String?,
          data: wrapperObj,
            success: data[NetworkConst.success] as bool?,
        );
      }
    } catch (e) {
      networkLogger.wtf(e);
      rethrow;
    }
  }
}
