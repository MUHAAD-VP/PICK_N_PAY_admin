import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay/common_widget/custom_button.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/common_widget/custom_view_button.dart';
import 'package:pick_n_pay/features/shop/add_shop.dart';
import 'package:pick_n_pay/features/shop/shop_detail_screen.dart';
import 'package:pick_n_pay/features/shop/shop_bloc/shop_bloc.dart';
import 'package:pick_n_pay/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final ShopBloc _shopBloc = ShopBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _shops = [];

  @override
  void initState() {
    getShops();
    super.initState();
  }

  void getShops() {
    _shopBloc.add(GetAllShopsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _shopBloc,
      child: BlocConsumer<ShopBloc, ShopState>(
        listener: (context, state) {
          if (state is ShopFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getShops();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ShopGetSuccessState) {
            _shops = state.shops;
            Logger().w(_shops);
            setState(() {});
          } else if (state is ShopSuccessState) {
            getShops();
          }
        },
        builder: (context, state) {
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
                          .copyWith(
                              fontWeight: FontWeight.bold,
                              color: secondaryColor),
                    ),
                    const Spacer(),
                    Expanded(
                      child: CustomSearch(
                        onSearch: (value) {
                          params['query'] = value;
                          getShops();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _shopBloc,
                            child: AddEditShop(),
                          ),
                        );
                      },
                      label: 'Add Shop',
                      iconData: Icons.add,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                if (state is ShopLoadingState)
                  const Center(child: CircularProgressIndicator()),
                if (state is ShopGetSuccessState && _shops.isEmpty)
                  const Center(child: Text('No Shops Found')),
                if (state is ShopGetSuccessState && _shops.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 1200,
                      columns: const [
                        DataColumn(label: Text('ID')),
                        DataColumn(label: Text('Shop Name')),
                        DataColumn(label: Text('Phone No')),
                        DataColumn(label: Text('Email')),
                        DataColumn(label: Text('Shop Details')),
                        DataColumn(
                          label: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Action')),
                        ),
                      ],
                      rows: List.generate(
                        _shops.length,
                        (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(_shops[index]['id'].toString())),
                              DataCell(Text(_shops[index]['name'])),
                              DataCell(Text(_shops[index]['phone'])),
                              DataCell(Text(_shops[index]['contact_email'])),
                              DataCell(
                                CustomViewButton(
                                  ontap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ShopDetailScreen(
                                          shopDetails: _shops[index],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              BlocProvider.value(
                                            value: _shopBloc,
                                            child: AddEditShop(
                                              shopDetails: _shops[index],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CustomAlertDialog(
                                            title: 'Delete Shop',
                                            description:
                                                'Are you sure you want to delete this shop?',
                                            primaryButton: 'Yes',
                                            onPrimaryPressed: () {
                                              _shopBloc.add(
                                                DeleteShopEvent(
                                                  shopId: _shops[index]['id'],
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            secondaryButton: 'No',
                                            onSecondaryPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.orange,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
