import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/core/assets_mamager.dart';
import 'package:todo_app/core/constant_manager.dart';
import 'package:todo_app/core/reusable_component/custom_text_form_field.dart';
import 'package:todo_app/core/routes_manager.dart';
import 'package:todo_app/core/strings_manager.dart';
import 'package:todo_app/core/utils/dialog_utils.dart';
import 'package:todo_app/database_manager/model/userdm.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
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
                  buildTitleItem(StringsManager.fullName),
                  buildFullNameField(),
                  buildTitleItem(StringsManager.UserName),
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: 8,
                  //   ),
                  // ),
                  buildUserNameField(),
                  buildTitleItem(StringsManager.email),
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: 8,
                  //   ),
                  // ),
                  buildEmailField(),
                  buildTitleItem(StringsManager.password),
                  buildPasswordField(),
                  buildTitleItem(StringsManager.passwordConfirm),
                  // SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: 8,
                  //   ),
                  // ),
                  buildConfirmPasswordField(),
                  SliverToBoxAdapter(
                    child: SizedBox(
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
                          signUp(context);
                        },
                        child: const Text(
                          StringsManager.signUp,
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
                          'Already have Account?',
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, RoutesManager.loginRoute);
                            },
                            child: Text(
                              StringsManager.signIn,
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

  Widget buildFullNameField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hintText: 'enter your Full name',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'Plz,enter Full name';
            }
          },
          controller: fullNameController,
        ),
      );
  Widget buildUserNameField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hintText: 'enter your user name',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'Plz,enter user name';
            }
          },
          controller: userNameController,
        ),
      );
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
  Widget buildPasswordField() => SliverToBoxAdapter(
        child: CustomTextFormField(
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
        ),
      );
  Widget buildConfirmPasswordField() => SliverToBoxAdapter(
        child: CustomTextFormField(
          hintText: 'Confirm password',
          validator: (input) {
            if (input == null || input.trim().isEmpty) {
              return 'Plz,confirm password';
            }
            if (input.length < 6) {
              return 'Sorry, Confirm password should be at least 6 chars';
            }
          },
          controller: rePasswordController,
          isSecure: true,
        ),
      );
  buildTitleItem(String title) => SliverToBoxAdapter(
        child: Text(
          title,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      );

  void signUp(context) async {
    try {
      DialogUtils.showLoadingDialog(context, message: 'Loading...');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDM user = UserDM(
          id: credential.user!.uid,
          fullName: fullNameController.text,
          userName: userNameController.text,
          email: emailController.text);
      addUserToFireStore(user);
      DialogUtils.hideDialog(context);
      DialogUtils.showMessageDialog(context,
          content: 'user register successfully',
          posActionTitle: 'Ok', posAction: () {
        Navigator.pushReplacementNamed(context, RoutesManager.loginRoute);
      });
    } on FirebaseAuthException catch (authError) {
      DialogUtils.hideDialog(context);
      String message;
      if (authError.code == AppConstants.weakPassword) {
        message = AppConstants.weakPasswordMessage;
      } else if (authError.code == AppConstants.emailAlreadyInUse) {
        message = AppConstants.emailInUseMessage;
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

  void addUserToFireStore(UserDM user) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(UserDM.collectionName);
    DocumentReference newUserDoc = collectionReference.doc(user.id);
    newUserDoc.set(
      await user.toFireStore(),
    );
  }
}
