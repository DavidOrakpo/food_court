import 'dart:convert';

import 'package:collection/collection.dart';

class Weather {
	int? id;
	String? main;
	String? description;
	String? icon;

	Weather({this.id, this.main, this.description, this.icon});

	factory Weather.fromMap(Map<String, dynamic> data) => Weather(
				id: data['id'] as int?,
				main: data['main'] as String?,
				description: data['description'] as String?,
				icon: data['icon'] as String?,
			);

	Map<String, dynamic> toMap() => {
				'id': id,
				'main': main,
				'description': description,
				'icon': icon,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Weather].
	factory Weather.fromJson(String data) {
		return Weather.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Weather] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Weather) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			id.hashCode ^
			main.hashCode ^
			description.hashCode ^
			icon.hashCode;
}
