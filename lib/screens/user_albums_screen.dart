import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/photos_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/user_albums_bloc.dart';
import 'package:flutter_test_app_eclipse/provides/data_provider.dart';
import 'package:flutter_test_app_eclipse/screens/photos_screen.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/item_widget_card.dart';

class UserAlbumsScreen extends StatefulWidget {
  const UserAlbumsScreen({Key? key}) : super(key: key);

  @override
  _UserAlbumsScreenState createState() => _UserAlbumsScreenState();
}

class _UserAlbumsScreenState extends State<UserAlbumsScreen> {
  late UserAlbumsBloc _userAlbumsBloc;

  @override
  void didChangeDependencies() {
    _userAlbumsBloc = BlocProvider.of<UserAlbumsBloc>(context);
    _userAlbumsBloc.add(UserAlbumsBlocEventGetData());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _userAlbumsBloc,
      listener: (BuildContext context, Object? state) {
        if (state is UserAlbumsBlocStateGoScreenPhotos) {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BlocProvider(
              create: (context) => PhotosBloc(context.read<DataProvider>()),
              child: const PhotosScreen(),
            );
          }));
        }
      },
      builder: (context, state) {
        if (state is UserAlbumsBlocInitialState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return AppBarTestApp(
            title: 'Список альбомов',
            body: ListView.builder(
                itemCount: _userAlbumsBloc.albumsUser.length,
                itemBuilder: (context, index) {
                  return Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 8),
                      child: ItemWidgetCard(
                        onTap: () {
                          _userAlbumsBloc.add(UserAlbumsBlocGoPhotos(
                              _userAlbumsBloc.albumsUser[index].id));
                        },
                        title: _userAlbumsBloc.albumsUser[index].title!,
                        subtitle: '',
                      ));
                }));
      },
    );
  }
}
