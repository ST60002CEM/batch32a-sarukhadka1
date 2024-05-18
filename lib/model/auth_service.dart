import 'package:final_assignment/model/user_model.dart';
 
class AuthService {
  Future<void> signUp(UserModel user) async {
    // Simulating a network call
    await Future.delayed(const Duration(seconds: 2));
    // Implement your sign-up logic here
  }
}