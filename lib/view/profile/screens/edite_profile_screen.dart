// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/core/constants/constants.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:provider/provider.dart';

import '../../../core/helper/image_picker.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/show_dialog.dart';
import '../../../models/user_model.dart';
import '../../../view_models/user/user_view_model.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController? _bioController;
  TextEditingController? _userNameController;
  final _formKey = GlobalKey<FormState>();
  File? mediaFile;
  User? user;
  String? _bio;
  String? _username;
  bool _isDirty = false;

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Scaffold(
      appBar: _buildAppBar(context),
      resizeToAvoidBottomInset: true,
      body: _buildBody(userViewModel, context),
    );
  }

  SingleChildScrollView _buildBody(
      UserViewModel userViewModel, BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              setVerticalSpace(8),
              _buildProfileImage(userViewModel.currentUser.imageProfileUrl),
              const SizedBox(height: 20),
              _buildUserName(),
              const SizedBox(height: 10),
              _buildUserNameField(userViewModel),
              const SizedBox(height: 20),
              _buildBio(),
              const SizedBox(height: 10),
              _buildBioField(userViewModel),
              const SizedBox(height: 20),
              _buildSaveChangesButton(userViewModel, context),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildSaveChangesButton(
      UserViewModel userViewModel, BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        await userViewModel.updateProfile(
          bio: _bio ?? userViewModel.currentUser.bio,
          image: mediaFile,
          userId: userViewModel.currentUser.userId,
          userName: _username ?? userViewModel.currentUser.userName,
        );
        
        Navigator.pop(context);
      },
      child: const Text('Save Changes'),
    );
  }

  SingleChildScrollView _buildBioField(UserViewModel userViewModel) {
    return SingleChildScrollView(
      child: TextFormField(
        initialValue: userViewModel.currentUser.bio,
        controller: _bioController,
        onChanged: (value) {
          setState(() {
            _bio = value;
            _isDirty = true;
          });
        },
        maxLines: 5,
        decoration: const InputDecoration(
          hintText: 'Write your bio!',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  SingleChildScrollView _buildUserNameField(UserViewModel userViewModel) {
    return SingleChildScrollView(
      child: TextFormField(
        initialValue: userViewModel.currentUser.userName,
        controller: _userNameController,
        onChanged: (value) {
          setState(() {
            _username = value;
            _isDirty = true;
          });
        },
        decoration: const InputDecoration(
          hintText: 'Enter your username',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Text _buildBio() {
    return const Text(
      'Bio',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Text _buildUserName() {
    return const Text(
      'User name',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Center _buildProfileImage(imageUrl) {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
              backgroundImage: 
              mediaFile == null
                  ? imageUrl == null
                      ? null
                      : NetworkImage(imageUrl)
                  : FileImage(mediaFile!)as ImageProvider<Object>?,
              radius: 60,
              child: mediaFile == null
                  ? imageUrl == null
                      ? const Icon(
                          Icons.person,
                          size: 30,
                        )
                      : null
                  : null),
          Positioned(
            bottom: 0,
            right: -18,
            child: SizedBox(
              height: 42,
              width: 58,
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  elevation: MaterialStateProperty.all<double>(0),
                  shape: MaterialStateProperty.all(const CircleBorder()),
                ),
                onPressed: () {
                  ShowDialog.showMyDialog(
                    context,
                    icon: FontAwesomeIcons.image,
                    title: '',
                    discription: '',
                    choiceTrue: 'Gallery',
                    choiceFalse: 'Camera',
                    onChoiceTrue: () async {
                      mediaFile =
                          await ImagePickerHelper.pickImageFromGallery();
                      setState(() {});
                    },
                    onChoiceFalse: () async {
                      mediaFile = await ImagePickerHelper.pickImageFromCamera();
                      setState(() {});
                    },
                  );
                },
                child: const Icon(
                  Icons.camera_alt_outlined,
                  color: kPrimaryColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: double.infinity,
      leading: Row(
        children: [
          IconButton(
              onPressed: () {
                if (_isDirty) {
                  ShowDialog.showMyDialog(
                    context,
                    title: 'Save changes?',
                    discription: 'Do you want to cancel the changes you made',
                    choiceTrue: 'Return',
                    choiceFalse: 'Discard',
                    height: 30,
                    onChoiceTrue: () {
                      return;
                    },
                    onChoiceFalse: () {
                      Navigator.pop(context);
                    },
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back)),
          const CustomText(
            text: 'Edite Profile',
            fontSize: 15,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
