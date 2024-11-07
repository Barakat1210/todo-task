import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/assets_mamager.dart';
import 'package:todo_app/core/reusable_component/custom_text_form_field.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/database_manager/model/userdm.dart';

import '../../../core/constant_manager.dart';
import '../../../core/utils/dialog_utils.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade900,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 40),
              child: SvgPicture.asset(AssetsManager.routeLogo),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Text(
                      StringsManager.email,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  buildEmailField(),
                  SliverToBoxAdapter(
                    child: Text(
                      StringsManager.password,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w300,
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: buildPasswordField(),
                  ),
                  SliverToBoxAdapter(
                    child: const SizedBox(
                      height: 18,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: MaterialButton(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        onPressed: () {
                          signIn(context);
                        },
                        child: Text(
                          StringsManager.signIn,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF004182),
                          ),
                        )),
                  ),
                  SliverToBoxAdapter(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Do not  have Account?',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RoutesManager.registerRoute);
                            },
                            child: Text(
                              StringsManager.signUp,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 20,
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEmailField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hintText: 'enter your E-mail address',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'Plz,enter E-mail address';
            }
          },
          controller: emailController,
        ),
      );
  Widget buildPasswordField() => CustomTextFormField(
        hintText: 'enter your password',
        validator: (input) {
          if (input == null || input.trim().isEmpty) {
            return 'Plz,enter password';
          }
          if (input.length < 6) {
            return 'Sorry, Password should be at least 6 chars';
          }
        },
        controller: passwordController,
        isSecure: true,
      );
  void signIn(context) async {
    try {
      DialogUtils.showLoadingDialog(context, message: 'Loading...');
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM.userDM=await getUserFromFireStore(credential.user!.uid);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          content: 'user login successfully',
          posActionTitle: 'Ok', posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.homeRoute);
      });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);
      String message;
      if (authError.code == AppConstants.invalidCredential) {
        message = AppConstants.wrongEmailOnPassWordMessage;
      } else if (authError.code == AppConstants.wrongPassWord) {
        message = AppConstants.wrongPassWordMessage;
      } else {
        message = AppConstants.SomeThingwentWrongMessage;
      }
      DialogUtils.showMessageDialog(context,
          title: 'Error', content: message, posActionTitle: 'Ok');
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          title: 'Error', content: e.toString(), posActionTitle: 'Ok');
    }
  }

  Future<UserDM>getUserFromFireStore(String uid) async{
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference userDoc=collectionReference.doc(uid);
    DocumentSnapshot documentSnapshot=await userDoc.get();
    var json=documentSnapshot.data() as Map<String,dynamic>;
    return UserDM.fromFireStore(json);
  }
}
