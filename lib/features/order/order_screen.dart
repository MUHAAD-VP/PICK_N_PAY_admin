import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay/common_widget/custom_search.dart';
import 'package:pick_n_pay/features/order/order_bloc/order_bloc.dart';
import 'package:pick_n_pay/theme/app_theme.dart';

import '../../common_widget/custom_alert_dialog.dart';
import '../../util/format_function.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrderBloc _orderBloc = OrderBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _orders = [];

  @override
  void initState() {
    getOrders();
    super.initState();
  }

  void getOrders() {
    _orderBloc.add(GetAllOrdersEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _orderBloc,
      child: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: 'Failed to load orders. Please try again.',
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getOrders();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is OrderGetSuccessState) {
            _orders = state.orders;
            Logger().w(_orders);
            setState(() {});
          } else if (state is OrderSuccessState) {
            getOrders();
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
                      'Orders',
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
                          getOrders();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 30),
                if (state is OrderLoadingState)
                  const Center(child: CircularProgressIndicator()),
                if (state is OrderGetSuccessState && _orders.isEmpty)
                  const Center(child: Text('No Orders Found')),
                if (state is OrderGetSuccessState && _orders.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 1200,
                      columns: const [
                        DataColumn(label: Text('Order ID')),
                        DataColumn(label: Text('Customer Name')),
                        DataColumn(label: Text('Created At')),
                        DataColumn(label: Text('Status')),
                        DataColumn(
                          label: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Action')),
                        ),
                      ],
                      rows: List.generate(
                        _orders.length,
                        (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(_orders[index]['id'].toString())),
                              DataCell(Text(formatValue(
                                  _orders[index]['customers']['name']))),
                              DataCell(Text(
                                  formatDate(_orders[index]['created_at']))),
                              DataCell(Text(_orders[index]['status'])),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        // Edit order functionality
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
                                            title: 'Delete Order',
                                            description:
                                                'Are you sure you want to delete this order?',
                                            primaryButton: 'Yes',
                                            onPrimaryPressed: () {
                                              _orderBloc.add(
                                                DeleteOrderEvent(
                                                  orderId: _orders[index]['id'],
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
