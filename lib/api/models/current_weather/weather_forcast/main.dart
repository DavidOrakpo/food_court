import 'dart:convert';

import 'package:collection/collection.dart';

class Main {
	double? temp;
	double? feelsLike;
	double? tempMin;
	double? tempMax;
	int? pressure;
	int? humidity;
	int? seaLevel;
	int? grndLevel;

	Main({
		this.temp, 
		this.feelsLike, 
		this.tempMin, 
		this.tempMax, 
		this.pressure, 
		this.humidity, 
		this.seaLevel, 
		this.grndLevel, 
	});

	factory Main.fromMap(Map<String, dynamic> data) => Main(
				temp: (data['temp'] as num?)?.toDouble(),
				feelsLike: (data['feels_like'] as num?)?.toDouble(),
				tempMin: (data['temp_min'] as num?)?.toDouble(),
				tempMax: (data['temp_max'] as num?)?.toDouble(),
				pressure: data['pressure'] as int?,
				humidity: data['humidity'] as int?,
				seaLevel: data['sea_level'] as int?,
				grndLevel: data['grnd_level'] as int?,
			);

	Map<String, dynamic> toMap() => {
				'temp': temp,
				'feels_like': feelsLike,
				'temp_min': tempMin,
				'temp_max': tempMax,
				'pressure': pressure,
				'humidity': humidity,
				'sea_level': seaLevel,
				'grnd_level': grndLevel,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Main].
	factory Main.fromJson(String data) {
		return Main.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [Main] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! Main) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			temp.hashCode ^
			feelsLike.hashCode ^
			tempMin.hashCode ^
			tempMax.hashCode ^
			pressure.hashCode ^
			humidity.hashCode ^
			seaLevel.hashCode ^
			grndLevel.hashCode;
}
