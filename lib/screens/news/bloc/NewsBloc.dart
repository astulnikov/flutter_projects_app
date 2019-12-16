import 'package:bloc/bloc.dart';
import 'package:projects_app/remote/ProjectsRepo.dart';
import 'package:projects_app/screens/news/bloc/NewsEvent.dart';
import 'package:projects_app/screens/news/bloc/NewsState.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  @override
  NewsState get initialState => NewsUninitialized();

  @override
  Stream<NewsState> mapEventToState(NewsEvent event) async* {
    final currentState = state;
    if (event is FetchNews && !_hasReachedMax(currentState)) {
      try {
        if (currentState is NewsUninitialized) {
          final news = await fetchNews(event.projectId, 0, 20);
          yield NewsLoaded(posts: news, hasReachedMax: false);
          return;
        }
        if (currentState is NewsLoaded) {
          final posts =
              await fetchNews(event.projectId, currentState.posts.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : NewsLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield NewsError();
      }
    }
  }

  bool _hasReachedMax(NewsState state) =>
      state is NewsLoaded && state.hasReachedMax;

  @override
  Stream<NewsState> transformEvents(
    Stream<NewsEvent> events,
    Stream<NewsState> Function(NewsEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<NewsEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }
}
