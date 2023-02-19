import 'dart:convert';

import 'package:collection/collection.dart';

class Wind {
	double? speed;
	int? deg;
	double? gust;

	Wind({this.speed, this.deg, this.gust});

	factory Wind.fromMap(Map<String, dynamic> data) => Wind(
				speed: (data['speed'] as num?)?.toDouble(),
				deg: data['deg'] as int?,
				gust: (data['gust'] as num?)?.toDouble(),
			);

	Map<String, dynamic> toMap() => {
				'speed': speed,
				'deg': deg,
				'gust': gust,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Wind].
	factory Wind.fromJson(String data) {
		return Wind.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Wind] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Wind) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode => speed.hashCode ^ deg.hashCode ^ gust.hashCode;
}
