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
  var addRecipeAPI = "$secureAPI/recipe/createRecipe";
  var addReviewAPI = "$secureAPI/review/addReview";
  var getReviewsAPI = "$secureAPI/review/getRecipeReviews";
  var getChefInfoAPI = "$secureAPI/user/getChefData";
  var getRecipesByChefIdAPI = "$secureAPI/recipe/getRecipeByChefId";
  var upgradeToChefAPI = "$secureAPI/user/upgradeToChef";
  var getSpecialitiesAPI = "$publicAPI/chefSpeciality/getAllSpecialities";
  var addSpecialityLinkAPI = "$secureAPI/user/specificChefSpeciality/addLink";
  var getSpecialitiesForChef = "$secureAPI/user/specificChefSpeciality/getAllLinks";
  var followChefAPI = "$secureAPI/user/followChef";
  var unfollowChefAPI = "$secureAPI/user/unfollowChef";
  var getAllFollowersAPI = "$secureAPI/user/getAllFollowers";
  var getFollowStatsAPI = "$secureAPI/user/getFollowStats";
  var isFollowingAPI = "$secureAPI/follow/isFollowing";
  var getAllFollowingsAPI = "$secureAPI/user/getAllFollowing";
  var updateProfileImageAPI = "$secureAPI/user/updateImage";
  var saveFirebaseTokenAPI = "$secureAPI/deviceToken/save";
  var deleteFirebaseTokenAPI = "$secureAPI/deviceToken/deleteToken";
  Map<String, String> headers = {
     "Content-Type": "application/json; charset=UTF-8"
   };
  // Map<String, String> private_headers = {
  //   'Content-Type': 'application/json; charset=UTF-8',
  //   'Authorization': 'Bearer $token',
  // };

}