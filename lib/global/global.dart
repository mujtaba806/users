import 'package:firebase_auth/firebase_auth.dart';
import 'package:users/Models/directions_details_info.dart';
import 'package:users/Models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentInfo;

DirectionDetailsInfo? tripDirectionDetailsInfo;
String userDropOffAddress = "";
