import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_alert_dialog.dart';
import 'package:pick_n_pay/features/Dashboard/dashboard_screen.dart';
import 'package:pick_n_pay/features/Order_screen/order_screen.dart';
import 'package:pick_n_pay/features/category/category_screen.dart';
import 'package:pick_n_pay/features/home/custom_drawer_item.dart';
import 'package:pick_n_pay/features/login/login_screeen.dart';
import 'package:pick_n_pay/features/shop/shop_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3), // Soft shadow
                  blurRadius: 10, // Spread of the shadow
                  offset: Offset(3, 3), // Positioning
                ),
              ],
            ),
            width: 230,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'PICK N PAY',
                      style: TextStyle(
                          color: Colors.green[300],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Divider(
                      color: Colors.grey[300],
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(height: 35),
                  CustomDrawerItem(
                    title: 'Dashboard',
                    icon: Icons.dashboard_outlined,
                    ontap: () {
                      tabController.animateTo(0);
                    },
                    isSelected: tabController.index == 0,
                    iconColor:
                        tabController.index == 0 ? Colors.orange : Colors.black,
                    textColor:
                        tabController.index == 0 ? Colors.orange : Colors.black,
                  ),
                  const SizedBox(height: 20),
                  CustomDrawerItem(
                    iconColor:
                        tabController.index == 1 ? Colors.orange : Colors.black,
                    textColor:
                        tabController.index == 1 ? Colors.orange : Colors.black,
                    isSelected: tabController.index == 1,
                    title: 'SHOPS',
                    icon: Icons.shopping_cart_outlined,
                    ontap: () {
                      tabController.animateTo(1);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDrawerItem(
                    iconColor:
                        tabController.index == 2 ? Colors.orange : Colors.black,
                    textColor:
                        tabController.index == 2 ? Colors.orange : Colors.black,
                    isSelected: tabController.index == 2,
                    title: 'Category Screen',
                    icon: Icons.category_outlined,
                    ontap: () {
                      tabController.animateTo(2);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDrawerItem(
                    iconColor:
                        tabController.index == 3 ? Colors.orange : Colors.black,
                    textColor:
                        tabController.index == 3 ? Colors.orange : Colors.black,
                    isSelected: tabController.index == 3,
                    title: 'Order Screen',
                    icon: Icons.border_all,
                    ontap: () {
                      tabController.animateTo(3);
                    },
                  ),
                  const SizedBox(height: 20),
                  CustomDrawerItem(
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    isSelected: tabController.index == 4,
                    title: 'LogOut',
                    icon: Icons.logout,
                    ontap: () {
                      showDialog(
                        context: context,
                        builder: (context) => CustomAlertDialog(
                          title: "LOG OUT",
                          content: const Text(
                            "Are you sure you want to log out? Clicking 'Logout' will end your current session and require you to sign in again to access your account.",
                          ),
                          width: 400,
                          primaryButton: "LOG OUT",
                          onPrimaryPressed: () {
                            Supabase.instance.client.auth.signOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginScreen(),
                                ),
                                (route) => false);
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: const [
                DashboardScreen(),
                ShopScreen(),
                CategoryScreen(),
                OrderScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
