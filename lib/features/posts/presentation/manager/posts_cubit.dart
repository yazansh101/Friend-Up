import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit() : super(PostsInitial());
}
