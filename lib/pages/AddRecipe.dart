import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/UserProvider.dart';
import 'package:recipe_app/models/NutritionalInformation.dart';
import 'package:recipe_app/models/Recipe.dart';
import 'package:recipe_app/models/category.dart';
import 'package:recipe_app/models/ingredients.dart';
import 'package:recipe_app/models/instruction.dart';
import 'package:recipe_app/services/Recipe%20Service.dart';
import '../Providers/RecipeProvider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class AddRecipe extends StatefulWidget {
  const AddRecipe({Key? key}) : super(key: key);

  @override
  AddRecipeState createState() => AddRecipeState();
}

class AddRecipeState extends State<AddRecipe> {
  late final List<Category> _categories;
  final _difficultyLevels = ['Easy', 'Medium', 'Hard'];
  Category? _selectedCategory;
  String? _selectedDifficulty;



  File? _recipeImage;
  File? _plateImage;
  final ImagePicker _picker = ImagePicker();
  final RecipeService recipeService = RecipeService();

  Future<void> _pickImage(Function(File) onImagePicked) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        onImagePicked(File(pickedFile.path));
      });
    }
  }

  Future<void> _submitRecipe()async{
    try{
      if(_recipeImage==null || _plateImage==null){
        throw Exception("Images are null");
      }else{
        print("Images picked successfully:  Recipe Image - $_recipeImage, Plate Image - $_plateImage");
      }
      if (_selectedCategory == null || _selectedDifficulty == null) {
        throw Exception("Category or difficulty level is not selected");
      }
      String? recipeImageUrl = await recipeService.uploadImage(
        _recipeImage!,
        'RecipeImages',
        path.basename(_recipeImage!.path),
      );
      print("Uploading Recipe Image...");
      String? plateImageUrl = await recipeService.uploadImage(
        _plateImage!,
        'PlateImages',
        path.basename(_plateImage!.path),
      );
      print("Uploading Plate Image...");
      if(recipeImageUrl==null || plateImageUrl==null) {
        throw Exception("ERROR: Image URLs are null");
      }
        if(!mounted) return;
      final userProvider = Provider.of<UserProvider>(context,listen: false);
      final chefId = userProvider.userDetails?['id'];

      NutritionalInformation ni = NutritionalInformation(
          calories: double.parse(_caloriesController.value.text),
          totalFat: double.parse(_totalFatController.value.text),
          cholesterol: double.parse(_cholesterolController.value.text),
          carbohydrates: double.parse(_carbohydratesController.value.text),
          protein: double.parse(_proteinController.value.text),
          sugar: double.parse(_sugarController.value.text),
          sodium: double.parse(_sodiumController.value.text),
          fiber: double.parse(_fiberController.value.text),
          zinc: double.parse(_zincController.value.text),
          magnesium: double.parse(_magnesiumController.value.text),
          potassium: double.parse(_potassiumController.value.text),
      );
      print("Nutrition Information: ${ni.toJson()}");
      final RecipePost recipe = RecipePost.name(
        _recipeNameController.value.text,
        _descriptionController.value.text,
        int.parse(_prepTimeController.value.text),
        int.parse(_cookTimeController.value.text),
        _selectedDifficulty!,
        3,  // Rating starts at 3 and then when people rate, it will be updated
        recipeImageUrl,
        plateImageUrl,
        _selectedCategory!.categoryId,
        chefId,
        ni,
        _ingredients,
        _instructions,
      );
      print("Recipe Object: ${recipe.toJson()}");
      final x = await RecipeService().uploadRecipe(recipe);
      print("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXxx $x");
    }catch(e){
      print("Could not submit recipe: $e");
      throw Exception("Could not submit recipe : $e");
    }
  }



  final TextEditingController _recipeNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _prepTimeController = TextEditingController();
  final TextEditingController _cookTimeController = TextEditingController();
  final Set<Ingredients> _ingredients = {};
  final List<Instruction> _instructions = [];
  final TextEditingController _caloriesController = TextEditingController();
  final TextEditingController _totalFatController = TextEditingController();
  final TextEditingController _cholesterolController = TextEditingController();
  final TextEditingController _carbohydratesController = TextEditingController();
  final TextEditingController _proteinController = TextEditingController();
  final TextEditingController _sugarController = TextEditingController();
  final TextEditingController _sodiumController = TextEditingController();
  final TextEditingController _fiberController = TextEditingController();
  final TextEditingController _zincController = TextEditingController();
  final TextEditingController _magnesiumController = TextEditingController();
  final TextEditingController _potassiumController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);
    _categories = recipeProvider.categoryList!;
    _categories.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create new Recipe',

        ),
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Recipe Name'),
                _buildTextField(_recipeNameController, 'Enter Recipe Name', validator: (value) {
                  if (value == null || value.isEmpty) return 'Recipe name is required';
                  return null;
                }),

                _buildSectionTitle('Description'),
                _buildTextField(_descriptionController, 'Enter Description', maxLines: 3, validator: (value) {
                  if (value == null || value.isEmpty) return 'Description is required';
                  return null;
                }),

                _buildSectionTitle('Preparation Time'),
                _buildTextField(_prepTimeController, 'Enter Prep Time (mins)', keyboardType: TextInputType.number, validator: (value) {
                  if (value == null || value.isEmpty) return 'Preparation time is required';
                  return null;
                }),

                _buildSectionTitle('Cooking Time'),
                _buildTextField(_cookTimeController, 'Enter Cook Time (mins)', keyboardType: TextInputType.number, validator: (value) {
                  if (value == null || value.isEmpty) return 'Cooking time is required';
                  return null;
                }),

                _buildSectionTitle('Recipe Image'),
                _rowImagePicker(
                  label: 'Select Recipe Image',
                  image: _recipeImage,
                  onPick: () => _pickImage((file) => _recipeImage = file),
                ),
                const SizedBox(height: 10),
                _buildSectionTitle('Plate Image'),
                _rowImagePicker(
                  label: 'Select Plate Image',
                  image: _plateImage,
                  onPick: () => _pickImage((file) => _plateImage = file),
                ),
                _buildSectionTitle('Difficulty Level'),
                _buildDropdown2(_difficultyLevels, 'Select Difficulty Level', (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                }),

                _buildSectionTitle('Category'),
                _buildDropdown(_categories, 'Select Category', (value) {
                  setState(() {
                    _selectedCategory = _categories.firstWhere((category) => category.categoryName == value);
                  });
                }),

                _buildSectionTitle('Ingredients'),
                ..._ingredients.map((ingredient) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text('${ingredient.name} - ${ingredient.grams} grams'),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _ingredients.remove(ingredient);
                          });
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 10),
                _buildAddButton('Add Ingredient', () {
                  _showIngredientDialog();
                }),

                _buildSectionTitle('Instructions'),
                ..._instructions.asMap().entries.map((entry) {
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      title: Text('Step ${entry.key + 1}: ${entry.value.instruction}'),
                      trailing: const Icon(Icons.delete, color: Colors.red),
                      onTap: () {
                        setState(() {
                          _instructions.removeAt(entry.key);
                        });
                      },
                    ),
                  );
                }),
                const SizedBox(height: 10),
                _buildAddButton('Add Instruction', () {
                  _showInstructionDialog();
                }),

                _buildSectionTitle('Nutrition Information'),
                _buildNutritionFields(),

                const SizedBox(height: 30),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color(0xFF00796B),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, TextInputType keyboardType = TextInputType.text, String? Function(String?)? validator}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF00796B)),
          ),
        ),
        validator: validator,
      ),
    );
  }

  Widget _buildDropdown(List<Category> items, String hint, Function(String?) onChanged){
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        hint: Text(hint),
        value: null,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem(value: item.categoryName, child: Text(item.categoryName));
        }).toList(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF00796B)),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown2(List<String> items, String hint, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownButtonFormField<String>(
        hint: Text(hint),
        value: null,
        onChanged: onChanged,
        items: items.map((item) {
          return DropdownMenuItem(value: item, child: Text(item));
        }).toList(),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Color(0xFF00796B)),
          ),
        ),
      ),
    );
  }

  Widget _buildAddButton(String label, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: const Icon(Icons.add),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white, backgroundColor: const Color(0xFF00796B),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildNutritionFields() {
    final nutritionFields = [
      _buildTextField(_caloriesController, 'Calories (kcal)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid calories are required';
        return null;
      }),
      _buildTextField(_totalFatController, 'Total Fat (g)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Total Fat is required';
        return null;
      }),
      _buildTextField(_cholesterolController, 'Cholesterol (mg)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Cholesterol is required';
        return null;
      }),
      _buildTextField(_carbohydratesController, 'Carbohydrates (g)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Carbohydrates are required';
        return null;
      }),
      _buildTextField(_proteinController, 'Protein (g)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Protein is required';
        return null;
      }),
      _buildTextField(_sugarController, 'Sugar (g)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Sugar is required';
        return null;
      }),
      _buildTextField(_sodiumController, 'Sodium (mg)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Sodium is required';
        return null;
      }),
      _buildTextField(_fiberController, 'Fiber (g)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Fiber is required';
        return null;
      }),
      _buildTextField(_zincController, 'Zinc (mg)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Zinc is required';
        return null;
      }),
      _buildTextField(_magnesiumController, 'Magnesium (mg)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Magnesium is required';
        return null;
      }),
      _buildTextField(_potassiumController, 'Potassium (mg)', keyboardType: TextInputType.number, validator: (value) {
        if (value == null || value.isEmpty || double.tryParse(value) == null) return 'Valid Potassium is required';
        return null;
      }),
    ];

    return Column(children: nutritionFields);
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            await _submitRecipe();
            if(mounted) {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Recipe added successfully!')),
              );

            }// Navigate back to the home page
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF00796B),
          //padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: const Text(
            'Submit Recipe',
          style: TextStyle(
            color: Colors.white
          ),
        ),
      ),
    );
  }

  void _showIngredientDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final ingredientNameController = TextEditingController();
        final ingredientGramsController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Ingredient'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(ingredientNameController, 'Ingredient Name'),
              _buildTextField(ingredientGramsController, 'Ingredient Grams (g)', keyboardType: TextInputType.number),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (ingredientNameController.text.isNotEmpty && ingredientGramsController.text.isNotEmpty) {
                  setState(() {
                    _ingredients.add(Ingredients(ingredientNameController.text, int.parse(ingredientGramsController.text)));
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _rowImagePicker({required String label, required File? image, required VoidCallback onPick}) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPick,
          icon: const Icon(Icons.image),
          label: Text(label),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: const Color(0xFF00796B),
          ),
        ),
        if (image != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Image.file(image, height: 150, width: 150, fit: BoxFit.cover),
          ),
      ],
    );
  }


  void _showInstructionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final instructionController = TextEditingController();

        return AlertDialog(
          title: const Text('Add Instruction'),
          content: _buildTextField(instructionController, 'Instruction', maxLines: 3),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _instructions.add(Instruction(
                      instructionController.value.text,
                      _instructions.length+1
                  ));
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
