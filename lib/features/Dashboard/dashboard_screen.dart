import 'package:flutter/material.dart';
import 'package:pick_n_pay/features/Dashboard/dashboard_item.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Wrap(
            spacing: 25,
            children: [
              DashboardItem(
                  label: 'Total Shop',
                  value: '45',
                  iconData: Icons.shopping_bag_outlined),
              DashboardItem(
                  label: 'Total Revenue',
                  value: '45',
                  iconData: Icons.currency_rupee),
              DashboardItem(
                  label: 'Total Category',
                  value: '45',
                  iconData: Icons.category_outlined),
              DashboardItem(
                  label: 'Total Users',
                  value: '45',
                  iconData: Icons.person_2_outlined),
            ],
          )
        ],
      ),
    );
  }
}
