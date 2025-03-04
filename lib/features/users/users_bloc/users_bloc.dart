import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<UsersEvent>((event, emit) async {
      try {
        emit(UsersLoadingState());
        SupabaseQueryBuilder table = Supabase.instance.client.from('customers');

        if (event is GetAllUsersEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*');
          if (event.params['query'] != null) {
            String searchQuery = '%${event.params['query']}%';
            query = query.or(
                'name.ilike.$searchQuery,email.ilike.$searchQuery,phone.ilike.$searchQuery');
          }

          List<Map<String, dynamic>> users =
              await query.order('name', ascending: true);

          emit(UsersGetSuccessState(users: users));
        }
      } catch (e) {
        emit(UsersFailureState(message: e.toString()));
      }
    });
  }
}
