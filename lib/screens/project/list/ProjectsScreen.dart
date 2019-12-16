import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_app/screens/project/list/ProjectsList.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsBloc.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsEvent.dart';

class ProjectsScreen extends StatelessWidget {
  static const routeName = '/ProjectsScreenRoute';

  ProjectsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Projects App'),
      ),
      body: BlocProvider(
        create: (context) => ProjectsBloc()..add(FetchProjects()),
        child: ProjectsList(),
      ),
    );
  }
}
