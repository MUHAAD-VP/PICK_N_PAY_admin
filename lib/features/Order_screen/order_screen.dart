import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/common_widget/custom_view_button.dart';
import 'package:pick_n_pay/features/Order_screen/order_detail_screen.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Orders',
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Expanded(
                child: CustomSearch(
                  onSearch: (value) {
                    // Implement search functionality
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 30), // Added spacing
          Expanded(
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1200,
              columns: const [
                DataColumn(label: Text('Order Id')),
                DataColumn(label: Text('User Name')),
                DataColumn(label: Text('Shop Name')),
                DataColumn(label: Text('Shop ID')),
                DataColumn(label: Text('Status')),
                DataColumn(label: Text('PickUp time')),
                DataColumn(label: Text('Order Details'), numeric: true),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('#4244')),
                  const DataCell(Text('Sukumaran')),
                  const DataCell(Text('Suku"s Shop')),
                  const DataCell(Text('#AD3453')),
                  const DataCell(Text('PENDING')),
                  const DataCell(Text('6.00pm')),
                  DataCell(CustomViewButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OrderDetailScreen(),
                          ));
                    },
                  )),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
