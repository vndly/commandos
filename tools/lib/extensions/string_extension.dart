import 'package:recase/recase.dart';

extension StringExtension on String {
  String get capitalize {
    final String camelCase = ReCase(this).camelCase;

    return '${camelCase[0].toUpperCase()}${camelCase.substring(1)}';
  }
}
