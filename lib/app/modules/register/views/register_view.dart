import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/divider.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/submit_button.dart';
import 'package:hallo_doctor_doctor_app/app/modules/login/views/widgets/title_widget.dart';
import 'package:hallo_doctor_doctor_app/app/utils/helpers/validation.dart';
import '../../widgets/log_container.dart';
import '../controllers/register_controller.dart';
import 'widgets/login_account_label.dart';

class RegisterView extends GetView<RegisterController> {
  @override
  Widget build(BuildContext context) {
    final height = Get.height;
    final node = FocusScope.of(context);
    return Scaffold(
      body: LogContainer(
        widget: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: controller.formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      titleApp(),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          if (value!.length < 3) {
                            return 'Name must be more than two characters'.tr;
                          } else {
                            return null;
                          }
                        }),
                        onSaved: (username) {
                          controller.username = username!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Username'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () {
                          node.nextFocus();
                        },
                        validator: ((value) {
                          return Validation().validateEmail(value);
                        }),
                        onSaved: (email) {
                          controller.email = email!;
                        },
                        decoration: InputDecoration(
                            hintText: 'Email'.tr,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                )),
                            fillColor: Colors.grey[200],
                            filled: true),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GetBuilder<RegisterController>(
                          builder: (controller) => TextFormField(
                                obscureText: controller.passwordVisible,
                                textInputAction: TextInputAction.done,
                                onEditingComplete: () {
                                  node.nextFocus();
                                },
                                validator: ((value) {
                                  if (value!.length < 6) {
                                    return 'Password must be more than 6 characters'
                                        .tr;
                                  } else {
                                    return null;
                                  }
                                }),
                                onSaved: (password) {
                                  controller.password = password!;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Password'.tr,
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10.0),
                                        borderSide: BorderSide(
                                          width: 0,
                                          style: BorderStyle.none,
                                        )),
                                    fillColor: Colors.grey[200],
                                    filled: true,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                          controller.passwordVisible
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: Colors.blue[300]),
                                      onPressed: () {
                                        controller.passwordIconVisibility();
                                      },
                                    )),
                              )),
                      SizedBox(
                        height: 20,
                      ),
                      submitButton(
                          onTap: () {
                            controller.signUpUser();
                          },
                          text: 'Register Now'.tr),
                      SizedBox(height: height * .01),
                      divider(),
                      //_googleSignInButton(controller.loginController),
                      loginAccountLabel(onTap: () {
                        Get.offAllNamed('/login');
                      }),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: BackButton()),
          ],
        ),
      ),
    );
  }
}
