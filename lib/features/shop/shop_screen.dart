import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/common_widget/custom_view_button.dart';
import 'package:pick_n_pay/features/shop/add_shop.dart';
import 'package:pick_n_pay/features/shop/shop_detail_screen.dart';

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
              Text(
                'Shops',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
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
                DataColumn(label: Text('Phone No')),
                DataColumn(label: Text('Image URL')),
                DataColumn(label: Text('Email')),
                DataColumn(label: Text('Location')),
                DataColumn(label: Text('Shop Details'), numeric: true),
              ],
              rows: [
                DataRow(cells: [
                  const DataCell(Text('ABC Store')),
                  const DataCell(Text('+1 234 567 8901')),
                  const DataCell(Text('https://image.example.com')),
                  const DataCell(Text('abc@store.com')),
                  const DataCell(Text('https://maps.example.com')),
                  DataCell(CustomViewButton(
                    ontap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopDetailScreen(),
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
