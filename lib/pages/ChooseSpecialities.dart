import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import 'package:recipe_app/pages/NavPage.dart';
import 'package:recipe_app/pages/home.dart';
import '../customerWidgets/background_design_screen.dart';

class ChooseSpecialities extends StatefulWidget {
  const ChooseSpecialities({super.key, required this.chefId});
  final String chefId;

  @override
  State<ChooseSpecialities> createState() => _ChooseSpecialitiesState();
}

class _ChooseSpecialitiesState extends State<ChooseSpecialities> {
  int counter = 0;

  Set<ChefSpeciality>? chefSpecialities;
  Set<ChefSpeciality> selectedSpecialities = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
      await _fetchData();
    });
  }

  Future<void> _fetchData() async {
    final specialityProvider = Provider.of<ChefSpecialityProvider>(context, listen: false);
    await specialityProvider.fetchAllSpecialities();
    setState(() {
      chefSpecialities = specialityProvider.specialities;
    });
  }

  Future<void> _addLinks(Set<ChefSpeciality> selectedSpecialities) async {
    final specialityProvider = Provider.of<ChefSpecialityProvider>(context, listen: false);
    for (var speciality in selectedSpecialities) {
      try {
        await specialityProvider.addSpecialityLink(widget.chefId, speciality.specialityId);
      } catch (e) {
        print("Error adding speciality link for chefId: ${widget.chefId}, specialityId: ${speciality.specialityId}. Error: $e");
      }
    }
  }


  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    if(chefSpecialities==null){
      return Center(child: Lottie.asset(
          'assets/loader.json'
      ));
    }

    return Scaffold(
      body: Stack(
        children:[
          BackgroundDesign(),
        Padding(
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
                      "$counter/7",
                    style: GoogleFonts.baloo2(
                      fontSize: screenWidth*0.07,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(18, 149, 117, 0.8),

                    ),
                  ),
                  Container(width: screenWidth*0.01,)
                ],
              ),
              SizedBox(height: screenHeight*0.02,),
              Center(
                child: Text(
                    "Choose your specialities",
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth*0.06
                  ),
                ),
              ),
              SizedBox(height: screenHeight*0.02,),
              Expanded(
                child: chefSpecialities!.isEmpty
                    ? Center(child: Text("XX"))
                    : MultiSelectContainer(
                  maxSelectableCount: 7,
                  alignments: const MultiSelectAlignments(mainAxisAlignment: MainAxisAlignment.center),
                    suffix: MultiSelectSuffix(
                        selectedSuffix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 14,
                          ),
                        ),
                        disabledSuffix: const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.do_disturb_alt_sharp,
                            size: 14,
                          ),
                        )),
                    items: chefSpecialities!.map((speciality) {
                      return MultiSelectCard(
                        decorations: MultiSelectItemDecorations(
                          selectedDecoration: BoxDecoration(
                            color: Color.fromRGBO(18, 149, 117, 1),
                            borderRadius: BorderRadius.circular(22)
                          ),
                        ),
                        margin: const EdgeInsets.all(10),
                        value: speciality,
                        label: speciality.speciality,
                      );
                    }).toList(),
                    onChange: (allSelectedItems, selectedItem) {
                      setState(() {
                        counter = allSelectedItems.length;
                        selectedSpecialities.add(selectedItem);
                      });
                    }
              )

              ),
              Center(
                child: ElevatedButton(
                  onPressed: ()async{
                    try{
                      if(counter ==0){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Choose your specialities")),
                        );
                      }else{
                        await _addLinks(selectedSpecialities);
                        await Future.delayed(Duration(seconds: 1));
                        if(mounted) {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => const NavPage()));
                        }
                      }
                    }catch(e){
                      print("Error while adding links: $e");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Failed to add links. Please try again.")),
                      );
                    }

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(width: screenWidth*0.03,),
                      const Text(
                        'Continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Color(0xFFFFFFFF)
                        ),
                      ),
                      const Icon(
                        Icons.double_arrow,
                        size: 33,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),


    ]
      ),
    );
  }
}
