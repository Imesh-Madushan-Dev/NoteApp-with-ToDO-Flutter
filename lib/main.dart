import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/models/todo_model.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/theme_data.dart';

Future<void> main() async {
  
  //* Initialize Hive
  await Hive.initFlutter();

  //* Register Hive Adapters
  Hive.registerAdapter(NoteAdapter());
  Hive.registerAdapter(TodoAdapter());

  //* Open Hive Boxes
  await Hive.openBox<Note>('notes');
  await Hive.openBox<Todo>('todos');

   runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'NoteSphere',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.darkTheme.copyWith(
        textTheme: GoogleFonts.dmSansTextTheme(Theme.of(context).textTheme),
      ),
      routerConfig: AppRouter.router,
    );
  }
}
