import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_event.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/home_form/rent_car/daily/without_driver/without_driver_form.dart';

class DailyTab extends StatelessWidget {
  const DailyTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
      final dailyId = state.data?['daily_tab']?['id'] as String?;

      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  _buildTabButton(
                    context,
                    id: 'Without Driver',
                    dailyId: dailyId,
                    label: 'Tanpa Supir',
                    iconPath: 'ic_without_driver',
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(7),
                      bottomLeft: Radius.circular(7),
                    ),
                  ),
                  _buildTabButton(
                    context,
                    id: 'With Driver',
                    dailyId: dailyId,
                    label: 'Dengan Supir',
                    iconPath: 'ic_with_driver',
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(7),
                      bottomRight: Radius.circular(7),
                    ),
                  ),
                ],
              ),
              WithoutDriverForm()
            ],
          ));
    });
  }

  Widget _buildTabButton(
    BuildContext context, {
    required String id,
    required String? dailyId,
    required String label,
    required String iconPath,
    required BorderRadius borderRadius,
  }) {
    final isSelected = dailyId == id;

    return Expanded(
      child: ElevatedButton(
        onPressed: () => context.read<ServicesBloc>().add(SelectDailyTab(id)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.symmetric(vertical: 10),
          backgroundColor: !isSelected ? AppColors.white : AppColors.navy,
          side: BorderSide(
            color: AppColors.navy, // Warna outline
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Helper.getIconPath(isSelected ? '${iconPath}_active' : iconPath),
              height: 22,
              width: 22,
              color: !isSelected ? AppColors.grey5 : AppColors.white,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: !isSelected ? AppColors.grey5 : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
