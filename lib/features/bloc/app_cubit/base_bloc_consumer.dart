import 'package:advanced_architecture_demo/features/bloc/app_cubit/request_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'base_app_cubit.dart';


typedef RequestWidgetBuilder<T> = Widget Function(
  BuildContext context,
  RequestState<T> state,
);


/// [BaseBlocConsumer] used to handle status emitted from [BaseCubit]
///
/// Handles [RequestState.error], [RequestState.loading], [RequestState.loaded], [RequestState.unAuthorized] for the UI
/// In case of [RequestState.error] => [ErrorView] is shown and a [retryCallback] is passed to handle retries
/// In case of [RequestState.loading] => on a view which isn't a form ([isConsumerAction] is false)
///   we show [LoadingView]
/// In case of [RequestState.loaded] => we show the passed [childBuilder]
class BaseBlocConsumer<C extends BaseAppCubit<T>, T>
    extends StatelessWidget {

  /// Used to show snackBar for the form/actions on submit api failures
  final bool isConsumerAction;

  /// This builder is used to handle the UI in loaded state
  final RequestWidgetBuilder<T> onSuccessBuilder;

  /// callback for listener
  final Function(BuildContext, T?)? listenerCallBack;

  /// Error View top padding (optional)
  final double? errorViewTopPadding;

  /// Shows notice on success of the api call
  final bool showNoticeOnSuccess;

  /// this contains the api call to reload the data
  final Function? retryCallback;

  /// Localized retry title added to snack
  final String? localizedActionRetryTitle;

  /// retry snack bar duration
  final Duration? retrySnackBarDuration;

  final bool isLoadingShown;
  final double snackBarHeight;
  /// This widget passed in case that we need to show custom loading widget
  /// & if [isLoadingShown] is false
  final Widget? customLoadingWidget;

  const BaseBlocConsumer({
    Key? key,
    required this.onSuccessBuilder,
    this.listenerCallBack,
    this.isConsumerAction = false,
    this.errorViewTopPadding,
    this.showNoticeOnSuccess = false,
    this.isLoadingShown = true,
    this.localizedActionRetryTitle,
    this.retrySnackBarDuration,
    this.retryCallback,
    this.customLoadingWidget, this.snackBarHeight = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<C, RequestState<T>>(builder: (context, state) {
      switch (state.status) {
        case RequestStatus.error:
        ///todo add generic error widget
          continue loaded;
        case RequestStatus.loading:
          ///todo add generic loading widget
          continue loaded;
        loaded:
        default:
          return onSuccessBuilder(
            context,
            state,
          );
      }
    }, listener: (context, state) {
      /// handle dialogs
      if (state.status == RequestStatus.error) {
        EasyLoading.dismiss();
        /// show error snackBar if server return some
        /// error and error messages map is empty map
        /// so we don't need to show snackBar ,we only show error messages of inputs
        if (isConsumerAction&&state.errorMessages.isEmpty&&state.statusCode!=451) {
          ///TODO show failure snackBar
        }
      }
      if (state.status == RequestStatus.loading&&isLoadingShown) {
        EasyLoading.show();
      }

      /// call custom [listenerCallBack] if UI have some special implementation
      if (state.status == RequestStatus.loaded) {
        EasyLoading.dismiss();
        listenerCallBack?.call(context, state.value);
        if (showNoticeOnSuccess) {
          ///TODO show success snackBar
        }
      }
    });
  }
}
