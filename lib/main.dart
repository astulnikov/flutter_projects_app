import 'package:flutter/material.dart';
import 'package:projects_app/screens/project/details/ProjectDetailsScreen.dart';
import 'package:projects_app/screens/project/list/ProjectsScreen.dart';

import 'model/Project.dart';

void main() {
  runApp(HomeApp());
}

class HomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Projects App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        if (settings.name == ProjectDetailsScreen.routeName) {
          // Cast the arguments to the correct type: ScreenArguments.
          final Project project = settings.arguments;
          return MaterialPageRoute(
            builder: (context) {
              return ProjectDetailsScreen(project: project);
            },
          );
        } else if (settings.name == ProjectsScreen.routeName) {
          return MaterialPageRoute(
            builder: (context) {
              return ProjectsScreen();
            },
          );
        } else {
          return null;
        }
      },
      home: ProjectsScreen(),
    );
  }
}
