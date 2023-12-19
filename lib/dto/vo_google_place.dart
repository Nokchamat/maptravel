class GooglePlace {
  final String formattedAddress;
  final String displayName;
  final Location location;
  final List<AddressComponents> addressComponents;

  GooglePlace({
    required this.formattedAddress,
    required this.location,
    required this.displayName,
    required this.addressComponents,
  });

  factory GooglePlace.fromJson(Map<String, dynamic> json) {
    return GooglePlace(
      formattedAddress: json['formattedAddress'],
      location: Location.fromJson(json['location']),
      displayName: (json['displayName'])['text'],
      addressComponents: (json['addressComponents'] as List)
          .map((jsonAddress) => AddressComponents.fromJson(jsonAddress))
          .toList(),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({
    required this.latitude,
    required this.longitude,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}

class AddressComponents {
  final String longText;
  final String shortText;
  final List types;

  AddressComponents({
    required this.longText,
    required this.shortText,
    required this.types,
  });

  factory AddressComponents.fromJson(Map<String, dynamic> json) {
    return AddressComponents(
      longText: json['longText'],
      shortText: json['shortText'],
      types: json['types'],
    );
  }
}
