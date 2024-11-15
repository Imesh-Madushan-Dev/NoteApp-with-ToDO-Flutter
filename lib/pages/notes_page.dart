import 'package:flutter/material.dart';
import 'package:notes_sphere/models/note_model.dart';
import 'package:notes_sphere/service/note_service.dart';
import 'package:notes_sphere/utils/colors.dart';
import 'package:notes_sphere/utils/constants.dart';
import 'package:notes_sphere/utils/text_styles.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  final NoteService noteService = NoteService();
  List<Note> notes = []; // To store the loaded notes
  String? selectedCategory; // For tracking the selected category

  @override
  void initState() {
    super.initState();
    _checkIfUserIsNew();
  }

  // Check if the user is new and create initial notes if necessary
  void _checkIfUserIsNew() async {
    final bool isNewUser = await noteService.isNewUser();
    if (isNewUser) {
      await noteService.createInitialNotes();
      print('Initial notes created');
    }
    _loadNotes(); // Load the notes after checking
  }

  // Load the notes from the service
  void _loadNotes() async {
    final List<Note> loadedNotes = await noteService.loadNotes();
    setState(() {
      notes = loadedNotes; // Update the state with the loaded notes
    });
  }

  // Get unique categories from notes for filter options
  List<String> getCategories() {
    final categories = notes.map((note) => note.category).toSet().toList();
    categories.insert(0, 'All'); // Add 'All' as the first category
    return categories;
  }

  @override
  Widget build(BuildContext context) {
    // Filter notes based on selected category
    final displayedNotes =
        (selectedCategory == null || selectedCategory == 'All')
            ? notes
            : notes.where((note) => note.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: () {
          // Add new note logic here
        },
        backgroundColor: AppColors.kFloatingButton,
        child: const Icon(
          Icons.add,
          color: AppColors.kWhiteColor,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.kDefaultPadiing),
        child: notes.isEmpty
            ? const Center(
                child: Text(
                  'No notes available.',
                  // style: TextStyles.bodyText,
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Horizontal category filter
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      
                      children: getCategories().map((category) {
                        final isSelected = category == selectedCategory ||
                            (category == 'All' && selectedCategory == null);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = isSelected ? null : category;
                              if (category == 'All') {
                                selectedCategory =
                                    null; // Clear the filter when 'All' is selected
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.kFloatingButton
                                  : AppColors.kCardColor,
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Text(category, style: TextStyles.appButton),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  // Display filtered notes
                  Expanded(
                    child: ListView.builder(
                      itemCount: displayedNotes.length,
                      itemBuilder: (context, index) {
                        final note = displayedNotes[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            title: Text(
                              note.title,
                              // style: TextStyles.heading,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  note.category,
                                  // style: TextStyles.subHeading,
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  note.content,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  // style: TextStyles.bodyText,
                                ),
                              ],
                            ),
                            trailing: Text(
                              '${note.date.day}/${note.date.month}/${note.date.year}',
                              // style: TextStyles.bodyTextSmall,
                            ),
                            onTap: () {
                              // Navigate to note details
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
