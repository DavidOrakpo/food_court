import 'dart:convert';

import 'package:collection/collection.dart';

class Coord {
	double? lon;
	double? lat;

	Coord({this.lon, this.lat});

	factory Coord.fromMap(Map<String, dynamic> data) => Coord(
				lon: (data['lon'] as num?)?.toDouble(),
				lat: (data['lat'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toMap() => {
				'lon': lon,
				'lat': lat,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Coord].
	factory Coord.fromJson(String data) {
		return Coord.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Coord] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Coord) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => lon.hashCode ^ lat.hashCode;
}
