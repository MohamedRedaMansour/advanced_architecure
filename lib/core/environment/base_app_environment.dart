/// add enum field called environmentType used to identify which
/// environment we currently use
/// ```dart
/// enum EnvironmentType{
/// development,
/// release,
/// ...
/// }
/// ```

class BaseAppEnvironment {
  const BaseAppEnvironment({
    required this.appName,
    required this.baseURL,
  });
  final String baseURL;
  final String appName;
}
