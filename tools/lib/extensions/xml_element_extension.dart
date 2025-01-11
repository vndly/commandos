import 'package:enum_to_string/enum_to_string.dart';
import 'package:xml/xml.dart';

extension XmlElementExtension on XmlElement {
  bool getBoolAttribute(String name, [bool defaultValue = false]) {
    try {
      return getAttribute(name) == 'true';
    } catch (e) {
      return defaultValue;
    }
  }

  num getNumAttribute(String name, [num defaultValue = 0]) {
    try {
      return num.parse(getAttribute(name) ?? '0');
    } catch (e) {
      return defaultValue;
    }
  }

  T getEnumAttribute<T>(String name, List<T> enumValues, T defaultValue) {
    try {
      return EnumToString.fromString(enumValues, getAttribute(name) ?? '') ?? defaultValue;
    } catch (e) {
      return defaultValue;
    }
  }

  bool hasAttribute(String name) => getAttribute(name) != null;
}
