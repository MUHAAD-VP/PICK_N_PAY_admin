import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/features/shop/add_shop.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'Shops',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Expanded(
                child: CustomSearch(
                  onSearch: (value) {
                    // Implement search functionality
                  },
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              CustomButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => AddShop(),
                  );
                },
                label: 'Add Shop',
                iconData: Icons.add,
              )
            ],
          ),
          const SizedBox(height: 30), // Added spacing
          Expanded(
            child: DataTable2(
              columnSpacing: 12,
              horizontalMargin: 12,
              minWidth: 1200,
              columns: const [
                DataColumn(label: Text('Shop Name')),
                DataColumn(label: Text('Building No')),
                DataColumn(label: Text('Street Name')),
                DataColumn(label: Text('City')),
                DataColumn(label: Text('District')),
                DataColumn(label: Text('State')),
                DataColumn(label: Text('Pincode')),
                DataColumn(label: Text('Phone No')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Image URL'), numeric: true),
              ],
              rows: const [
                DataRow(cells: [
                  DataCell(Text('ABC Store')),
                  DataCell(Text('123')),
                  DataCell(Text('Main Street')),
                  DataCell(Text('New York')),
                  DataCell(Text('Manhattan')),
                  DataCell(Text('NY')),
                  DataCell(Text('10001')),
                  DataCell(Text('+1 234 567 8901')),
                  DataCell(Text('abc@store.com')),
                  DataCell(Text('https://maps.example.com')),
                  DataCell(Text('https://image.example.com')),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
