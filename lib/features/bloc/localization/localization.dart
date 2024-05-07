import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

extension LocalizedStrings on BuildContext {
  /// Returns single instance of [AppLocalizations]
  /// Used instead of accessing and importing AppLocalizations at every page
  AppLocalization get localization => AppLocalization.of(this);
}
