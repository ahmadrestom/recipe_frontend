class BaseAPI {
  static String base = "http://10.0.2.2:8080";
  static var secureAPI = "$base/api/v2";
  static var publicAPI = "$base/api/v1";
  var authAPI = "$publicAPI/auth/authenticate";
  var registerAPI = "$publicAPI/auth/register";
  var recipeAPI = "$secureAPI/recipe/getAllRecipes";
  var newRecipesAPI = "$secureAPI/recipe/getRecentRecipes";
  var recipeByIdAPI = "$secureAPI/recipe/getRecipeById";
  var userInfoAPI = "$secureAPI/user/getUser";
  var getUserFavoriteRecipesAPI = "$secureAPI/user/getUserFavorites";
  var postUserFavoriteRecipeAPI = "$secureAPI/user/addFavoriteRecipe";
  var deleteUserFavoriteRecipeAPI = "$secureAPI/user/removeFavoriteRecipe";
  var getCategoriesAPI = "$publicAPI/category/getAllCategories";
  Map<String, String> headers = {
     "Content-Type": "application/json; charset=UTF-8"
   };
  // Map<String, String> private_headers = {
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': 'Bearer $token',
  // };

}