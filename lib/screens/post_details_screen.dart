import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_app_eclipse/blocs/post_details_bloc.dart';
import 'package:flutter_test_app_eclipse/widgets/appbar_test_app.dart';
import 'package:flutter_test_app_eclipse/widgets/comment_widget.dart';
import 'package:flutter_test_app_eclipse/widgets/current_post_widget.dart';
import 'package:flutter_test_app_eclipse/widgets/dialog_send_comment_widget.dart';

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
    getCommentsContent();
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
                            return DialogSendCommentWidget(
                              onChangeMail: (String text) {
                                _postDetailsBloc.fieldInputMail = text;
                              },
                              onPress: () {
                                _postDetailsBloc
                                    .add(PostDetailsBlocEventSendComment());
                                Navigator.pop(context);
                              },
                              onChangeBody: (String text) {
                                _postDetailsBloc.fieldInputBody = text;
                              },
                              onChangeName: (String text) {
                                _postDetailsBloc.fieldInputName = text;
                              },
                            );
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
        listener: (BuildContext context, Object state) {
          if (state is PostDetailsBlocStateSendCommentIsSuccess) {
            List<Widget> yoursComments = [];
            for (var yourComment in _postDetailsBloc.yourComments) {
              yoursComments.add(Padding(
                  padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
                  child: CommentWidget(
                    body: yourComment.body!,
                    email: yourComment.mail!,
                    name: yourComment.name!,
                  )));
            }

            setState(() {
              contentComments.addAll(yoursComments);
            });
          }
        },
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
