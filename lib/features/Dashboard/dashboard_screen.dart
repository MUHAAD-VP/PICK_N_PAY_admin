import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay/features/Dashboard/dashboard_bloc/dashboard_bloc.dart';
import 'package:pick_n_pay/features/Dashboard/dashboard_item.dart';

import '../../common_widget/custom_alert_dialog.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final DashboardBloc _dashboardBloc = DashboardBloc();
  Map<String, dynamic> _dashboardData = {};

  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  void getDashboardData() {
    _dashboardBloc.add(GetDashboardDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _dashboardBloc,
      child: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state is DashboardFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: 'Failed to load dashboard data. Please try again.',
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getDashboardData();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is DashboardSuccessState) {
            _dashboardData = state.data;
            Logger().w(_dashboardData);
            setState(() {});
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is DashboardLoadingState)
                  const Center(child: CircularProgressIndicator()),
                if (state is DashboardSuccessState && _dashboardData.isEmpty)
                  const Center(child: Text('No Data Found')),
                if (state is DashboardSuccessState && _dashboardData.isNotEmpty)
                  Wrap(
                    spacing: 25,
                    children: [
                      DashboardItem(
                        label: 'Total Shops',
                        value: _dashboardData['total_shops'].toString(),
                        iconData: Icons.shopping_bag_outlined,
                      ),
                      DashboardItem(
                        label: 'Total Orders',
                        value: _dashboardData['total_orders'].toString(),
                        iconData: Icons.shopping_cart_outlined,
                      ),
                      DashboardItem(
                        label: 'Total Categories',
                        value: _dashboardData['total_categories'].toString(),
                        iconData: Icons.category_outlined,
                      ),
                      DashboardItem(
                        label: 'Total Users',
                        value: _dashboardData['total_users'].toString(),
                        iconData: Icons.person_2_outlined,
                      ),
                    ],
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
