import 'package:equatable/equatable.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';

abstract class TabEvent extends Equatable {
  const TabEvent();

  @override
  List<Object?> get props => [];
}

class SelectMainTab extends TabEvent {
  final String id;

  const SelectMainTab(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectSubTab extends TabEvent {
  final String id;

  const SelectSubTab(this.id);

  @override
  List<Object?> get props => [id];
}

class SelectDailyTab extends TabEvent {
  final String id;

  const SelectDailyTab(this.id);

  @override
  List<Object?> get props => [id];
}

// Event untuk memperbarui form
class UpdateWithoutDriverForm extends TabEvent {
  final Map<String, dynamic> formData;

  const UpdateWithoutDriverForm(this.formData);

  @override
  List<Object?> get props => [formData];
}

class UpdateWithDriverForm extends TabEvent {
  final Map<String, dynamic> formData;

  const UpdateWithDriverForm(this.formData);

  @override
  List<Object?> get props => [formData];
}

class UpdateAirportTransferForm extends TabEvent {
  final Map<String, dynamic> formData;

  const UpdateAirportTransferForm(this.formData);

  @override
  List<Object?> get props => [formData];
}

class GetServices extends TabEvent {
  const GetServices();

  @override
  List<Object> get props => [];
}

class GetLocation extends TabEvent {
  final int serviceId;
  final int subServiceId;
  final int facilityId;

  const GetLocation({
    required this.serviceId,
    required this.subServiceId,
    required this.facilityId,
  });
}

class UpdateLocations extends TabEvent {
  final List<Location> locations;

  const UpdateLocations(this.locations);
}

List<Location> parseLocations(List<dynamic> responseData) {
  return responseData
      .map((json) => Location.fromJson(json as Map<String, dynamic>))
      .toList();
}
