import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';

class CreatePasswordPatientsController extends GetxController {
  //TODO: Implement CreatePasswordPatientsController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
LoginController loginController=LoginController();
 void upatePasswordOfAccountPatients(dynamic token,dynamic password,confirm_password){
   if(password==confirm_password){
     FirebaseFirestore.instance.collection("patients").doc(token).update({"password":password}).then((value) {
       loginController.moveBetweenPages('patients');

     });
     update();

   }
 }
}
