import 'package:flutter/material.dart';
import 'package:users/Models/predicted_places.dart';

class SearchPlacesScreen extends StatefulWidget {
  const SearchPlacesScreen({super.key});

  @override
  State<SearchPlacesScreen> createState() => _SearchPlacesScreenState();
}

class _SearchPlacesScreenState extends State<SearchPlacesScreen> {

  List<PredictedPlaces> placesPredictedList = [];

  findPlaceAutoCompleteSearch(String inputText) async {

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Text(
            "Search & set dropoff location",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 0.0,
        ),
        body: Column(
          children: [
            Container(
              decoration: BoxDecoration(color: Colors.blue, boxShadow: [
                BoxShadow(
                    color: Colors.white54,
                    blurRadius: 8,
                    spreadRadius: 0.5,
                    offset: Offset(0.7, 0.7))
              ]),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Icon(
                      Icons.adjust_sharp,
                      color: Colors.white,
                    ),
                    SizedBox(height: 18.0,),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8),
                        child: TextField(
                          onChanged: (value) {
                            findPlaceAutoCompleteSearch(value);
                          },
                          decoration: InputDecoration(
                              hintText: "Search Location Here...",
                              fillColor: Colors.white54,
                              filled: true,
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                left: 11,
                                top: 8,
                                bottom: 8,
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            //display place prediction result
            (placesPredictedList.length > 0)
                ? Expanded(
              child: ListView.separated(
                itemCount: placesPredictedList.length,
                physics: ClampingScrollPhysics(),
                itemBuilder: (context , index ){
              return
              },
                separatorBuilder: separatorBuilder,
              ),
            )


          ],
        ),
      ),
    );
  }
}
