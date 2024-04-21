import 'package:recipe_app/customerWidgets/CategoryItem.dart';
import 'package:flutter/material.dart';
import '../models/recipe.dart' as recipe;
import '../models/recipe.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {

  late List<Recipe> recipes;

  String selectedCategory = '';


  final List<String> categories = recipe.Category.values
      .map((e) => e.toString().split('.').last)
      .map((category) => category.substring(0, 1).toUpperCase() + category.substring(1))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 30, right: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello Ahmad',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Color.fromRGBO(0, 0, 0, 1),
                          ),
                        ),
                        SizedBox(height: 6,),
                        Text(
                          'What are you cooking today?',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            fontSize: 11,
                            color: Color.fromRGBO(169, 169, 169, 1),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.amber
                      ),
                      child: Image.asset('assets/images/avatar.png'),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 30),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 255,
                      height: 40,
                      child: SearchBar(
                        hintText: 'Search',
                        leading: Image.asset('assets/icons/search.png'),
                      ),
                    ),
                    GestureDetector(
                      child: Image.asset(
                        'assets/icons/filter.png',
                        width: 45,
                        height: 45,
                      ),
                      onTap: (){
                        //////////////////////////////
                      },
                    )

                  ],
                ),
              ),

              const SizedBox(height: 25,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          itemCount: categories.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index){
                            return Container(
                              margin: const EdgeInsets.only(right: 7),
                              child: CategoryItem(
                                categoryName: categories[index],
                                selectedCategory: selectedCategory,
                                onCategorySelected: (category){
                                  setState(() {
                                    selectedCategory = category;
                                  });
                                },
                              ),
                            );
                        }
                                             ),
                      ),
                    ),
                  ],

                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40,horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: categories.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index){
                              return Container(
                                margin: const EdgeInsets.only(right: 7),
                                child: CategoryItem(
                                  categoryName: categories[index],
                                  selectedCategory: selectedCategory,
                                  onCategorySelected: (category){
                                    setState(() {
                                      selectedCategory = category;
                                    });
                                  },
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

