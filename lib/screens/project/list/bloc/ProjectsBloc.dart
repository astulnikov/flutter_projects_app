import 'package:bloc/bloc.dart';
import 'package:projects_app/remote/ProjectsRepo.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsEvent.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsState.dart';
import 'package:rxdart/rxdart.dart';

class ProjectsBloc extends Bloc<ProjectsEvent, ProjectsState> {
  @override
  ProjectsState get initialState => ProjectsUninitialized();

  @override
  Stream<ProjectsState> mapEventToState(ProjectsEvent event) async* {
    final currentState = state;
    if (event is FetchProjects && !_hasReachedMax(currentState)) {
      try {
        if (currentState is ProjectsUninitialized) {
          final projects = await fetchProjects(0, 20);
          yield ProjectsLoaded(projects: projects, hasReachedMax: false);
          return;
        }
        if (currentState is ProjectsLoaded) {
          final posts = await fetchProjects(currentState.projects.length, 20);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : ProjectsLoaded(
                  projects: currentState.projects + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield ProjectsError();
      }
    }
  }

  bool _hasReachedMax(ProjectsState state) =>
      state is ProjectsLoaded && state.hasReachedMax;

  @override
  Stream<ProjectsState> transformEvents(
    Stream<ProjectsEvent> events,
    Stream<ProjectsState> Function(ProjectsEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<ProjectsEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }
}
