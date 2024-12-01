import 'package:flutter/material.dart';
import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
import 'package:to_do/Features/home/presentation/views/widgets/app_bar_of_profile.dart';
import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final ProfileImageController _imageController = ProfileImageController();

  @override
  void initState() {
    super.initState();
    _initializeProfileImage();
  }

  Future<void> _initializeProfileImage() async {
    await _imageController.loadSavedImage();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 23.0, right: 23, top: 39),
          child: Column(
            children: [
              const AppBarOfProfile(),
              ProfileImageWidget(controller: _imageController),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: "Full Name",
                onChanged: (text) {},
              ),
              CustomTextField(
                hintText: "Email Address",
                onChanged: (text) {},
              ),
              CustomTextField(
                hintText: "Phone Number",
                onChanged: (text) {},
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 1.9,
                child: CustomButtom(
                  text: "Save",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileImageWidget extends StatelessWidget {
  final ProfileImageController controller;
  final double radius;

  const ProfileImageWidget({
    super.key,
    required this.controller,
    this.radius = 77,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main CircleAvatar
        GestureDetector(
          onTap: () async {
            await controller.pickImage();
            // Refresh UI after picking the image
            (context as Element).markNeedsBuild();
          },
          child: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 167, 155, 155),
            radius: radius,
            backgroundImage: controller.selectedImage != null
                ? FileImage(controller.selectedImage!) as ImageProvider
                : const AssetImage('assets/default_image.png'),
            child: controller.selectedImage == null
                ? const Icon(
                    Icons.person,
                    size: 80,
                    color: Colors.white70,
                  )
                : null,
          ),
        ),
        // Edit Icon at the bottom-right corner
        Positioned(
          bottom: 8,
          right: 8,
          child: GestureDetector(
            onTap: () async {
              await controller.pickImage();
              // Refresh UI after picking the image
              (context as Element).markNeedsBuild();
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                color: Colors.white,
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProfileImageController {
  final ImagePicker _picker = ImagePicker();
  File? selectedImage;
  static const String imageKey = 'selected_image_path';

  // Load the saved image path from SharedPreferences
  Future<void> loadSavedImage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? savedImagePath = prefs.getString(imageKey);
    if (savedImagePath != null && File(savedImagePath).existsSync()) {
      selectedImage = File(savedImagePath);
    }
  }

  // Pick an image and save its path
  Future<void> pickImage() async {
    try {
      final XFile? pickedImage =
          await _picker.pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        selectedImage = File(pickedImage.path);
        await _saveImagePath(pickedImage.path);
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // Save the selected image path to SharedPreferences
  Future<void> _saveImagePath(String path) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(imageKey, path);
  }
}
