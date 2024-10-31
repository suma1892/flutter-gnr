import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/network/dio_client.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_event.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';
import 'dart:developer' as developer;

const dataJson = {
  'main_active_tab': {
    'name': 'Car Rental',
    'id': 'Sewa Mobil',
  },
  'sub_active_tab': {
    'name': 'Daily',
    'id': 'Daily',
  },
  'daily_tab': {
    'name': 'without_driver',
    'id': 'Without Driver',
  },
  'without_driver_form': {
    'location_id': 0,
    'rental_start_date': DateTime,
    'rental_end_date': DateTime,
    'rental_start_time': '',
    'rental_end_time': ''
  },
  'with_driver_form': {
    'location_id': 0,
    'rental_start_date': DateTime,
    'rental_duration': 0,
    'rental_start_time': '',
  },
  'airport_transfer_form': {
    'pickup_location_id': 0,
    'dropoff_location_id': 0,
    'pickup_date': DateTime,
    'pickup_time': ''
  },
  'locations': []
};

class ServicesBloc extends Bloc<TabEvent, ServicesState> {
  ServicesBloc() : super(const ServicesState(dataJson)) {
    // Handler untuk SelectMainTab
    on<SelectMainTab>((event, emit) {
      final newMainTab = {
        ...?state.data,
        'main_active_tab': {
          'name': state.data?['main_active_tab']['name'],
          'id': event.id,
        },
      };
      emit(ServicesState(newMainTab));
    });

    // Handler untuk SelectSubTab
    on<SelectSubTab>((event, emit) {
      final newSubTab = {
        ...?state.data,
        'sub_active_tab': {
          'name': state.data?['sub_active_tab']['name'],
          'id': event.id,
        },
      };
      emit(ServicesState(newSubTab));
    });

    // Handler untuk SelectDailyTab
    on<SelectDailyTab>((event, emit) {
      final newContentTab = {
        ...?state.data,
        'daily_tab': {
          'name': state.data?['daily_tab']['name'],
          'id': event.id,
        },
      };
      emit(ServicesState(newContentTab));
    });

    // Handler untuk UpdateWithoutDriverForm
    on<UpdateWithoutDriverForm>((event, emit) {
      final updatedForm = {
        ...state.data?['without_driver_form'],
        ...event.formData,
      };
      final newData = {
        ...?state.data,
        'without_driver_form': updatedForm,
      };
      emit(ServicesState(newData));
    });

    // Handler untuk UpdateWithDriverForm
    on<UpdateWithDriverForm>((event, emit) {
      final updatedForm = {
        ...state.data?['with_driver_form'],
        ...event.formData,
      };
      final newData = {
        ...?state.data,
        'with_driver_form': updatedForm,
      };
      emit(ServicesState(newData));
    });

    // Handler untuk UpdateAirportTransferForm
    on<UpdateAirportTransferForm>((event, emit) {
      final updatedForm = {
        ...state.data?['airport_transfer_form'],
        ...event.formData,
      };
      final newData = {
        ...?state.data,
        'airport_transfer_form': updatedForm,
      };
      emit(ServicesState(newData));
    });

    on<GetServices>((event, emit) async {
      // emit(LoginLoading());

      try {
        var client = DioClient();
        final response = await client.dio.get('/services');
        // developer.log('Response Data: ${response.data}');

        if (response.statusCode == 200) {
          var stateData = state.data;

          var stateServiceId = stateData?['main_active_tab']['id'];
          var stateSubServiceId = stateData?['sub_active_tab']['id'];
          var stateFacilityId = stateData?['daily_tab']['id'];
          final responseData = response.data;

          final resServiceId = responseData
              .firstWhere((service) => service["name"] == stateServiceId);
          final resSubServiceId = resServiceId["sub_services"].firstWhere(
              (subService) => subService["name"] == stateSubServiceId);

          final resFacilityId = resSubServiceId["facilities"]
              .firstWhere((facility) => facility["name"] == stateFacilityId);

          add(GetLocation(
            serviceId: resServiceId['id'],
            subServiceId: resSubServiceId['id'],
            facilityId: resFacilityId['id'],
          ));
        } else {}
      } catch (e) {
        developer.log(e.toString());
        // emit(LoginFailure(error: e.toString()));
      }
    });

    on<GetLocation>((event, emit) async {
      try {
        var client = DioClient();
        final response = await client.dio.get(
          '/location',
          queryParameters: {
            'service_id': event.serviceId,
            'sub_service_id': event.subServiceId,
            'facility_id': event.facilityId,
          },
        );

        if (response.statusCode == 200) {
          // final locationData = response.data;
          // developer.log('Location Data: $locationData');
          // emit(ServicesLoaded(locationData) as ServicesState);

          // Pastikan response.data adalah List<dynamic>
          List<dynamic> responseData = response.data;

          // Konversi List<dynamic> menjadi List<Location>
          // List<Location> locations = parseLocations(responseData);

          // Emit state dengan data lokasi yang telah diproses
          // emit(ServicesLoaded(locations));
          // developer.log('bloc loc = $responseData');
          final newSubTab = {
            ...?state.data,
            'locations': responseData,
          };
          emit(ServicesLoaded(newSubTab));
          // Emit state sesuai kebutuhan
        }
      } catch (e) {
        developer.log(e.toString());
      }
    });
  }
}
