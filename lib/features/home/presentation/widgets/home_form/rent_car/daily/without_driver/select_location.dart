import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_event.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/daily/without_driver/list_location.dart';
// import 'package:flutter_get_ride_app/features/services/bloc/services_bloc.dart';

class SelectLocation extends StatefulWidget {
  const SelectLocation({super.key});

  @override
  State<SelectLocation> createState() => _SelectLocationState();
}

class _SelectLocationState extends State<SelectLocation> {
  @override
  void initState() {
    super.initState();

    // Panggil event GetServices saat pertama kali masuk halaman
    context.read<ServicesBloc>().add(GetServices());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 6),
        const Text(
          'Pilih Lokasi Anda',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                builder: (BuildContext context) {
                  return const ListLocation();
                },
              );
            },
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              side: BorderSide(
                color: AppColors.grey3,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Image.asset(
                  Helper.getIconPath('ic_pinpoin'),
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 5),
                Text(
                  'Pilih Lokasi Anda',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grey3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
