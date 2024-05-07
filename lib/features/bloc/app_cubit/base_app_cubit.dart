import 'dart:io';

import 'package:advanced_architecture_demo/features/bloc/app_cubit/request_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../core/data_sources/remote/networking_models/base_network_models/base_response.dart';

class BaseAppCubit<T> extends Cubit<RequestState<T>> {
  BaseAppCubit() : super(const RequestState.init());

  networkCall(Future Function() apiCall,
      {Function(BaseResponse)? successCall,Function(BaseResponse)? failureCall, bool showLoading = false ,Function(File)? successFileCall}) async {
    try {
      if (showLoading) {
        EasyLoading.show();
      }
      emitLoading();
      final response = await apiCall.call();
      if (response.hasError || response.success == false) {
        if(failureCall != null){
          failureCall.call(response);
        }else {
          emitError(response.message ?? "", response.code,response.errorMessages);
        }
        if (showLoading) EasyLoading.dismiss();
      } else {
        emitLoaded(response, response.message ?? "");
        if (showLoading) EasyLoading.dismiss();
        if(successCall != null){
          successCall.call(response);
        }else{
          successFileCall?.call(response);
        }
      }
      return response;
    } catch (error) {
      if (showLoading) EasyLoading.dismiss();
      return BaseResponse<T>(
          code: 1, message: error.toString());
    }
  }

  /***emitting section***/

  /// for show  loading
  emitLoading() {
    emit(const RequestState.loading());
  }

  /// TWO cased implementation will be in  app or will be here
  emitLoaded(T? data, String message) {
    emit(RequestState.loaded(data, message));
  }

  emitUnauthorizedException(Exception exception) {
    emit(RequestState.unAuthorized(exception.toString()));
  }

  emitError(String messageError, int statusCode,   Map<String, dynamic>? errorMessages) {
    /// emitting errors in case of exception is [NetworkingException]
    emit(RequestState.error(messageError, statusCode: statusCode,errorMessages: errorMessages??{}));
  }
}
