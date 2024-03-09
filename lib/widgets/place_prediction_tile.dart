import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users/Assistant/request_assistant.dart';
import 'package:users/Models/predicted_places.dart';
import 'package:users/global/map_key.dart';
import 'package:users/infoHandler/app_info.dart';
import 'package:users/widgets/progress_dialog.dart';
import 'package:users/global/global.dart';
import '../Models/directions.dart';

class PlacePredictionTileDesign extends StatefulWidget {
  final PredictedPlaces? predictedPlaces;

  PlacePredictionTileDesign({this.predictedPlaces});

  @override
  State<PlacePredictionTileDesign> createState() =>
      _PlacePredictionTileDesignState();
}

class _PlacePredictionTileDesignState extends State<PlacePredictionTileDesign> {
  getPlaceDirectionsDetails(String? placeId, context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
              message: "Setting up Drop-off. Please wait......",
            ));

    String placeDirectionDetailsurl =
        "https://maps.googleapis.com/maps/api/place/details/jason?/place_id=$placeId&key=$mapKey";

    var responseApi =
        await RequestAssistant.receiveRequest(placeDirectionDetailsurl);

    Navigator.pop(context);
    if (responseApi == "Error Occured. Failed. No Response.") {
      return;
    }
    if (responseApi["status"] == "OK") {
      Directions directions = Directions();
      directions.locationName = responseApi["result"]["name"];
      directions.locationId = placeId;
      directions.locationLatitude =
          responseApi["result"]["geometry"]["location"]["lat"];
      directions.locationLongitude =
          responseApi["result"]["geometry"]["location"]["lng"];
      Provider.of<AppInfo>(context, listen: false)
          .updateDropOffLocationAddress(directions);
      setState(() {
        userDropOffAddress = directions.locationName!;
      });
      Navigator.pop(context, "obtainedDropoff");
    }
    @override
    Widget build(BuildContext context) {
      bool darkTheme =
          MediaQuery.of(context).platformBrightness == Brightness.dark;
      return ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          primary: darkTheme ? Colors.black : Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(
                Icons.add_location,
                color: darkTheme ? Colors.amber.shade400 : Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.predictedPlaces!.main_text!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    ),
                  ),
                  Text(
                    widget.predictedPlaces!.secondry_text!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      color: darkTheme ? Colors.amber.shade400 : Colors.blue,
                    ),
                  )
                ],
              ))
            ],
          ),
        ),
      );
    }

    ;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
