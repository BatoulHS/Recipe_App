import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:material_duration_picker/material_duration_picker.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key});

  @override
  State<NewRecipe> createState() {
    return _NewRecipeState();
  }
}

class _NewRecipeState extends State<NewRecipe> {
  final _notesController = TextEditingController();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  final List<String> _ingredients = [];
  final _ingredientsController = TextEditingController();


  void _addIngredient() {
    // TODO:  ingredients: _ingredients.join('|'),
    if (_ingredientsController.text.trim().isNotEmpty) {
      setState(() {
        _ingredients.add(_ingredientsController.text.trim());
        _ingredientsController.clear();
      });
    }
  }

  void _removeIngredient(int index) {
    setState(() {
      _ingredients.removeAt(index);
    });
  }

  final List<String> _instructions = [];
  final _instructionsController = TextEditingController();

  void _addInstruction() {
    // TODO:  instructions: _instructions.join('|'),
    if (_instructionsController.text.trim().isNotEmpty) {
      setState(() {
        _instructions.add(_instructionsController.text.trim());
        _instructionsController.clear();
      });
    }
  }

  void _removeInstruction(int index) {
    setState(() {
      _instructions.removeAt(index);
    });
  }

  var _selectedCategory = Category.breakfast;

  var _selectedDifficulty = Difficulty.easy;

  Duration? _selectedDuration;

  void _showDurationPicker() async {
    var pickedDuration = await showDurationPicker(
      durationPickerMode: DurationPickerMode.hm,
      context: context,
      initialEntryMode: DurationPickerEntryMode.input,
    );
    setState(() {
      _selectedDuration = pickedDuration;
    });
  }

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '$hours:$minutes';
  }

  File? _pickedImage; 
  final ImagePicker _picker = ImagePicker(); 

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _pickedImage = File(pickedFile.path); 
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to pick image: ${e.toString()}')),
      );
    }
  }

  // Future<String?> _saveImagePermanently(File? imageFile) async {
  //   if (imageFile == null) return null;

  //   final appDir = await getApplicationDocumentsDirectory();
  //   final fileName = 'recipe_${DateTime.now().millisecondsSinceEpoch}.jpg';
  //   final savedImage = await imageFile.copy('${appDir.path}/$fileName');

  //   return savedImage
  //       .path; // Returns path like: "/data/user/0/com.example.app/files/recipe_123456.jpg"
  // }

  // void _pickImage(ImageSource source) async {
  //   final XFile? pickedFile = await _picker.pickImage(source: source);
  //   if (pickedFile != null) {
  //     final permanentPath = await _saveImagePermanently(File(pickedFile.path));
  //     setState(() => _imagePath = permanentPath); // Store path in state
  //   }
  // }

  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text("Gallery"),
                onTap: () {
                  _pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_sharp)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => _showImageSourceDialog(context),
                child: Container(
                  width: 250,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                    image:
                        _pickedImage !=
                                null // Show selected image if exists
                            ? DecorationImage(
                              image: FileImage(_pickedImage!),
                              fit: BoxFit.cover,
                            )
                            : null,
                  ),
                  child:
                      _pickedImage == null
                          ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 50,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Add Photo",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )
                          : null,
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _nameController,
              // maxLength: 50,
              decoration: InputDecoration(label: Text("Recipe Name")),
            ),

            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Category:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 10),
                DropdownButton(
                  value: _selectedCategory,
                  items:
                      Category.values
                          .map(
                            (category) => DropdownMenuItem(
                              value: category,
                              child: Text(category.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  "Difficulty:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(width: 10),
                DropdownButton(
                  value: _selectedDifficulty,
                  items:
                      Difficulty.values
                          .map(
                            (difficulty) => DropdownMenuItem(
                              value: difficulty,
                              child: Text(difficulty.name.toUpperCase()),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedDifficulty = value;
                    });
                  },
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  _selectedDuration == null
                      ? "No Selected Duration"
                      : _formatDuration(_selectedDuration!),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: _showDurationPicker,
                  icon: Icon(Icons.timer_outlined),
                ),
              ],
            ),
            Text(
              "Ingredients:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(
                labelText: "Add Ingredient",
                suffixIcon: IconButton(
                  onPressed: _addIngredient,
                  icon: const Icon(Icons.add),
                ),
                hintText: 'e.g. 2 cups flour',
              ),
              onSubmitted: (_) => _addIngredient(),
            ),
            // SizedBox(height: 6,),
            ListView.builder(
              padding: EdgeInsets.zero,
              // itemExtent: 24,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _ingredients.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 10,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  leading: const Icon(Icons.circle, size: 8),
                  title: Text(_ingredients[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => _removeIngredient(index),
                  ),
                );
              },
            ),
            SizedBox(height: 20,),
            Text(
              "Instructions:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(
                labelText: "Add Instruction",
                suffixIcon: IconButton(
                  onPressed: _addInstruction,
                  icon: const Icon(Icons.add),
                ),
                hintText: 'e.g. add the flour',
              ),
              onSubmitted: (_) => _addInstruction(),
            ),
            // SizedBox(height: 6,),
            ListView.builder(
              padding: EdgeInsets.zero,
              // itemExtent: 24,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _instructions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  minLeadingWidth: 10,
                  contentPadding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  leading: const Icon(Icons.circle, size: 8),
                  title: Text(_instructions[index]),
                  trailing: IconButton(
                    icon: const Icon(Icons.close, size: 18),
                    onPressed: () => _removeInstruction(index),
                  ),
                );
              },
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: "Notes",
              ),
              maxLines: null,
               keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Cancel"),)),
                SizedBox(width:15,),
                Expanded(child: ElevatedButton(onPressed: (){}, child: Text("Save"))),
              ],
            )
          ],
        ),
      ),
    );
  }
}
