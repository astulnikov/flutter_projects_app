import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_app/model/Project.dart';
import 'package:projects_app/screens/project/details/ProjectDetails.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsBloc.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsEvent.dart';

class ProjectDetailsScreen extends StatelessWidget {
  static const routeName = '/ProjectDetailsScreenRoute';
  final Project project;

  ProjectDetailsScreen({Key key, @required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => ProjectDetailsBloc()..add(Load(project)),
        child: ProjectDetails(),
      ),
    );
  }
}
