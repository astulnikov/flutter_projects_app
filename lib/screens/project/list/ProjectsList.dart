import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_app/model/Project.dart';
import 'package:projects_app/screens/project/details/ProjectDetailsScreen.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsBloc.dart';
import 'package:projects_app/screens/project/list/bloc/ProjectsState.dart';

class ProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectsBloc, ProjectsState>(
      builder: (context, state) {
        if (state is ProjectsUninitialized) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ProjectsError) {
          return Center(
            child: Text('failed to fetch projects'),
          );
        }
        if (state is ProjectsLoaded) {
          if (state.projects.isEmpty) {
            return Center(
              child: Text('no projects'),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
              ),
              itemCount: state.projects.length,
              itemBuilder: (context, index) {
                return ProjectItemWidget(project: state.projects[index]);
              },
            ),
          );
        } else {
          return Center(
            child: Text('failed to fetch projects'),
          );
        }
      },
    );
  }
}

class ProjectItemWidget extends StatelessWidget {
  final Project project;

  const ProjectItemWidget({Key key, this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped. ${project.id}');
          Navigator.pushNamed(
            context,
            ProjectDetailsScreen.routeName,
            arguments: project,
          );
        },
        child: Column(children: <Widget>[
          Image.network(project.coverImage),
          ListTile(
            title: Text(project.name, overflow: TextOverflow.ellipsis),
            subtitle:
                Text(project.description, overflow: TextOverflow.ellipsis),
          ),
        ]),
      ),
    );
  }
}
