import 'dart:ffi';

class Directions{
   String? humanReadableAddress;
   String? locationName;
   String? locationId;
   Double? locationLatitude;
   Double? locationLongitude;

   Directions({
   this.humanReadableAddress,
   this.locationName,
   this.locationId,
   this.locationLatitude,
   this.locationLongitude,
   });

}