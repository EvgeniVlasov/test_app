import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/posts_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/user_albums_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/user_details_bloc.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';
import 'package:flutter_test_app_eclipse/screens/user_albums_screen.dart';
import 'package:flutter_test_app_eclipse/screens/user_posts_screen.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/company_item_widget.dart';
import 'package:flutter_test_app_eclipse/widgets/info_widget.dart';
import 'package:flutter_test_app_eclipse/widgets/previer_widget_album.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({Key? key}) : super(key: key);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late UserDetailsBloc _userDetailsBloc;

  @override
  void didChangeDependencies() {
    _userDetailsBloc = BlocProvider.of<UserDetailsBloc>(context);
    _userDetailsBloc.add(UserDetailsBlocGetDataEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarTestApp(
        title: _userDetailsBloc.currentUser.userName,
        body: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, top: 12),
          child: ListView(
            children: [
              userInfo(),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: companyWidget(),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: addressUser(),
              ),
              postsAlbumsUserCards()
            ],
          ),
        ));
  }

  Widget postsAlbumsUserCards() {
    List<Widget> posts = [];
    List<Widget> albums = [];
    return BlocBuilder(
        bloc: _userDetailsBloc,
        builder: (context, state) {
          if (state is UserDetailsBlocDataFetchedState) {
            posts = [];
            albums = [];
            posts.add(Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('?????????? ????????????????????????',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
            ));
            albums.add(Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('?????????????? ????????????????????????',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(color: Colors.white)),
            ));
            for (var post in _userDetailsBloc.postsUser) {
              posts.add(Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: ListTile(
                    title: Text(post.title!),
                    subtitle: Text('${post.body!.substring(0, 35)}...'),
                  ),
                ),
              ));
            }
            for (var i = 0; i < _userDetailsBloc.albumsUser.length; i++) {
              albums.add(Padding(
                padding: const EdgeInsets.all(8.0),
                child: PreviewWidgetAlbum(
                  title: _userDetailsBloc.albumsUser[i].title!,
                  image: _userDetailsBloc
                      .previewPhotosForAlbumsCurrentUser[i].thumbnailUrl
                      .toString(),
                ),
              ));
            }
            posts.add(Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          UserPostsBloc(context.read<DataProvider>()),
                      child: const UserPostsScreen(),
                    );
                  }));
                },
                child: const Text('???????????????????? ?????????? ????????????????????????',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ),
            ));
            albums.add(Align(
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlocProvider(
                      create: (context) =>
                          UserAlbumsBloc(context.read<DataProvider>()),
                      child: const UserAlbumsScreen(),
                    );
                  }));
                },
                child: const Text('???????????????????? ?????????????? ????????????????????????',
                    style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline)),
              ),
            ));
            return Column(children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: posts,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 12),
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: Column(
                    children: albums,
                  ),
                ),
              ),
            ]);
          }
          return const Padding(
            padding: EdgeInsets.only(top: 24.0),
            child: Center(child: CircularProgressIndicator(color: Colors.blue)),
          );
        });
  }

  Widget companyWidget() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '????????????',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
            ),
            CompanyItemWidget(
                type: '????????????????',
                value: _userDetailsBloc.currentUser.userCompany.name),
            CompanyItemWidget(
                type: '????????????',
                value: _userDetailsBloc.currentUser.userCompany.catchPhrase),
            CompanyItemWidget(
                type: '????????????????????????',
                value: _userDetailsBloc.currentUser.userCompany.bs)
          ],
        ),
      ),
    );
  }

  Widget addressUser() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '?????????? ????????????????????????',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            InfoWidget(
                type: '????????????',
                value: _userDetailsBloc.currentUser.userAddress.zipCode),
            InfoWidget(
                type: '??????????',
                value: _userDetailsBloc.currentUser.userAddress.city),
            InfoWidget(
                type: '??????????',
                value: _userDetailsBloc.currentUser.userAddress.street),
            InfoWidget(
                type: '????????????????',
                value: _userDetailsBloc.currentUser.userAddress.suite),
            InfoWidget(
                type: '??????????????',
                value: _userDetailsBloc.currentUser.userAddress.geo.lng!),
            InfoWidget(
                type: '????????????',
                value: _userDetailsBloc.currentUser.userAddress.geo.lat!)
          ],
        ),
      ),
    );
  }

  Widget userInfo() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Theme.of(context).primaryColor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '?? ????????????????????????',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Colors.white),
            ),
            InfoWidget(
              type: '???????????? ??????',
              value: _userDetailsBloc.currentUser.name,
            ),
            InfoWidget(
                type: 'Email', value: _userDetailsBloc.currentUser.email),
            InfoWidget(
                type: '?????????? ????????????????',
                value: _userDetailsBloc.currentUser.phone),
            InfoWidget(
                type: '????????', value: _userDetailsBloc.currentUser.website),
          ],
        ),
      ),
    );
  }
}
