import 'package:equatable/equatable.dart';

abstract class ProjectsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProjects extends ProjectsEvent {}
