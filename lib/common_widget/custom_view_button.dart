import 'package:flutter/material.dart';
import 'package:pick_n_pay/theme/app_theme.dart';

class CustomViewButton extends StatelessWidget {
  const CustomViewButton({
    super.key,
    required this.ontap,
  });
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Material(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            'View',
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: onprimaryColor, fontWeight: FontWeight.w400),
          ),
        ),
      ),
    );
  }
}
