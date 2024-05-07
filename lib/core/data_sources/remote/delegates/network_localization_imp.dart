import '../../../../features/bloc/localization/localization_cubit.dart';

class NetworkLocalization {
  const NetworkLocalization(this.localizationCubit);

  final LocalizationCubit localizationCubit;

  Future<String> getLocale() async {
    /// TODO update here to support different languages
    return LocalizationCubit.localeAr.languageCode;
  }
}
