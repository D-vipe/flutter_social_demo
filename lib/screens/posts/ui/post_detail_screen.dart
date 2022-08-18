// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:flutter_social_demo/app/config/route_arguments/detail_page_arguments.dart';
import 'package:flutter_social_demo/app/constants/app_decorations.dart';
import 'package:flutter_social_demo/app/constants/app_dictionary.dart';
import 'package:flutter_social_demo/app/constants/errors_const.dart';
import 'package:flutter_social_demo/app/theme/text_styles.dart';
import 'package:flutter_social_demo/app/uikit/card_row.dart';
import 'package:flutter_social_demo/app/uikit/empty_result.dart';
import 'package:flutter_social_demo/app/uikit/error_page.dart';
import 'package:flutter_social_demo/app/uikit/loader_page.dart';
import 'package:flutter_social_demo/api/models/models.dart';
import 'package:flutter_social_demo/screens/posts/bloc/posts_cubit.dart';
import 'package:flutter_social_demo/screens/posts/ui/widgets/bottom_sheet_form.dart';

class PostDetailScreen extends StatelessWidget {
  final DetailPageArgument arguments;
  const PostDetailScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PostDetailView(
      id: arguments.id,
    );
  }
}

class PostDetailView extends StatefulWidget {
  final int id;
  const PostDetailView({Key? key, required this.id}) : super(key: key);

  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView> {
  Future _showForm() {
    return showModalBottomSheet<void>(
        isScrollControlled: true,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        builder: (BuildContext context) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              height: 460,
              decoration: AppDecorations.roundedBox,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    width: 40,
                    decoration: AppDecorations.roundedBox.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                    height: 1,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    height: 40,
                    decoration: AppDecorations.roundedBox,
                    child: Text(
                      AppDictionary.comment,
                      style: AppTextStyle.comforta16W600.apply(
                          color: Theme.of(context).colorScheme.onBackground),
                    ),
                  ),
                  const SizedBox(height: 10),
                  BottomSheetForm(
                    sendForm: sendForm,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void sendForm(String name, String email, String comment) {
    context.read<PostsCubit>().addComment(
          postId: widget.id,
          name: name,
          email: email,
          comment: comment,
        );
  }

  @override
  void initState() {
    super.initState();

    context.read<PostsCubit>().getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostsCubit, PostsState>(builder: (context, state) {
      final bool receivedState = state is PostDetailReceived;
      final bool loadingState = state is PostRequested;
      final bool errorState = state is PostError;
      String errorMessage = '';
      Post? post;

      if (errorState) {
        errorMessage = state.error;
      }
      if (receivedState) {
        post = state.data;
      }

      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: 50,
          centerTitle: true,
          title: Text(
            post != null ? post.title : AppDictionary.postDetailTitle,
          ),
          leading: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.chevron_left,
              size: 30,
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showForm();
          },
          child: const Icon(
            Icons.add,
          ),
        ),
        extendBody: true,
        body: Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                slivers: [
                  SliverList(
                      delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return receivedState
                          ? post != null
                              ? _DetailPostBody(
                                  body: post.body,
                                  title: post.title,
                                  comments: post.comments,
                                )
                              : const EmptyPage(
                                  message: GeneralErrors.emptyData)
                          : Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: loadingState
                                      ? const LoaderPage()
                                      : ErrorPage(
                                          message: errorMessage,
                                        ),
                                ),
                              ],
                            );
                    },
                    childCount: 1,
                  )),
                  const SliverPadding(
                    sliver: null,
                    padding: EdgeInsets.only(bottom: 25),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}

class _DetailPostBody extends StatelessWidget {
  final String title;
  final String body;
  final List<Comment>? comments;
  const _DetailPostBody({
    Key? key,
    required this.title,
    required this.body,
    this.comments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width - 30,
                child: Text(
                  title,
                  style: AppTextStyle.comforta18W700
                      .apply(color: Theme.of(context).colorScheme.primary),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            body,
            style: AppTextStyle.comforta14W400,
          ),
          const SizedBox(height: 20),
          (comments != null && (comments!.isNotEmpty))
              ? _PostComments(
                  comments: comments!,
                )
              : Container()
        ],
      ),
    );
  }
}

class _PostComments extends StatelessWidget {
  final List<Comment> comments;
  const _PostComments({Key? key, required this.comments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${AppDictionary.commentsTitle}: ',
          style: AppTextStyle.comforta14W400.apply(
            color: Theme.of(context).colorScheme.primary,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
        ),
        const SizedBox(height: 15),
        Column(
          children: List.generate(
              comments.length,
              (index) => _CommentCard(
                    name: comments[index].name,
                    email: comments[index].email,
                    body: comments[index].body,
                    index: index,
                  )),
        )
      ],
    );
  }
}

class _CommentCard extends StatelessWidget {
  final String name;
  final String email;
  final String body;
  final int index;
  const _CommentCard({
    Key? key,
    required this.name,
    required this.email,
    required this.body,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          (index % 2 == 0) ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 15),
          width: MediaQuery.of(context).size.width - 50,
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Column(
                crossAxisAlignment: (index % 2 == 0)
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CardRow(
                      title: AppDictionary.name,
                      value: name,
                      reduceWidth: 120,
                      valueStyle: AppTextStyle.comforta14W400,
                    ),
                  ),
                  const SizedBox(height: 10),
                  CardRow(
                    title: AppDictionary.email,
                    value: email,
                    valueStyle: AppTextStyle.comforta14W400,
                    reduceWidth: 126,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    body,
                    style: AppTextStyle.comforta14W400,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
