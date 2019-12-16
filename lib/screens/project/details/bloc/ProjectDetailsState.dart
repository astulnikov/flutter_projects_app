import 'package:equatable/equatable.dart';
import 'package:projects_app/model/Project.dart';

abstract class ProjectDetailsState extends Equatable {
  const ProjectDetailsState();

  @override
  List<Object> get props => [];
}

class ProjectUninitialized extends ProjectDetailsState {}

class ProjectError extends ProjectDetailsState {}

class ProjectLoaded extends ProjectDetailsState {
  final Project project;

  const ProjectLoaded({this.project});

  ProjectLoaded copyWith({
    Project project,
    bool hasReachedMax,
  }) {
    return ProjectLoaded(
      project: project ?? this.project,
    );
  }

  @override
  List<Object> get props => [project];

  @override
  String toString() => 'ProjectLoaded { projects: $project}';
}
