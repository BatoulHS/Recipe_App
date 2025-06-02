import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:material_duration_picker/material_duration_picker.dart';
import 'package:uuid/uuid.dart';

class NewRecipe extends StatefulWidget {
  const NewRecipe({super.key, required this.onSave, required this.onCancel});

  final Function(Recipe recipe) onSave;
  final Function() onCancel;

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

  bool _isFavorite = false;
  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  final List<String> _instructions = [];

  final _instructionsController = TextEditingController();

  void _addInstruction() {
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
    if (hours > 0) {
      return '$hours:${minutes.toString().padLeft(2, '0')}';
    } else {
      return '0:${minutes.toString().padLeft(2, '0')}';
    }
  }

 String? _imagePath;
 File? _pickedImage;

  final ImagePicker _picker = ImagePicker();

  Future<String?> _saveImagePermanently(File? imageFile) async {
    if (imageFile == null) return null;

    final appDir = await getApplicationDocumentsDirectory();
    final fileName = 'recipe_${const Uuid().v4()}.jpg'; // Ensure UUID is used here
    final savedImage = await imageFile.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }
  void _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source, maxWidth: 600); // Optional: resize
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      final permanentPath = await _saveImagePermanently(_pickedImage);
      setState(() {
        _imagePath = permanentPath;
      });
    }
  }


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

  void _addRecipe() {
    if (_nameController.text.trim().isEmpty ||
        _ingredients.isEmpty ||
        _instructions.isEmpty ||
        _pickedImage == null ||
        _selectedDuration == null) { // TODO: duration 0 => wrong
      showDialog(
        context: context,
        builder:
            (ctx) => AlertDialog(
              title: Text('Invalid Input'),
              content: Text(
                'Please make sure you enter the recipe name, ingredients, instructions, duration and a photo',
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Okay'),
                ),
              ],
            ),
      );
      return;
    }

    widget.onSave(
      Recipe(
        name: _nameController.text,
        ingredients: _ingredients.join('|'),
        instructions: _instructions.join('|'),
        duration: _selectedDuration!,
        category: _selectedCategory,
        difficulty: _selectedDifficulty,
        notes: _notesController.text,
        image: _imagePath!,
        isFavorite: _isFavorite,
      ),
    );

     ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Recipe Saved!'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Future<bool> _showCancelConfirmationDialog() async {
    return await showDialog<bool>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Discard changes?'),
              content: const Text(
                'Are you sure you want to discard this recipe?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('No'),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: const Text('Yes'),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _cancelRecipe() async {
    final shouldCancel = await _showCancelConfirmationDialog();
    if (shouldCancel && mounted) {
      widget.onCancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Recipe"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
              ),
              onPressed: _toggleFavorite,
            ),
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
                              child: Text(category.name[0].toUpperCase() + category.name.substring(1)),
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
                              child: Text(difficulty.name[0].toUpperCase() + difficulty.name.substring(1),),
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
            SizedBox(height: 20),
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
              decoration: InputDecoration(labelText: "Notes"),
              maxLines: null,
              keyboardType: TextInputType.multiline,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _cancelRecipe,
                    child: Text("Cancel"),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _addRecipe,
                    child: Text("Save"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
