import 'package:equatable/equatable.dart';
import 'package:projects_app/model/Project.dart';

abstract class ProjectsState extends Equatable {
  const ProjectsState();

  @override
  List<Object> get props => [];
}

class ProjectsUninitialized extends ProjectsState {}

class ProjectsError extends ProjectsState {}

class ProjectsLoaded extends ProjectsState {
  final List<Project> projects;
  final bool hasReachedMax;

  const ProjectsLoaded({
    this.projects,
    this.hasReachedMax,
  });

  ProjectsLoaded copyWith({
    List<Project> projects,
    bool hasReachedMax,
  }) {
    return ProjectsLoaded(
      projects: projects ?? this.projects,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [projects, hasReachedMax];

  @override
  String toString() =>
      'ProjectsLoaded { projects: ${projects.length}, hasReachedMax: $hasReachedMax }';
}
