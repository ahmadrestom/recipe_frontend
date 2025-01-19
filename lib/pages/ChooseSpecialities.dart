import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_app/Providers/ChefSpecialityProvider.dart';
import 'package:recipe_app/models/chef_speciality.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';
import '../customerWidgets/background_design_screen.dart';

class ChooseSpecialities extends StatefulWidget {
  const ChooseSpecialities({super.key});

  @override
  State<ChooseSpecialities> createState() => _ChooseSpecialitiesState();
}

class _ChooseSpecialitiesState extends State<ChooseSpecialities> {

  Set<ChefSpeciality>? chefSpecialities;

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

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    if(chefSpecialities==null){
      return const CircularProgressIndicator();
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                ],
              ),
              Expanded(
                child: chefSpecialities!.isEmpty
                    ? Center(child: Text("XX"))
                    : MultiSelectContainer(
                  maxSelectableCount: 10,
                  alignments: MultiSelectAlignments(mainAxisAlignment: MainAxisAlignment.center),
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
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(22)
                          ),
                        ),
                        margin: const EdgeInsets.all(10),
                        value: speciality.speciality,
                        label: speciality.speciality,
                      );
                    }).toList(),
                    onChange: (allSelectedItems, selectedItem) {

                    }
              )

              )],
          ),
        ),

    ]
      ),
    );
  }
}
