import 'package:flutter/cupertino.dart';

class LifeCycleEvent extends WidgetsBindingObserver{
  static bool isPaymentActive = false;
  final Function? resumeCallBack;
  final Function? pauseCallBack;
  final Function? inactiveCallBack;
  final Function? detachCallBack;
  final Function? hiddenCallBack;
  LifeCycleEvent({this.resumeCallBack, this.pauseCallBack, this.inactiveCallBack, this.detachCallBack, this.hiddenCallBack});

  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.paused:
        if(pauseCallBack != null){
          pauseCallBack!();
        }
        break;
      case AppLifecycleState.resumed:
        if(resumeCallBack != null){
          resumeCallBack!();
        }
        break;
      case AppLifecycleState.inactive:
        if(inactiveCallBack != null){
          inactiveCallBack!();
        }
        break;
      case AppLifecycleState.detached:
        if(detachCallBack != null){
          detachCallBack!();
        }
        break;
      case AppLifecycleState.hidden:
        if(hiddenCallBack != null){
          hiddenCallBack!();
        }
        break;
    }
  }
}