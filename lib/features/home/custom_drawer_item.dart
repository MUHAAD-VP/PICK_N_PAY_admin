import 'package:flutter/material.dart';

class CustomDrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() ontap;
  final bool isSelected;
  final Color iconColor;
  final Color textColor;

  const CustomDrawerItem({
    super.key,
    required this.title,
    required this.icon,
    required this.ontap,
    this.isSelected = false,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              if (isSelected)
                Container(
                  width: 3,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.orange, // Indicator color
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              const SizedBox(width: 10),
              Icon(icon, color: iconColor),
              const SizedBox(width: 10),
              Text(
                title,
                style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.normal,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
