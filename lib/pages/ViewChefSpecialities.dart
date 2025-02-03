import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/models/chef_speciality.dart';

class ViewChefSpecialities extends StatelessWidget {
  const ViewChefSpecialities({super.key, required this.chefId, required this.name});
  final String chefId;
  final String name;


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    List<ChefSpeciality>? list;

    final ChefSpecialityProvider provider = Provider.of<ChefSpecialityProvider>(context, listen:false);
    provider.getSpecialitiesForChef(chefId);
    list = provider.specialitiesForChef;



    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight *0.03, horizontal: screenWidth*0.05),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    size: 27,
                    color: Color.fromRGBO(41, 45, 50, 1),
                  ),
                ),
                Text(
                    "$name's Specialities",
                  style: GoogleFonts.aleo(
                    fontSize: screenWidth*0.05,
                    fontStyle: FontStyle.italic
                  ),
                ),
                Container(width: screenWidth*0.08,),
              ],
            ),
            SizedBox(height: screenHeight*0.03,),
            Consumer<ChefSpecialityProvider>(
              builder: (context, provider, child) {
                if (provider.specialitiesForChef == null || provider.specialitiesForChef!.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                List<ChefSpeciality> list = provider.specialitiesForChef!;

                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(color: Colors.deepPurple.shade100, width: 1),
                        ),
                        elevation: 5,
                        shadowColor: Colors.deepPurple.withOpacity(0.3),
                        child: Column(
                          children: [
                            ListTile(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), // Increased padding
                              leading: const Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 30.0,
                              ),
                              title: Text(
                                list[index].speciality,
                                style: const TextStyle(
                                  fontSize: 22.0, // Larger font size for the text
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(18, 149, 117, 1),
                                ),
                              ),
                              trailing: const Icon(
                                Icons.arrow_drop_down,
                                color: Color.fromRGBO(18, 149, 117, 1),
                              ),
                              onTap: () {
                                // Add your tap behavior here
                              },
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              padding: const EdgeInsets.all(16.0),
                              height: screenHeight*0.1,
                              child: Text(
                                list[index].description,
                                style: const TextStyle(color: Color.fromRGBO(18, 149, 117, 0.7)),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
