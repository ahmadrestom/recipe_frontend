import 'package:flutter/material.dart';
import 'package:recipe_app/customerWidgets/reviewCard.dart';
import 'package:recipe_app/models/recipe.dart';
import 'package:intl/intl.dart';
import 'package:fluentui_emoji_icon/fluentui_emoji_icon.dart';

class Reviews extends StatefulWidget{
  const Reviews({super.key, required this.recipe});

  final Recipe recipe;

  @override
  State<Reviews> createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  final TextEditingController _commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        padding: const EdgeInsets.fromLTRB(30, 39, 30, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                const Spacer(),
                const Text(
                  "Reviews",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color.fromRGBO(24, 24, 24, 1),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 26.0,),
            Text(
              "${widget.recipe.getNumberOfReviews().toString()} comments",
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                fontSize: 11,
                color: Color.fromRGBO(169, 169, 169, 1),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Leave a comment",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Color.fromRGBO(18, 18, 18, 1),
                    ),
                  ),
                  TextField(
                    maxLines: 2,
                    textInputAction: TextInputAction.newline,
                    controller: _commentController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey, width: 1.5, style: BorderStyle.solid, strokeAlign: BorderSide.strokeAlignInside), // Customize border color and width
                          borderRadius: BorderRadius.circular(10.0),
                        ),

                        hintText: "Say something",
                        hintStyle: const TextStyle(
                          color: Color.fromRGBO(200, 200, 200, 1),
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Poppins',
                          fontSize: 14,

                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Color.fromRGBO(200, 200, 200, 1)),
                        )
                    ),

                  ),
                  const SizedBox(height: 5.0,),
                  ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        const Color.fromRGBO(18, 149, 117, 1),
                      ),

                    ),
                    onPressed: (){
                      setState(() {
                        //////////////////////////////
                      });
                    },
                    child: const Text(
                      "Send",
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                        color: Color.fromRGBO(255, 255, 255, 1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.fromLTRB(1, 7, 1, 7),
                child: ListView.builder(
                  itemCount: widget.recipe.getNumberOfReviews(),
                  itemBuilder: (context, index){
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.white
                        color: const Color.fromRGBO(240, 240, 240, 1),
                      ),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.only(top: 12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                child: Icon(Icons.account_circle_rounded),
                              ),
                              SizedBox(width: 5.0,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${widget.recipe.reviews![index].user.firstName} ${widget.recipe.reviews![index].user.lastName}",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12,
                                      color: Color.fromRGBO(18, 18, 18, 1),
                                    ),
                                  ),
                                  Text(
                                    DateFormat('dd-MM-yyyy HH:mm').format(widget.recipe.reviews![index].timeUploaded),
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400,
                                      fontSize: 11,
                                      color: Color.fromRGBO(169, 169, 169, 1),
                                    ),
                                  ),

                                ],
                              ),

                            ],
                          ),
                          SizedBox(height: 10.0,),
                          Text(
                            widget.recipe.reviews![index].text,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              color: Color.fromRGBO(128, 128, 128, 1),
                            ),
                          ),
                          SizedBox(height: 3.0,),
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Color.fromRGBO(219, 235, 231, 1),
                                  ),
                                width: 35,
                                height: 19,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                  GestureDetector(
                                    child: FluentUiEmojiIcon(
                                      w: 14,
                                      h: 14,
                                      fl: Fluents.flThumbsUp,
                                    ),
                                    onTap: (){
                                      setState(() {
                                        widget.recipe.reviews![index].likes++;
                                      });
                                    },
                                  ),
                                  SizedBox(width: 1.0,),
                                  Text(
                                    widget.recipe.reviews![index].likes.toString(),
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],

                              ),
                              ),
                              SizedBox(width: 4.0,),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Color.fromRGBO(219, 235, 231, 1),
                                ),
                                width: 35,
                                height: 19,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children:[
                                    GestureDetector(
                                      child: FluentUiEmojiIcon(
                                        w: 14,
                                        h: 14,
                                        fl: Fluents.flThumbsDown,
                                      ),
                                      onTap: (){
                                        setState(() {
                                          widget.recipe.reviews![index].dislikes++;
                                        });
                                      },
                                    ),
                                    SizedBox(width: 1.0,),
                                    Text(
                                      widget.recipe.reviews![index].dislikes.toString(),
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],

                                ),
                              ),



                        ],
                      ),
                      ]
                    ),
                    );
                  }
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
