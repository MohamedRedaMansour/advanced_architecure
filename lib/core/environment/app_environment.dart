import 'base_app_environment.dart';

enum EnvironmentType {
  development(
    BaseAppEnvironment(
      appName: 'Development',
      baseURL: 'https://google.com/',
    ),
  ),
  production(
    BaseAppEnvironment(
      appName: 'Production',
      baseURL: 'https://google.com/',
    ),
  ),
  staging(
    BaseAppEnvironment(
      appName: 'Staging',
      baseURL: 'https://google.com/',
    ),
  );

  const EnvironmentType(this.environment);

  final BaseAppEnvironment environment;
}