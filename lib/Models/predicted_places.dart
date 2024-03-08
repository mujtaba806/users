class PredictedPlaces {
  String? place_id;

  String? main_text;
  String? secondry_text;

  PredictedPlaces({this.place_id, this.main_text, this.secondry_text});

  PredictedPlaces.fromJson(Map<String, dynamic> jsonData) {
    place_id = jsonData["place_id"];
    main_text = jsonData["structured_formating"]["main_text"];
    secondry_text = jsonData["structured_formatting"][secondry_text];
  }
}
