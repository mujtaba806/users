import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:users/Assistant/request_assistant.dart';
import 'package:users/Models/directions.dart';
import 'package:users/Models/user_model.dart';
import 'package:users/global/global.dart';
import 'package:users/global/map_key.dart';
//import 'dart:ffi';
class AssistantMethods {
  static void readCurrentOnlineUserInfo() async {
    currentUser = firebaseAuth.currentUser;
    DatabaseReference userRef =
        FirebaseDatabase.instance.ref().child("users").child(currentUser!.uid);
    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  static Future<String> searchAddressForGeographicCoordinates(
      Position position, context) async {
    String apiUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKey";
    String humanReadableAddress ="";
    var requestResponse=await RequestAssistant.receiveRequest(apiUrl);
    if(requestResponse != "Error Occured. Failed. No Response."){
      humanReadableAddress = requestResponse["results"][0]["fomatted_address"];

      Directions userPickUpAddress = Directions();
      userPickUpAddress.locationLatitude = position.latitude as double? ;
      userPickUpAddress.locationLatitude = position.longitude as double? ;
      userPickUpAddress.locationName = humanReadableAddress;

      //Provider.of.<AppInfo>(context,listen:false).updatePickUpLocationAddress(userPickUpAddress);
    }
    return humanReadableAddress;
  }
}
