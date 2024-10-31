import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_bloc.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_event.dart';
import 'package:flutter_get_ride_app/features/home/presentation/bloc/service_state.dart';
import 'dart:developer' as developer;

class MainServiceTab extends StatelessWidget {
  const MainServiceTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ServicesBloc, ServicesState>(builder: (context, state) {
      final mainTabId = state.data?['main_active_tab']?['id'] as String?;
      developer.log('mainTabId $mainTabId');
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              _buildTabButton(
                context,
                id: 'Sewa Mobil',
                mainTabId: mainTabId,
                label: 'Sewa Mobil',
                iconPath: 'ic_rent_car',
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(7),
                  bottomLeft: Radius.circular(7),
                ),
              ),
              _buildTabButton(
                context,
                id: 'Sewa Motor',
                mainTabId: mainTabId,
                label: 'Sewa Motor',
                iconPath: 'ic_rent_motorcycle',
                borderRadius: BorderRadius.zero,
              ),
              _buildTabButton(
                context,
                id: 'Sewa Sepeda',
                mainTabId: mainTabId,
                label: 'Sewa Sepeda',
                iconPath: 'ic_rent_bicycle',
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(7),
                  bottomRight: Radius.circular(7),
                ),
              ),
            ],
          ),
        ),
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

    return Expanded(
      child: ElevatedButton(
        onPressed: () => context.read<ServicesBloc>().add(SelectMainTab(id)),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          padding: const EdgeInsets.symmetric(vertical: 16),
          backgroundColor: isSelected ? AppColors.white : AppColors.navy,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              Helper.getIconPath(isSelected ? '${iconPath}_active' : iconPath),
              height: 22,
              width: 22,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: isSelected ? AppColors.navy : AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
