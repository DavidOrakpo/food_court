import 'dart:convert';

import 'package:collection/collection.dart';

import 'locations_datum.dart';

class LocationsData {
  List<LocationsDatum>? locationsData;

  LocationsData({this.locationsData});

  factory LocationsData.fromMap(Map<String, dynamic> data) => LocationsData(
        locationsData: (data['locationsData'] as List<dynamic>?)
            ?.map((e) => LocationsDatum.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'locationsData': locationsData?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationsData].
  factory LocationsData.fromJson(String data) {
    return LocationsData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LocationsData] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LocationsData) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => locationsData.hashCode;
}
