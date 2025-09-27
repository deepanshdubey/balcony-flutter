// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class SEn extends S {
  SEn([String locale = 'en']) : super(locale);

  @override
  String get applicationTitle => 'homework';

  @override
  String get connectionTimedOut =>
      'The connection has timed out. Please try again';

  @override
  String get connectionProblem =>
      'There are some problems with the connection. Please try again';
}
