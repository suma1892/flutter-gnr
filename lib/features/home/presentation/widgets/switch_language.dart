import 'package:flutter/material.dart';
import 'package:flutter_get_ride_app/core/helper/helper.dart';
import 'package:flutter_get_ride_app/core/styles/app_colors.dart';
import 'package:flutter_get_ride_app/features/home/presentation/widgets/list_language.dart';

class SwitchLanguage extends StatelessWidget {
  const SwitchLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return ListLanguage();
          },
        );
      },
      style: ButtonStyle(
          elevation: WidgetStateProperty.all(0),
          side: WidgetStatePropertyAll(
              BorderSide(width: 1.0, color: AppColors.navy))
          // shadowColor: Colors.white,

          ),
      child: Row(
        children: [
          Image.asset(
            Helper.getIconPath('ic_en'),
            width: 18,
            height: 18,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            'EN',
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.navy),
          )
        ],
      ),
    );
  }
}
