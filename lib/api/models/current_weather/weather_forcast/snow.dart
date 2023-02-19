import 'dart:convert';

import 'package:collection/collection.dart';

class Snow {
  double? oneHourVolume, threeHourVolume;

  Snow({this.oneHourVolume, this.threeHourVolume});

  factory Snow.fromMap(Map<String, dynamic> data) => Snow(
        oneHourVolume: (data['1h'] as num?)?.toDouble(),
        threeHourVolume: (data['3h'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toMap() => {
        '1h': oneHourVolume,
        '3h': threeHourVolume,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Rain].
  factory Snow.fromJson(String data) {
    return Snow.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rain] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Snow) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => oneHourVolume.hashCode;
}
