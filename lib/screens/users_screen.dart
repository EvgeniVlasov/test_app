import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/user_details_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/users_bloc.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';
import 'package:flutter_test_app_eclipse/screens/user_details_screen.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/item_widget_card.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late UsersBloc _usersBloc;

  @override
  void didChangeDependencies() {
    _usersBloc = BlocProvider.of<UsersBloc>(context);
    _usersBloc.add(UsersBlocEventGetData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarTestApp(
      title: 'Список пользователей',
      body: BlocConsumer(
        bloc: _usersBloc,
        listener: (context, state) {
          if (state is UsersBlocStateError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
          if (state is UsersBlocStateGoUserDetails) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) =>
                    UserDetailsBloc(context.read<DataProvider>()),
                child: const UserDetailsScreen(),
              );
            }));
          }
        },
        builder: (context, state) {
          if (state is UsersBlocStateInitial) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.grey,
              ),
            );
          }
          return ListView.builder(
              itemCount: _usersBloc.users.length,
              itemBuilder: (context, index) {
                return Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
                    child: ItemWidgetCard(
                      onTap: () {
                        _usersBloc
                            .add(GetUserBlocEvent(_usersBloc.users[index].id));
                      },
                      title: _usersBloc.users[index].userName,
                      subtitle: _usersBloc.users[index].name,
                    ));
              });
        },
      ),
    );
  }
}
