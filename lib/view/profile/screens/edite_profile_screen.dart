// ignore_for_file: unnecessary_null_comparison, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:movie_app/core/constants/size_config.dart';
import 'package:provider/provider.dart';

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
  // File _image;
  final _formKey = GlobalKey<FormState>();
  User? user;
  String? _bio;
  String? _username;
  bool _isDirty = false;

  Future<void> _loadData() async {
    // try {
    //   User user = await userController.getUserInfo(user.userId) as User;

    //   _bio = user.bio;
    //   _username = user.userName;
    //   _bioController = TextEditingController(text: _bio);
    //   _userNameController = TextEditingController(text: _username);
    //   setState(() {});
    //   print('init succesfully!');
    // } catch (e) {
    //   print(e);
    // }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }
  // method to select profile image from camera or gallery
  // Future _getImage() async {
  //   final pickedFile =
  //       await ImagePicker().getImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = File(pickedFile.path);
  //   });
  // }
  // method to update user's profile information
  // Future<void> _updateProfile() async {
  // upload image to Firebase Storage
  //   String imageUrl = '';
  // if (_image != null) {
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('user_images')
  //       .child(DateTime.now().toString() + '.jpg');
  //  // await ref.putFile(_image);
  //   imageUrl = await ref.getDownloadURL();
  // }
  //   // get user's current location
  //   final position = await Geolocator.getCurrentPosition();
  //   final placemarks = await Geolocator.placemarkFromCoordinates(
  //       position.latitude, position.longitude);
  //   final address = '${placemarks[0].locality}, ${placemarks[0].country}';
  //   // save user information to Firebase Firestore
  //   // replace this section with your own code to save user information
  //   // to your specific database
  //   print('Profile Image URL: $imageUrl');
  //   print(address);
  // }

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
              _buildProfileImage(),
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
          image: null,
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

  Center _buildProfileImage() {
    return Center(
      child: GestureDetector(
        onTap: () {},
        //_getImage,
        child: const CircleAvatar(
          backgroundColor: Colors.grey,
          // backgroundImage: _image != null
          //     ? FileImage(_image)
          //     : NetworkImage(
          //         'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
          radius: 60,
          child: Icon(Icons.person),
        ),
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
          ),
        ],
      ),
    );
  }
}
