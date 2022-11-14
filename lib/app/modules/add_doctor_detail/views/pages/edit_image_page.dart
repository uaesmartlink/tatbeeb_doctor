import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hallo_doctor_doctor_app/app/modules/add_doctor_detail/controllers/add_doctor_detail_controller.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class EditImagePage extends GetView<AddDoctorDetailController> {
  @override
  Widget build(BuildContext context) {
    final ImagePicker _picker = ImagePicker();
    XFile? image;
    File? imageFile;

    final VoidCallback onPressed = () async {
      image = await _picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;
      imageFile = File(image!.path);
      var imageCropped = await ImageCropper().cropImage(
          sourcePath: image!.path,
          aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
          aspectRatioPresets: [CropAspectRatioPreset.square]);
      if (imageCropped == null) return;
      imageFile = File(imageCropped.path);
      controller.update();
    };
    final color = Colors.grey;

    final oldImage = NetworkImage(controller.profilePicUrl.value);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Edit Image'.tr,
          //style: appbarTextStyle,
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 40),
            child: Row(
              children: [
                SizedBox(
                  width:250,
                  child: Text(
                    'Upload your photo '.tr,
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                buildEditIcon(color, onPressed),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: SizedBox(
              child: Container(
                child: Center(
                  child: Stack(
                    children: [
                      buildImage(color, oldImage),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 330,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (imageFile == null) return;
                    controller.updateProfilePic(imageFile!);
                  },
                  child: Text(
                    'Confirm'.tr,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(Color color, NetworkImage image) {
    /*  return CircleAvatar(
      radius: 75,
      backgroundColor: color,
      child: CircleAvatar(
        backgroundImage: image as ImageProvider,
        radius: 70,
      ),
    );*/
    return Container(
      height: 330.0,
      width: 330.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image as ImageProvider,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }

  Widget buildEditIcon(Color color, VoidCallback onPressed) => IconButton(
        icon: Icon(
          Icons.edit,
        ),
        iconSize: 30,
        color: color,
        onPressed: onPressed,
      );

  // Builds/Makes Circle for Edit Icon on Profile Picture
  Widget buildCircle({
    required Widget child,
    required double all,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: Colors.white,
          child: child,
        ),
      );
}

/*
Stack(
              children: [
                CircleAvatar(
                  radius: 120,
                  backgroundColor: Colors.grey.shade200,
                  backgroundImage: AssetImage('assets/images/handsome_doctor.jpg'),

                ),
                Positioned(
                  right: 1,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                          Icons.mode_edit_outline_rounded, color: Colors.grey),
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 5,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            50,
                          ),
                        ),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(2, 4),
                            color: Colors.black.withOpacity(
                              0.3,
                            ),
                            blurRadius: 3,
                          ),
                        ]),
                  ),
                ),
              ],
            ),
 */
