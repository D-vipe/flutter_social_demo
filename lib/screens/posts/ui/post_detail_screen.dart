import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_demo/app/config/route_arguments/route_arguments.dart';
import 'package:flutter_social_demo/screens/posts/bloc/posts_cubit.dart';

class PostDetailScreen extends StatelessWidget {
  final PostDetailArguments arguments;
  const PostDetailScreen({Key? key, required this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PostsCubit(),
      child: PostDetailView(
        id: arguments.id,
      ),
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
  @override
  void initState() {
    super.initState();

    // context.read<PostsCubit>().getDetail(id: widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
