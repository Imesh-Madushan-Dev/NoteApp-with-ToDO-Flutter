import 'package:flutter/material.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:notes_sphere/widgets/notes_todo_card.dart';
import 'package:notes_sphere/widgets/progress_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'NoteSphere ',
            style: TextStyles.appTitle,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const ProgressCard(
                completedTask: 2,
                totalTask: 5,
              ),
              const SizedBox(
                height: AppConstants.kDefaultPadiing,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      // go to notes

                      AppRouter.router.push("/notesPage");
                    },
                    child: const NotesTodoCard(
                      icon: Icons.bookmark_add_outlined,
                      title: 'Notes',
                      description: '3 Notes',
                    ),
                  ),
                  const SizedBox(width: AppConstants.kDefaultPadiing),
                  GestureDetector(
                    onTap: () {
                      // go to notes
                      // AppRouter.router.go("/todoPage");
                      AppRouter.router.push("/todoPage");
                    },
                    child: const NotesTodoCard(
                      icon: Icons.today_outlined,
                      title: 'To-Do List',
                      description: '3 Tasks',
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.kDefaultPadiing),
                child: Row(
                  children: [
                    const Text(
                      "Today's Progress",
                      style: TextStyles.appSubTitle,
                    ),
                    const Spacer(),
                    Text(
                      "See All",
                      style: TextStyles.appButton
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
