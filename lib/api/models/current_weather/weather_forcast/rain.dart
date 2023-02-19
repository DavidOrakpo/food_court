import 'dart:convert';

import 'package:collection/collection.dart';

class Rain {
  double? oneHourVolume, threeHourVolume;

  Rain({this.oneHourVolume, this.threeHourVolume});

  factory Rain.fromMap(Map<String, dynamic> data) => Rain(
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
  factory Rain.fromJson(String data) {
    return Rain.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Rain] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Rain) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => oneHourVolume.hashCode;
}
