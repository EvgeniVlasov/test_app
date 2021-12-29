import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/post_details_bloc.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/comment_widget.dart';
import 'package:flutter_test_app_eclipse/widgets/current_post_widget.dart';

class PostDetailsScreen extends StatefulWidget {
  const PostDetailsScreen({Key? key}) : super(key: key);

  @override
  _PostDetailsScreenState createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  late PostDetailsBloc _postDetailsBloc;
  List<Widget> contentComments = [];

  @override
  void didChangeDependencies() {
    _postDetailsBloc = BlocProvider.of<PostDetailsBloc>(context);
    _postDetailsBloc.add(PostDetailsBlocEventGetComments());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return AppBarTestApp(
      title: 'Детали поста',
      body: BlocConsumer(
        bloc: _postDetailsBloc,
        builder: (context, state) {
          if (state is PostDetailsBlocStateInitial) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          getCommentsContent();
          return ListView(
            padding: const EdgeInsets.only(top: 12, left: 16, right: 16),
            children: [
              CurrentPostWidget(
                title: _postDetailsBloc.currentPost.title!,
                body: _postDetailsBloc.currentPost.body!,
              ),
              Column(
                children: contentComments,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0, bottom: 12),
                child: TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                actions: [
                                  ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8))),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 12,
                                            bottom: 12,
                                            left: 24,
                                            right: 25),
                                        child: Text(
                                          'Отправить',
                                          style: Theme.of(context)
                                              .textTheme
                                              .button!
                                              .copyWith(color: Colors.white),
                                        ),
                                      )),
                                ],
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (text) {},
                                        decoration: const InputDecoration(
                                          labelText: 'Email',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (text) {},
                                          decoration: const InputDecoration(
                                            labelText: 'Имя',
                                            border: OutlineInputBorder(),
                                          )
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        onChanged: (text) {},
                                          decoration: const InputDecoration(
                                            labelText: 'Коментарий',
                                            border: OutlineInputBorder(),
                                          )
                                      ),
                                    ),
                                  ],
                                ));
                          });
                    },
                    child: Text(
                      'Оставить комментарий',
                      style: Theme.of(context)
                          .textTheme
                          .button!
                          .copyWith(color: Theme.of(context).primaryColor),
                    )),
              )
            ],
          );
        },
        listener: (BuildContext context, Object state) {},
      ),
    );
  }

  getCommentsContent() {
    contentComments = [];
    for (var comment in _postDetailsBloc.comments) {
      contentComments.add(Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: CommentWidget(
            body: comment.body!,
            email: comment.email!,
            name: comment.name!,
          )));
    }
  }
}
