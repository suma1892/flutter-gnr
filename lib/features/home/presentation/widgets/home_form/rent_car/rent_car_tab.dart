import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_event.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/daily/daily_tab.dart';

class RentCarTab extends StatelessWidget {
  const RentCarTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
      final mainTabId = state.data?['sub_active_tab']?['id'] as String?;

      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTabButton(
                  context,
                  id: 'Daily',
                  mainTabId: mainTabId,
                  label: 'Daily',
                  iconPath: 'ic_daily',
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(7),
                    bottomLeft: Radius.circular(7),
                  ),
                ),
                _buildTabButton(
                  context,
                  id: 'Airport Transfer',
                  mainTabId: mainTabId,
                  label: 'Airport Transfer',
                  iconPath: 'ic_daily_driver_airport',
                  borderRadius: BorderRadius.zero,
                ),
                _buildTabButton(
                  context,
                  id: 'Tour',
                  mainTabId: mainTabId,
                  label: 'tour',
                  iconPath: 'ic_daily_driver_tour',
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(7),
                    bottomRight: Radius.circular(7),
                  ),
                ),
              ],
            ),
          ),
          DailyTab(),
        ],
      );
    });
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String id,
    required String? mainTabId,
    required String label,
    required String iconPath,
    required BorderRadius borderRadius,
  }) {
    final isSelected = mainTabId == id;

    return ElevatedButton(
        onPressed: () => context.read<ServicesBloc>().add(SelectSubTab(id)),
        style: ElevatedButton.styleFrom(
          splashFactory: NoSplash.splashFactory,
          shadowColor: Colors.transparent,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          backgroundColor: AppColors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  Helper.getIconPath(iconPath),
                  height: 22,
                  width: 22,
                ),
                const SizedBox(width: 5),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: isSelected ? AppColors.navy : AppColors.grey3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4), // Jarak antara Row dan underline
            Container(
              height: 2, // Tinggi underline
              width: 50, // Panjang underline bisa disesuaikan
              color: isSelected ? AppColors.navy : Colors.transparent,
            ),
          ],
        ));
  }
}
