
import 'package:calc/domain/MyUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<MyUser> SignInWithEmailAndPassword(String email, String password)   async {
    try{
      UserCredential result = await _fAuth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return MyUser.fromFirebase(user);
    }catch(e){
      return null;
    }
  }

  Future<MyUser> RegisterWithEmailAndPassword(String email, String password) async {
    try{
      UserCredential result = await _fAuth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user;
      return MyUser.fromFirebase(user);
    }catch(e){
      return null;
    }
  }

  Future logOut() async {
    await _fAuth.signOut();
  }

  Stream<MyUser> get currentUser{
    return _fAuth.authStateChanges().map((User user)=> user!=null ? MyUser.fromFirebase(user) : null);
  }

}