// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:to_do/Features/Auth/Data/manager/login_cubit/login_cubit.dart';
// import 'package:to_do/Features/Auth/Data/manager/signup_cubit/signup_cubit.dart';
// import 'package:to_do/Features/Auth/presentation/views/widgets/custom_text_field.dart';
// import 'package:to_do/Features/home/presentation/views/edit_profile.dart';
// import 'package:to_do/Features/home/presentation/views/widgets/app_bar_of_profile.dart';
// import 'package:to_do/Features/onboarding/presentation/views/Widgets/custom_buttom.dart';
// import 'package:to_do/constants.dart';

// class ProfileView extends StatefulWidget {
//   const ProfileView({
//     super.key,
//   });

//   @override
//   State<ProfileView> createState() => _ProfileViewState();
// }

// class _ProfileViewState extends State<ProfileView> {
//   final ProfileImageController _imageController = ProfileImageController();

//   @override
//   void initState() {
//     super.initState();
//     _initializeProfileImage();
//   }

//   Future<void> _initializeProfileImage() async {
//     await _imageController.loadSavedImage();
//     setState(() {});
//   }

//   @override
//   Widget build(BuildContext context) {
//     _initializeProfileImage();
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(23.0),
//         child: Column(
//           children: [
//             const AppBarOfProfile(),
//             // ProfileImageWidget(controller: _imageController),
//             CircleAvatar(
//               maxRadius: 77,
//               backgroundColor: Color.fromARGB(255, 167, 155, 155),
//               child: CircleAvatar(
//                 maxRadius: 75,
//                 backgroundImage: _imageController.selectedImage != null
//                     ? FileImage(_imageController.selectedImage!)
//                     : AssetImage(userImage) as ImageProvider,
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             Visibility(
//               visible: !isGuest,
//               child: SizedBox(
//                 width: MediaQuery.sizeOf(context).width / 2.5,
//                 height: 55,
//                 child: CustomButtom(
//                   text: "Edit Profile",
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => EditProfile(),
//                         ));
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 30,
//             ),
//             BlocProvider(
//               create: (context) => SignupCubit(),
//               child: Builder(builder: (context) {
//                 return CustomTextField(
//                   validatorRequired: false,
//                   hintText: emailOfUser.isEmpty
//                       ? "Host"
//                       : BlocProvider.of<SignupCubit>(context).getUserName(),
//                   onChanged: (Sting) {},
//                   enabled: false,
//                   label: '',
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
