import 'package:firebase_auth/firebase_auth.dart';
import 'package:users/Models/user_model.dart';

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
User? currentUser;
UserModel? userModelCurrentInfo;