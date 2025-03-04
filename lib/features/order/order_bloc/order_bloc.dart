import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitialState()) {
    on<OrderEvent>((event, emit) async {
      try {
        emit(OrderLoadingState());
        SupabaseQueryBuilder table = Supabase.instance.client.from('orders');

        if (event is GetAllOrdersEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');

          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> orders =
              await query.order('id', ascending: true);

          emit(OrderGetSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          await table.insert(event.orderDetails);
          emit(OrderSuccessState());
        } else if (event is EditOrderEvent) {
          await table.update(event.orderDetails).eq('id', event.orderId);
          emit(OrderSuccessState());
        } else if (event is DeleteOrderEvent) {
          await table.delete().eq('id', event.orderId);
          emit(OrderSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrderFailureState());
      }
    });
  }
}
