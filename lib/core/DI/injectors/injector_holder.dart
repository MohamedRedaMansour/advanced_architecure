import 'application_injectors/cubits_injector.dart';
import 'application_injectors/repos_injector.dart';
import 'base_injector.dart';

/// [InjectorHolder] hold all applicationInjectors e.g [CubitsInjector] ,[ReposInjector] ...
///
class InjectorHolder {
  static final List<BaseInjector> _applicationInjectors = [
    ReposInjector(),
    CubitsInjector(),
  ];

  /// iterate and inject all application modules
  static void injectAllApplicationModules() {
    for (var injector in _applicationInjectors) {
      injector.injectModules();
    }
  }
}
