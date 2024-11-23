import 'package:flutter/material.dart';
import 'package:notes_sphere/helpers/snack_bar.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/service/note_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/router.dart';
import 'package:notes_sphere/utils/text_styles.dart';
import 'package:uuid/uuid.dart';

class CreateNewNotePage extends StatefulWidget {
  final bool isNewCategory;
  const CreateNewNotePage({super.key, required this.isNewCategory});

  @override
  State<CreateNewNotePage> createState() => _CreateNewNotePageState();
}

class _CreateNewNotePageState extends State<CreateNewNotePage> {
  List<String> categories = [];
  final NoteService noteService = NoteService();

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  final TextEditingController _noteCategoryController = TextEditingController();
  String category = '';

  @override
  void dispose() {
    _noteTitleController.dispose();
    _noteCategoryController.dispose();
    _noteContentController.dispose();
    super.dispose();
  }

  Future _loadCategories() async {
    // Load the categories
    categories = await noteService.getAllCategories();
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Create Note'),
        actions: [
          Padding(
            padding:
                const EdgeInsets.only(right: 8.0), // Add consistent padding
            child: TextButton(
              onPressed: () {
                // Add the action for the "Done" button

                if (_formKey.currentState!.validate()) {
                  try {
                    noteService.addNote(
                      Note(
                        title: _noteTitleController.text,
                        category: widget.isNewCategory
                            ? _noteCategoryController.text
                            : category,
                        content: _noteContentController.text,
                        date: DateTime.now(),
                        id: const Uuid().v4(),
                      ),
                    );
                    AppHelpers.showSnackBar(
                      context,
                      "Note Added Successfully",
                    );
                    _noteTitleController.clear();
                    _noteContentController.clear();

                    AppRouter.router.go('/');
                  } catch (e) {
                    AppHelpers.showSnackBar(
                      context,
                      e.toString(),
                    );
                  }
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.kFloatingButton, // Background color
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // Rounded corners
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.done,
                    color: AppColors.kWhiteColor,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "Done",
                    style: TextStyles.appButton,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                  horizontal: AppConstants.kDefaultPadiing / 2),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    widget.isNewCategory
                        ? Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: TextFormField(
                              controller: _noteCategoryController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please Enter a Category";
                                }
                                return null;
                              },
                              style: TextStyles.appButton,
                              decoration: InputDecoration(
                                hintText: 'New Category',
                                hintStyle: TextStyles.appButton.copyWith(
                                  color: AppColors.kWhiteColor.withOpacity(0.5),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          )
                        : DropdownButtonFormField<String>(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Select a Category";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Category',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            items: [
                              for (var category in categories)
                                DropdownMenuItem(
                                  value: category,
                                  child: Text(
                                    category,
                                    style: TextStyles.appButton,
                                  ),
                                ),
                            ],
                            onChanged: (String? value) {
                              setState(() {
                                category = value!;
                              });
                            },
                          ),
                    const SizedBox(height: 30),
                    //title field

                    TextFormField(
                      controller: _noteTitleController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter a Title";
                        }
                        return null;
                      },
                      maxLines: 2,
                      style: TextStyles.appTitle,
                      decoration: InputDecoration(
                        hintText: 'Note Title',
                        hintStyle: TextStyles.appTitle.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextFormField(
                      controller: _noteContentController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please Enter Content";
                        }
                        return null;
                      },
                      maxLines: 15,
                      style: TextStyles.appDescription,
                      decoration: InputDecoration(
                        hintText: 'Note Content',
                        hintStyle: TextStyles.appDescription.copyWith(
                          color: AppColors.kWhiteColor.withOpacity(0.5),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
