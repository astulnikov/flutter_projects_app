import 'package:bloc/bloc.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsEvent.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsState.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  @override
  ProjectDetailsState get initialState => ProjectUninitialized();

  @override
  Stream<ProjectDetailsState> mapEventToState(ProjectDetailsEvent event) {
    if (event is Load) {
      return Stream.value(ProjectLoaded(project: event.project));
    } else {
      return Stream.value(ProjectError());
    }
  }
}
