import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/switch_language.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Image.asset(
              Helper.getIconPath('mainLogo'),
              width: 63,
              height: 27,
            ),
            Spacer(),
            SwitchLanguage()
          ],
        ),
      );
  }
}
