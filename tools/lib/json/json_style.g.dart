// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonStyle _$JsonStyleFromJson(Map<String, dynamic> json) => JsonStyle(
      color: json['color'] as String,
      paintingStyle: $enumDecode(_$PaintingStyleEnumMap, json['paintingStyle']),
      strokeWidth: json['strokeWidth'] as num?,
      strokeJoin: $enumDecodeNullable(_$StrokeJoinEnumMap, json['strokeJoin']),
      strokeCap: $enumDecodeNullable(_$StrokeCapEnumMap, json['strokeCap']),
      fontWeight: json['fontWeight'] as String?,
      fontSize: json['fontSize'] as num?,
    );

Map<String, dynamic> _$JsonStyleToJson(JsonStyle instance) => <String, dynamic>{
      'color': instance.color,
      'paintingStyle': _$PaintingStyleEnumMap[instance.paintingStyle]!,
      'strokeWidth': instance.strokeWidth,
      'strokeJoin': _$StrokeJoinEnumMap[instance.strokeJoin],
      'strokeCap': _$StrokeCapEnumMap[instance.strokeCap],
      'fontWeight': instance.fontWeight,
      'fontSize': instance.fontSize,
    };

const _$PaintingStyleEnumMap = {
  PaintingStyle.fill: 'fill',
  PaintingStyle.stroke: 'stroke',
};

const _$StrokeJoinEnumMap = {
  StrokeJoin.miter: 'miter',
  StrokeJoin.round: 'round',
  StrokeJoin.bevel: 'bevel',
};

const _$StrokeCapEnumMap = {
  StrokeCap.butt: 'butt',
  StrokeCap.round: 'round',
  StrokeCap.square: 'square',
};
