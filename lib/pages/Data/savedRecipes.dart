import 'package:recipe_app/models/helpingModels/ingredients.dart';

import '../../models/recipe.dart';
import './Chefs.dart' as chefs;
List<Recipe> savedRecipes =[
  Recipe(
    id: 1,
    name: "Classic Greek Salad",
    description: "Indulge in the refreshing flavors of the Mediterranean with our Classic Greek Salad, featuring crisp cucumbers, juicy tomatoes, Kalamata olives, and creamy feta cheese, all tossed in a zesty Greek dressing.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Ripe tomatoes, chopped", 200),
      Ingredients("Cucumber, sliced", 150),
      Ingredients("Red onion, thinly sliced", 100),
      Ingredients("Kalamata olives, pitted", 50),
      Ingredients("Feta cheese, crumbled", 100),
      Ingredients("Extra virgin olive oil", 20),
      Ingredients("Red wine vinegar", 30),
      Ingredients("Fresh lemon juice", 15),
      Ingredients("Dried oregano", 5),
      Ingredients("Salt and black pepper, to taste", 20),
    ],
    instructions: [
      'In a large bowl, combine chopped ripe tomatoes, sliced cucumber, thinly sliced red onion, and pitted Kalamata olives.',
      'Crumble feta cheese over the salad ingredients.',
      'In a small bowl, whisk together extra virgin olive oil, red wine vinegar, fresh lemon juice, dried oregano, salt, and black pepper to make the dressing.',
      'Drizzle the dressing over the salad and toss gently to coat all the ingredients.',
      'Serve immediately as a refreshing side dish or light meal.',
    ],
    preparationTime: const Duration(minutes: 15),
    cookingTime: const Duration(minutes: 0),
    difficultyLevel: DifficultyLevel.easy,
    category: Category.vegan,
    rating: 4.5,
    plateImageUrl: "assets/images/ClassicGreekSalad.png",
    imageUrl: "assets/images/ChineseStyleEggFriedRiceWithSlicedPorkFillet.png",
    chef: chefs.Chefs[1],
  ),
  Recipe(
    id: 2,
    name: "Crunchy Nut Coleslaw",
    description: "A refreshing and crunchy coleslaw with a nutty twist, perfect for picnics and barbecues.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Cabbage, shredded", 250),
      Ingredients("Carrots, grated", 200),
      Ingredients("Green onions, thinly sliced", 100),
      Ingredients("Roasted peanuts, chopped", 50),
      Ingredients("Mayonnaise", 100),
      Ingredients("Apple cider vinegar", 30),
      Ingredients("Honey", 20),
      Ingredients("Dijon mustard", 20),
      Ingredients("Salt and pepper, to taste", 0),
    ],
    instructions: [
      "In a large bowl, combine shredded cabbage, grated carrots, sliced green onions, and chopped roasted peanuts.",
      "In a small bowl, whisk together mayonnaise, apple cider vinegar, honey, Dijon mustard, salt, and pepper to make the dressing.",
      "Pour the dressing over the cabbage mixture and toss until well coated.",
      "Refrigerate for at least 30 minutes before serving to allow the flavors to meld.",
      "Serve chilled as a side dish or topping for sandwiches and burgers.",
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: Duration.zero,
    difficultyLevel: DifficultyLevel.easy,
    category: Category.vegan,
    nutritionalInformation: null,
    plateImageUrl: "assets/images/CrunchyNutColeslaw.png",
    imageUrl: "assets/images/SpiceRoastedChickenWithFlavoredRice.png",
    reviews:null,
    rating: 3.5,
    chef: chefs.Chefs[2],
  ),
  Recipe(
    id: 3,
    name: "Shrimp Chicken Andouille Sausage Jambalaya",
    description: "A spicy and flavorful one-pot dish originating from Louisiana, featuring shrimp, chicken, and Andouille sausage cooked with rice and Cajun seasonings.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Shrimp, peeled and deveined", 200),
      Ingredients("Chicken thighs, boneless and skinless, diced", 300),
      Ingredients("Andouille sausage, sliced", 150),
      Ingredients("Bell peppers, diced", 150),
      Ingredients("Onion, diced", 100),
      Ingredients("Celery, diced", 100),
      Ingredients("Garlic, minced", 20),
      Ingredients("Canned diced tomatoes", 400),
      Ingredients("Chicken broth", 250),
      Ingredients("Long-grain white rice", 300),
      Ingredients("Cajun seasoning blend", 20),
      Ingredients("Salt and pepper, to taste", 0),
    ],
    instructions: [
      "In a large Dutch oven or skillet, heat oil over medium-high heat.",
      "Add diced chicken thighs and sliced Andouille sausage, and cook until browned.",
      "Add diced onion, bell peppers, celery, and minced garlic, and sauté until vegetables are softened.",
      "Stir in canned diced tomatoes, chicken broth, long-grain white rice, and Cajun seasoning blend.",
      "Bring the mixture to a boil, then reduce heat to low, cover, and simmer for 20-25 minutes, or until rice is cooked and liquid is absorbed.",
      "Add peeled and deveined shrimp to the pot during the last 5 minutes of cooking, and cook until shrimp are pink and opaque.",
      "Season with salt and pepper to taste, and serve hot.",
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: const Duration(minutes: 30),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.seaFood,
    nutritionalInformation: null,
    //imageUrl: "assets/images/ShrimpChickenAndouilleSausageJambalaya.png",
    plateImageUrl: "assets/images/ClassicGreekSalad.png",
    imageUrl: "assets/images/LambChopsWithFruityCouscousAndMint.png",
    reviews: null,
    rating: 2,
    chef: chefs.Chefs[0],
  ),
  Recipe(
    id: 4,
    name: "Barbecue Chicken Jollof Rice",
    description: "A flavorful and aromatic one-pot rice dish cooked with barbecue chicken, tomatoes, and spices, originating from West Africa.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Chicken thighs, bone-in and skin-on", 400),
      Ingredients("Long-grain white rice", 300),
      Ingredients("Tomato paste", 100),
      Ingredients("Bell peppers, diced", 150),
      Ingredients("Onion, diced", 100),
      Ingredients("Garlic, minced", 20),
      Ingredients("Ginger, grated", 20),
      Ingredients("Scotch bonnet pepper, minced (optional for heat)", 10),
      Ingredients("Chicken broth", 250),
      Ingredients("Barbecue sauce", 150),
      Ingredients("Vegetable oil", 50),
      Ingredients("Salt and pepper, to taste", 0),
    ],
    instructions: [
      "Season chicken thighs with salt, pepper, and barbecue sauce, and let marinate for at least 30 minutes.",
      "In a large pot or Dutch oven, heat vegetable oil over medium-high heat.",
      "Add diced onion, bell peppers, minced garlic, grated ginger, and minced Scotch bonnet pepper (if using), and sauté until softened.",
      "Stir in tomato paste and cook for 2-3 minutes.",
      "Add long-grain white rice to the pot and toast for a few minutes, stirring constantly.",
      "Pour in chicken broth and stir to combine.",
      "Nestle seasoned chicken thighs into the rice mixture.",
      "Cover the pot, reduce heat to low, and simmer for 20-25 minutes, or until rice is cooked and chicken is tender.",
      "Serve hot, garnished with chopped fresh cilantro or parsley.",
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: const Duration(minutes: 50),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.grilledDishes,
    nutritionalInformation: null,
    //imageUrl: "assets/images/BarbecueChickenJollofRice.png",
    plateImageUrl: "assets/images/ClassicGreekSalad.png",
    imageUrl: "assets/images/TraditionalSpareRibsBaked.png",
    reviews: null,
    rating: 5.0,
    chef: chefs.Chefs[3],
  ),
  Recipe(
    id: 5,
    name: "Portuguese Piri Piri Chicken",
    description: "Um prato de frango picante e saboroso, temperado com molho Piri Piri, tradicional de Portugal.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Coxas de frango, com osso e pele", 500),
      Ingredients("Molho Piri Piri", 100),
      Ingredients("Limões", 200),
      Ingredients("Alho, picado", 30),
      Ingredients("Azeite", 50),
      Ingredients("Pimentão doce em pó", 10),
      Ingredients("Pimenta preta moída", 10),
      Ingredients("Sal", 10),
    ],
    instructions: [
      "Tempere as coxas de frango com alho picado, sumo de limão, sal, pimenta preta moída e pimentão doce em pó.",
      "Deixe marinar por pelo menos 1 hora na geladeira.",
      "Pré-aqueça o forno a 200°C.",
      "Coloque as coxas de frango numa assadeira e regue com azeite.",
      "Asse no forno pré-aquecido por 35-40 minutos, ou até que o frango esteja cozido e dourado.",
      "Sirva quente, acompanhado de batatas assadas ou salada."
    ],
    preparationTime: const Duration(minutes: 60),
    cookingTime: const Duration(minutes: 40),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.grilledDishes,
    nutritionalInformation: null,
    //imageUrl: "assets/images/PortuguesePiriPiriChicken.png",
    plateImageUrl: "assets/images/ClassicGreekSalad.png",
    imageUrl: "assets/images/TraditionalSpareRibsBaked.png",
    reviews: null,
    rating: 4,
    chef: chefs.Chefs[4],
  ),
  Recipe(
    id: 6,
    name: "Traditional Spare Ribs Baked",
    description: "Delicious and tender spare ribs baked to perfection with a traditional blend of spices and herbs.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Spare ribs", 1000),
      Ingredients("Brown sugar", 50),
      Ingredients("Paprika", 10),
      Ingredients("Garlic powder", 15),
      Ingredients("Onion powder", 15),
      Ingredients("Salt", 10),
      Ingredients("Black pepper", 5),
      Ingredients("Barbecue sauce", 100),
    ],

    instructions: [
      "Preheat oven to 300°F (150°C).",
      "In a small bowl, mix brown sugar, paprika, garlic powder, onion powder, salt, and black pepper to make the dry rub.",
      "Rub the dry rub mixture all over the spare ribs, covering them evenly.",
      "Place the spare ribs on a baking sheet lined with aluminum foil.",
      "Bake in the preheated oven for 2 to 2 1/2 hours, or until the ribs are tender and cooked through.",
      "During the last 30 minutes of baking, brush the ribs with barbecue sauce.",
      "Remove from the oven and let rest for a few minutes before serving.",
      "Serve hot with extra barbecue sauce on the side."
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: const Duration(minutes: 150),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.grilledDishes,
    plateImageUrl: "",
    imageUrl: "assets/images/TraditionalSpareRibsBaked.png",
    reviews: null,
    rating: 2,
    chef: chefs.Chefs[2],
  ),
  Recipe(
    id: 7,
    name: "Lamb Chops with Fruity Couscous and Mint",
    description: "Tender lamb chops served with a light and refreshing fruity couscous salad, topped with fresh mint leaves.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Lamb chops", 500),
      Ingredients("Couscous", 200),
      Ingredients("Dried apricots, chopped", 100),
      Ingredients("Dried cranberries", 100),
      Ingredients("Almonds, sliced", 50),
      Ingredients("Fresh mint leaves, chopped", 20),
      Ingredients("Lemon juice", 30),
      Ingredients("Olive oil", 30),
      Ingredients("Salt", 10),
      Ingredients("Black pepper", 5),
    ],
    instructions: [
      "Cook couscous according to package instructions.",
      "In a large bowl, combine cooked couscous, chopped dried apricots, dried cranberries, sliced almonds, chopped fresh mint leaves, lemon juice, olive oil, salt, and black pepper.",
      "Mix well until all ingredients are evenly distributed.",
      "Season lamb chops with salt and black pepper.",
      "Grill or pan-sear lamb chops until cooked to desired doneness.",
      "Serve lamb chops hot with a generous portion of fruity couscous salad on the side."
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: const Duration(minutes: 15),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.grilledDishes,
    plateImageUrl:"" ,
    imageUrl: "assets/images/LambChopsWithFruityCouscousAndMint.png",
    reviews: null,
    rating: 4.5,
    chef: chefs.Chefs[3],
  ),
  Recipe(
    id: 8,
    name: "Spice Roasted Chicken with Flavored Rice",
    description: "Juicy roasted chicken seasoned with aromatic spices, served with flavorful rice cooked with vegetables.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Whole chicken", 1000),
      Ingredients("Cumin powder", 10),
      Ingredients("Coriander powder", 10),
      Ingredients("Turmeric powder", 5),
      Ingredients("Cayenne pepper", 5),
      Ingredients("Garlic cloves, minced", 20),
      Ingredients("Ginger, grated", 15),
      Ingredients("Onion, diced", 100),
      Ingredients("Bell peppers, diced", 100),
      Ingredients("Carrots, diced", 100),
      Ingredients("Basmati rice", 200),
      Ingredients("Chicken broth", 300),
      Ingredients("Salt", 10),
      Ingredients("Black pepper", 5),
    ],
    instructions: [
      "Preheat oven to 375°F (190°C).",
      "In a small bowl, mix cumin powder, coriander powder, turmeric powder, cayenne pepper, minced garlic, grated ginger, salt, and black pepper to make the spice rub.",
      "Rub the spice rub all over the chicken, including under the skin.",
      "Place the chicken on a roasting pan and roast in the preheated oven for 1 to 1 1/2 hours, or until the chicken is cooked through and golden brown.",
      "Meanwhile, cook basmati rice according to package instructions, substituting chicken broth for water.",
      "In a separate pan, sauté diced onion, bell peppers, and carrots until softened.",
      "Mix cooked rice with sautéed vegetables and season with salt and black pepper to taste.",
      "Serve spice roasted chicken hot with flavored rice on the side."
    ],
    preparationTime: const Duration(minutes: 30),
    cookingTime: const Duration(minutes: 90),
    difficultyLevel: DifficultyLevel.medium,
    category: Category.grilledDishes,
    plateImageUrl: "",
    imageUrl: "assets/images/SpiceRoastedChickenWithFlavoredRice.png",
    reviews: null,
    rating: 3.5,
    chef: chefs.Chefs[0],
  ),
  Recipe(
    id: 9,
    name: "Chinese Style Egg Fried Rice with Sliced Pork",
    description: "A classic Chinese dish of fragrant egg fried rice tossed with tender slices of pork, vegetables, and savory seasonings.",
    timeUploaded: DateTime.now(),
    ingredients: [
      Ingredients("Cooked rice, chilled", 200),
      Ingredients("Pork loin, thinly sliced", 300),
      Ingredients("Eggs, beaten", 2),
      Ingredients("Carrots, diced", 100),
      Ingredients("Peas", 100),
      Ingredients("Green onions, chopped", 50),
      Ingredients("Garlic cloves, minced", 20),
      Ingredients("Soy sauce", 30),
      Ingredients("Oyster sauce", 30),
      Ingredients("Sesame oil", 10),
      Ingredients("Salt", 10),
      Ingredients("Black pepper", 5),
    ],

    instructions: [
      "In a wok or large skillet, heat oil over medium-high heat.",
      "Add thinly sliced pork loin and cook until browned and cooked through.",
      "Push the cooked pork to the side of the wok, then add beaten eggs to the empty space.",
      "Scramble the eggs until cooked, then mix with the cooked pork.",
      "Add diced carrots, peas, chopped green onions, and minced garlic to the wok.",
      "Stir-fry until vegetables are tender-crisp.",
      "Add chilled cooked rice to the wok and stir-fry until heated through.",
      "Season with soy sauce, oyster sauce, sesame oil, salt, and black pepper to taste.",
      "Continue to stir-fry until everything is well combined and heated through.",
      "Serve hot as a delicious main dish or side."
    ],
    preparationTime: const Duration(minutes: 20),
    cookingTime: const Duration(minutes: 15),
    difficultyLevel: DifficultyLevel.easy,
    category: Category.grilledDishes,
    plateImageUrl: "",
    imageUrl: "assets/images/ChineseStyleEggFriedRiceWithSlicedPorkFillet.png",
    reviews: null,
    rating: 2.5,
    chef: chefs.Chefs[4],
  ),

];

List<Recipe> getSavedRecipes(){
  return savedRecipes;
}