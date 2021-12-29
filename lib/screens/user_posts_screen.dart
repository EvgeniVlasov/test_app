import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/post_details_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/posts_bloc.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';
import 'package:flutter_test_app_eclipse/screens/post_details_screen.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/item_widget_card.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({Key? key}) : super(key: key);

  @override
  _UserPostsScreenState createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  late UserPostsBloc _userPostsBloc;

  @override
  void didChangeDependencies() {
    _userPostsBloc = BlocProvider.of<UserPostsBloc>(context);
    _userPostsBloc.add(UserPostsBlocEventGetData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
        bloc: _userPostsBloc,
        builder: (context, state) {
          if (state is UserPostsBlocInitialState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AppBarTestApp(
              title: 'Список постов',
              body: ListView.builder(
                  itemCount: _userPostsBloc.posts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: ItemWidgetCard(
                          onTap: () {
                            _userPostsBloc.add(UserPostsBlocGoPost(
                                _userPostsBloc.posts[index].id));
                          },
                          title: _userPostsBloc.posts[index].title!,
                          subtitle:
                              '${_userPostsBloc.posts[index].body!.substring(0, 35)}...'),
                    );
                  }));
        },
        listener: (context, state) {
          if (state is UserPostsBlocStateGoScreenPostDetails) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (context) =>
                    PostDetailsBloc(context.read<DataProvider>()),
                child: const PostDetailsScreen(),
              );
            }));
          }
        });
  }
}
