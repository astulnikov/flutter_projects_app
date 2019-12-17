import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:projects_app/screens/news/NewsList.dart';
import 'package:projects_app/screens/news/bloc/NewsBloc.dart';
import 'package:projects_app/screens/news/bloc/NewsEvent.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsBloc.dart';
import 'package:projects_app/screens/project/details/bloc/ProjectDetailsState.dart';
import 'package:projects_app/ui/LinkTextSpan.dart';

class ProjectDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProjectDetailsBloc, ProjectDetailsState>(
        builder: (context, state) {
      if (state is ProjectUninitialized) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is ProjectError) {
        return Center(
          child: Text('failed to load project'),
        );
      }
      if (state is ProjectLoaded) {
        return NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      state.project.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    background: Image.network(
                      state.project.coverImage,
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 16.0, 0, 4.0),
                    child: Text(
                      state.project.status,
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              state.project.description,
                            ),
                            Text(
                              "Lead client: ${state.project.clientLead}",
                            ),
                            Text(
                              "Company Lead: ${state.project.companyLead}",
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Homepage: ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                LinkTextSpan(
                                  url: state.project.url,
                                  text: state.project.url,
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ]),
                            ),
                          ]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 4.0),
                    child: Text(
                      "Team",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _createTeamWidgets(state.project.team),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 4.0),
                    child: Text(
                      "Latest Updates",
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  BlocProvider(
                    create: (context) =>
                        NewsBloc()..add(FetchNews(state.project.id)),
                    child: NewsList(),
                  ),
                ],
              )),
        );
      } else {
        return Center(
          child: Text('failed to load project'),
        );
      }
    });
  }

  List<Widget> _createTeamWidgets(List<String> teamList) {
    return new List<Widget>.generate(teamList.length, (int index) {
      return Text(teamList[index].toString());
    });
  }
}
