import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_sphere/pages/home_page.dart';
import 'package:notes_sphere/pages/notes_page.dart';
import 'package:notes_sphere/pages/todo_page.dart';

class AppRouter {
  static final router = GoRouter(
      navigatorKey: GlobalKey<NavigatorState>(),
      debugLogDiagnostics: true,
      initialLocation: "/",
      routes: [
        //* home page
        GoRoute(
          name: "home",
          path: "/",
          builder: (context, state) {
            return const HomePage();
          },
        ),

        //* Notes page
        GoRoute(
          name: "notes",
          path: "/notesPage",
          builder: (context, state) {
            return const NotesPage();
          },
        ),
         
        //* Todo page
        GoRoute(
          name: "todo",
          path: "/todoPage",
          builder: (context, state) {
            return const TodoPage();
          },
        ),
      ]);
}
