import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:pick_n_pay/values/strings.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../util/file_upload.dart';

part 'shop_event.dart';
part 'shop_state.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc() : super(ShopInitialState()) {
    on<ShopEvent>((event, emit) async {
      try {
        emit(ShopLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        SupabaseQueryBuilder table = Supabase.instance.client.from('shops');

        if (event is GetAllShopsEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');
          if (event.params['query'] != null) {
            query = query.or(
                'name.ilike.%${event.params['query']}%,phone.ilike.%${event.params['query']}%,contact_email.ilike.%${event.params['query']}%');
          }

          List<Map<String, dynamic>> shops =
              await query.order('name', ascending: true);

          emit(ShopGetSuccessState(shops: shops));
        } else if (event is AddShopEvent) {
          final response = await supabaseClient.auth.admin.createUser(
            AdminUserAttributes(
              email: event.shopDetails['email'],
              password: event.shopDetails['password'],
              emailConfirm: true,
              appMetadata: {"role": "shop"},
            ),
          );
          event.shopDetails.remove('password');
          event.shopDetails.remove('email');
          event.shopDetails['user_id'] = response.user?.id;
          event.shopDetails['image_url'] = await uploadFile(
            'petstores/image',
            event.shopDetails['image'],
            event.shopDetails['image_name'],
          );
          event.shopDetails.remove('image');
          event.shopDetails.remove('image_name');

          await table.insert(event.shopDetails);
          emit(ShopSuccessState());
        } else if (event is EditShopEvent) {
          event.shopDetails.remove('email');
          event.shopDetails.remove('password');
          if (event.shopDetails['image'] != null) {
            event.shopDetails['image_url'] = await uploadFile(
              'petstores/image',
              event.shopDetails['image'],
              event.shopDetails['image_name'],
            );
            event.shopDetails.remove('image');
            event.shopDetails.remove('image_name');
          }
          await table.update(event.shopDetails).eq('id', event.shopId);
          emit(ShopSuccessState());
        } else if (event is DeleteShopEvent) {
          await table.delete().eq('id', event.shopId);
          emit(ShopSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ShopFailureState());
      }
    });
  }
}
