import 'dart:convert';

import 'package:collection/collection.dart';

class LocationsDatum {
  String? city;
  double? lat;
  double? lng;
  String? country;
  String? iso2;
  String? adminName;
  String? capital;
  double? population;
  double? populationProper;

  LocationsDatum({
    this.city,
    this.lat,
    this.lng,
    this.country,
    this.iso2,
    this.adminName,
    this.capital,
    this.population,
    this.populationProper,
  });

  factory LocationsDatum.fromMap(Map<String, dynamic> data) {
    return LocationsDatum(
      city: data['city'] as String?,
      lat: double.parse(data['lat'] as String),
      lng: double.parse(data['lng'] as String),
      country: data['country'] as String?,
      iso2: data['iso2'] as String?,
      adminName: data['admin_name'] as String?,
      capital: data['capital'] as String?,
      population: double.tryParse(data['population'] as String),
      populationProper: double.tryParse(data['population_proper'] as String),
    );
  }

  Map<String, dynamic> toMap() => {
        'city': city,
        'lat': lat,
        'lng': lng,
        'country': country,
        'iso2': iso2,
        'admin_name': adminName,
        'capital': capital,
        'population': population,
        'population_proper': populationProper,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LocationsDatum].
  factory LocationsDatum.fromJson(String data) {
    return LocationsDatum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LocationsDatum] to a JSON string.
  String toJson() => json.encode(toMap());

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! LocationsDatum) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode =>
      city.hashCode ^
      lat.hashCode ^
      lng.hashCode ^
      country.hashCode ^
      iso2.hashCode ^
      adminName.hashCode ^
      capital.hashCode ^
      population.hashCode ^
      populationProper.hashCode;
}
