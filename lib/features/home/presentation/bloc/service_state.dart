import 'package:equatable/equatable.dart';

class ServicesState extends Equatable {
  final Map<String, dynamic>? data; // Mungkin null

  const ServicesState(this.data);

  @override
  List<Object?> get props => [data];
}

class Location {
  final int id;
  final String name;
  final String timeZoneIdentifier;
  final String timeZone;

  Location({
    required this.id,
    required this.name,
    required this.timeZoneIdentifier,
    required this.timeZone,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
      timeZoneIdentifier: json['time_zone_identifier'],
      timeZone: json['time_zone'],
    );
  }
}

class ServicesInitial extends ServicesState {
  const ServicesInitial(super.data);
}

class ServicesLoading extends ServicesState {
  const ServicesLoading(super.data);
}

class ServicesLoaded extends ServicesState {
  // const ServicesLoaded(super.data);
  final Map<String, dynamic> data;

  const ServicesLoaded(this.data) : super(data);

  List<Location> get locations => data['locations'] != null
      ? (data['locations'] as List)
          .map((item) => Location.fromJson(item))
          .toList()
      : [];
}

// Tambahkan state untuk menyimpan data layanan
class ServicesError extends ServicesState {
  final String message;

  const ServicesError(this.message) : super(null);
}
