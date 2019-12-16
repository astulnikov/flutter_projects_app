import 'package:equatable/equatable.dart';
import 'package:projects_app/model/Project.dart';

abstract class ProjectDetailsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Load extends ProjectDetailsEvent {
  final Project project;

  Load(this.project);
}
