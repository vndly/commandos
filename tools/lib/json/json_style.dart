import 'package:cavedash_tools/extensions/num_extension.dart';
import 'package:cavedash_tools/types/painting_style.dart';
import 'package:cavedash_tools/types/stroke_cap.dart';
import 'package:cavedash_tools/types/stroke_join.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';

part 'json_style.g.dart';

@JsonSerializable()
class JsonStyle {
  final String color;
  final PaintingStyle paintingStyle;
  final num? strokeWidth;
  final StrokeJoin? strokeJoin;
  final StrokeCap? strokeCap;
  final String? fontWeight;
  final num? fontSize;

  const JsonStyle({
    required this.color,
    required this.paintingStyle,
    this.strokeWidth,
    this.strokeJoin,
    this.strokeCap,
    this.fontWeight,
    this.fontSize,
  });

  static JsonStyle? create(String? input) {
    if (input != null) {
      final Map<String, String> map = {};
      final List<String> entries = input.split(';');

      for (final String entry in entries) {
        final List<String> parts = entry.split(':');

        map[parts[0].trim()] = parts[1].trim();
      }

      String color = '00000000';
      PaintingStyle paintingStyle = PaintingStyle.fill;
      num? strokeWidth;
      StrokeJoin? strokeJoin;
      StrokeCap? strokeCap;
      String? fontWeight;
      num? fontSize;

      if (map.containsKey('fill') && (map['fill'] != 'none')) {
        final num opacity = map.containsKey('fill-opacity')
            ? num.parse(map['fill-opacity']!)
            : 1;
        final String fill = map.containsKey('fill')
            ? map['fill']!.replaceAll('#', '')
            : '000000';

        color = '${numToHex(opacity)}$fill';
        paintingStyle = PaintingStyle.fill;
      } else if (map.containsKey('stroke-opacity')) {
        final num opacity = map.containsKey('stroke-opacity')
            ? num.parse(map['stroke-opacity']!)
            : 1;
        final String stroke = map.containsKey('stroke')
            ? map['stroke']!.replaceAll('#', '')
            : '000000';

        color = '${numToHex(opacity)}$stroke';
        paintingStyle = PaintingStyle.stroke;

        if (map.containsKey('stroke-opacity') &&
            map.containsKey('stroke-width')) {
          strokeWidth = num.parse(map['stroke-width']!);
        }

        if (map.containsKey('stroke-linejoin')) {
          strokeJoin = EnumToString.fromString(
              StrokeJoin.values, map['stroke-linejoin']!);
        }

        if (map.containsKey('stroke-linecap')) {
          strokeCap =
              EnumToString.fromString(StrokeCap.values, map['stroke-linecap']!);
        }
      }

      if (map.containsKey('font-weight')) {
        fontWeight = map['font-weight']!;
      }

      if (map.containsKey('font-size')) {
        final String text = map['font-size']!;
        fontSize = num.parse(text.replaceAll('px', ''));
      }

      return JsonStyle(
        color: color,
        paintingStyle: paintingStyle,
        strokeWidth: strokeWidth?.rounded(),
        strokeJoin: strokeJoin,
        strokeCap: strokeCap,
        fontWeight: fontWeight,
        fontSize: fontSize?.rounded(),
      );
    } else {
      return null;
    }
  }

  static String numToHex(num value) => (value * 255).toInt().toRadixString(16);

  factory JsonStyle.fromJson(Map<String, dynamic> json) =>
      _$JsonStyleFromJson(json);

  Map<String, dynamic> toJson() => _$JsonStyleToJson(this);
}
