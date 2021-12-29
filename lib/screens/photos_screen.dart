import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/photos_bloc.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';

class PhotosScreen extends StatefulWidget {
  const PhotosScreen({Key? key}) : super(key: key);

  @override
  _PhotosScreenState createState() => _PhotosScreenState();
}

class _PhotosScreenState extends State<PhotosScreen> {
  late PhotosBloc _photosBloc;

  @override
  void didChangeDependencies() {
    _photosBloc = BlocProvider.of<PhotosBloc>(context);
    _photosBloc.add(PhotosBlocEventGetPhoto());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _photosBloc,
        builder: (context, state) {
          if (state is PhotosBlocStateInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return AppBarTestApp(
              title: 'Фото',
              body: PageView.builder(
                  itemCount: _photosBloc.photos.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 12.0, left: 16, right: 16),
                            child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Image.network(
                                    _photosBloc.photos[index].url!)),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 24.0, left: 16, right: 16),
                            child: Text(
                              _photosBloc.photos[index].title!,
                              style: Theme.of(context).textTheme.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    );
                  }));
        });
  }
}
