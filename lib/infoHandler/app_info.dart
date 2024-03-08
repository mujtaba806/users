import 'package:flutter/cupertino.dart';
import 'package:users/Models/directions.dart';

class AppInfo extends ChangeNotifier{
  Directions? userPickupLocation, userDropOffLocation;
  int countTotalTrips=0;
  //List<String> historyTripsKeysList = [];
  //List<TripsHistoryModel> allTripsHistoryInformationList=[];

  void updatePickUpLocationAddress(Directions userPickupAddress){
    userPickupLocation=userPickupAddress;
    notifyListeners();
  }
  void updateDropOffLocationAddress(Directions dropOffAddress){
    userDropOffLocation = dropOffAddress;
    notifyListeners();
  }
}