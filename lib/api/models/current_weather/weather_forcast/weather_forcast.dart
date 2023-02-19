import 'dart:convert';

import 'package:collection/collection.dart';

import 'clouds.dart';
import 'coord.dart';
import 'main.dart';
import 'rain.dart';
import 'sys.dart';
import 'weather.dart';
import 'wind.dart';

class WeatherForcast {
	Coord? coord;
	List<Weather>? weather;
	String? base;
	Main? main;
	int? visibility;
	Wind? wind;
	Rain? rain;
	Clouds? clouds;
	int? dt;
	Sys? sys;
	int? timezone;
	int? id;
	String? name;
	int? cod;

	WeatherForcast({
		this.coord, 
		this.weather, 
		this.base, 
		this.main, 
		this.visibility, 
		this.wind, 
		this.rain, 
		this.clouds, 
		this.dt, 
		this.sys, 
		this.timezone, 
		this.id, 
		this.name, 
		this.cod, 
	});

	factory WeatherForcast.fromMap(Map<String, dynamic> data) {
		return WeatherForcast(
			coord: data['coord'] == null
						? null
						: Coord.fromMap(data['coord'] as Map<String, dynamic>),
			weather: (data['weather'] as List<dynamic>?)
						?.map((e) => Weather.fromMap(e as Map<String, dynamic>))
						.toList(),
			base: data['base'] as String?,
			main: data['main'] == null
						? null
						: Main.fromMap(data['main'] as Map<String, dynamic>),
			visibility: data['visibility'] as int?,
			wind: data['wind'] == null
						? null
						: Wind.fromMap(data['wind'] as Map<String, dynamic>),
			rain: data['rain'] == null
						? null
						: Rain.fromMap(data['rain'] as Map<String, dynamic>),
			clouds: data['clouds'] == null
						? null
						: Clouds.fromMap(data['clouds'] as Map<String, dynamic>),
			dt: data['dt'] as int?,
			sys: data['sys'] == null
						? null
						: Sys.fromMap(data['sys'] as Map<String, dynamic>),
			timezone: data['timezone'] as int?,
			id: data['id'] as int?,
			name: data['name'] as String?,
			cod: data['cod'] as int?,
		);
	}



	Map<String, dynamic> toMap() => {
				'coord': coord?.toMap(),
				'weather': weather?.map((e) => e.toMap()).toList(),
				'base': base,
				'main': main?.toMap(),
				'visibility': visibility,
				'wind': wind?.toMap(),
				'rain': rain?.toMap(),
				'clouds': clouds?.toMap(),
				'dt': dt,
				'sys': sys?.toMap(),
				'timezone': timezone,
				'id': id,
				'name': name,
				'cod': cod,
			};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WeatherForcast].
	factory WeatherForcast.fromJson(String data) {
		return WeatherForcast.fromMap(json.decode(data) as Map<String, dynamic>);
	}
  /// `dart:convert`
  ///
  /// Converts [WeatherForcast] to a JSON string.
	String toJson() => json.encode(toMap());

	@override
	bool operator ==(Object other) {
		if (identical(other, this)) return true;
		if (other is! WeatherForcast) return false;
		final mapEquals = const DeepCollectionEquality().equals;
		return mapEquals(other.toMap(), toMap());
	}

	@override
	int get hashCode =>
			coord.hashCode ^
			weather.hashCode ^
			base.hashCode ^
			main.hashCode ^
			visibility.hashCode ^
			wind.hashCode ^
			rain.hashCode ^
			clouds.hashCode ^
			dt.hashCode ^
			sys.hashCode ^
			timezone.hashCode ^
			id.hashCode ^
			name.hashCode ^
			cod.hashCode;
}
