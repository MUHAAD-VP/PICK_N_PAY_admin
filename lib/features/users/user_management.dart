import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_search.dart';
import 'users_bloc/users_bloc.dart';

class UserManagementSection extends StatefulWidget {
  const UserManagementSection({super.key});

  @override
  State<UserManagementSection> createState() => _UserManagementSectionState();
}

class _UserManagementSectionState extends State<UserManagementSection> {
  final UsersBloc _usersBloc = UsersBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map> _users = [];

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  void getUsers() {
    _usersBloc.add(GetAllUsersEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _usersBloc,
      child: BlocConsumer<UsersBloc, UsersState>(
        listener: (context, state) {
          if (state is UsersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getUsers();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is UsersGetSuccessState) {
            _users = state.users;
            Logger().w(_users);
            setState(() {});
          } else if (state is UsersSuccessState) {
            getUsers();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Expanded(
                      child: Text(
                        'User Management',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: CustomSearch(
                        onSearch: (query) {
                          params['query'] = query;
                          getUsers();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                if (state is UsersLoadingState) LinearProgressIndicator(),
                if (state is UsersGetSuccessState && _users.isEmpty)
                  Center(
                    child: Text("No Users found!"),
                  ),
                if (state is UsersGetSuccessState && _users.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      dataRowHeight: 80,
                      columns: const [
                        DataColumn2(label: Text('ID'), size: ColumnSize.S),
                        DataColumn2(label: Text('Avatar'), size: ColumnSize.S),
                        DataColumn2(label: Text('Name'), size: ColumnSize.L),
                        DataColumn2(label: Text('Email'), size: ColumnSize.L),
                        DataColumn2(label: Text('Phone'), size: ColumnSize.L),
                      ],
                      rows: List<DataRow>.generate(
                        _users.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(Text('${_users[index]['id']}')),
                            DataCell(
                              _users[index]['photo'] != null
                                  ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.network(
                                          _users[index]['photo'],
                                          fit: BoxFit.cover,
                                          width: 60,
                                          height: 60,
                                        ),
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 30,
                                      child: Icon(Icons.person),
                                    ),
                            ),
                            DataCell(Text(_users[index]['name'])),
                            DataCell(Text(_users[index]['email'])),
                            DataCell(Text(_users[index]['phone'] ?? 'N/A')),
                          ],
                        ),
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
