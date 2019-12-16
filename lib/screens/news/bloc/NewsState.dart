import 'package:equatable/equatable.dart';
import 'package:projects_app/model/Post.dart';
import 'package:projects_app/model/Project.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsUninitialized extends NewsState {}

class NewsError extends NewsState {}

class NewsLoaded extends NewsState {
  final List<Post> posts;
  final bool hasReachedMax;

  const NewsLoaded({
    this.posts,
    this.hasReachedMax,
  });

  NewsLoaded copyWith({
    List<Project> projects,
    bool hasReachedMax,
  }) {
    return NewsLoaded(
      posts: projects ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [posts, hasReachedMax];

  @override
  String toString() =>
      'NewsLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
