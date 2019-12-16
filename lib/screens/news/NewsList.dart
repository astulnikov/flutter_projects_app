import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:projects_app/screens/news/bloc/NewsBloc.dart';
import 'package:projects_app/screens/news/bloc/NewsState.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsBloc, NewsState>(builder: (context, state) {
      if (state is NewsUninitialized) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      if (state is NewsError) {
        return Center(
          child: Text('failed to load project'),
        );
      }
      if (state is NewsLoaded) {
        return Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.all(0.0),
                itemCount: state.posts.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ListTile(
                        title: Html(data: state.posts[index].status),
                        subtitle: Text(state.posts[index].updatedAt),
                      ),
                    ),
                  );
                }));
      } else {
        return Center(
          child: Text('failed to load project'),
        );
      }
    });
  }
}
