// ignore_for_file: library_private_types_in_public_api, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/view_models/time_line/time_line_view_model.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/size_config.dart';
import '../../../core/helper/image_picker.dart';
import '../../../core/widgets/custom_text.dart';
import '../../../core/widgets/show_dialog.dart';
import '../../../view_models/user/user_view_model.dart';
import '../../home/screens/home.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  _CreatePostScreenState createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  bool _isDirty = false;

  final _formKey = GlobalKey<FormState>();

  File? mediaFile;

  late String _discription;
  String? address;

  void _onFormChanged() {
    setState(() {
      _isDirty = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.focusedChild!.unfocus();
        }
      },
      child: Scaffold(
        appBar: _appbar(context),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                height: 700,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    _buildUserDetails(context),
                    setVerticalSpace(2),
                    _buildPostDescription(),
                    const SizedBox(height: 16.0),
                    if (mediaFile != null) _buildMediaPreview(),
                    setVerticalSpace(2),
                    _buildPhotosOption(context),
                    setVerticalSpace(1),
                    const Spacer(),
                    _buildPostButton(context),
                    const Spacer(
                      flex: 3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Container _buildMediaPreview() {
    return Container(
      padding: EdgeInsets.all(5),
      height: setHeight(30),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Colors.white),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Image.file(mediaFile!),
    );
  }

  SizedBox _buildPostButton(context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    final timeLinePostsViewModel =
        Provider.of<TimeLinePostsViewModel>(context, listen: false);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          if (_formKey.currentState!.validate()) {
            if (mediaFile == null) {
              ShowDialog.showMyDialog(context,
                  title: 'Error!',
                  discription: 'Please Enter a picture to create new post',
                  choiceTrue: 'Got it',
                  onChoiceTrue: () {},
                  height: 25);
            } else {
              await timeLinePostsViewModel.createPost(
                  ownerProfileImage: userViewModel.currentUser.imageProfileUrl,
                  ownerName: userViewModel.currentUser.userName,
                  postDescription: _discription,
                  imageFile: mediaFile);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ));
              //  NavigatorService.pushFadeTransition(context, HomeScreen());
            }
          }
        },
        child: const Text("Post"),
      ),
    );
  }

  InkWell _buildPhotosOption(BuildContext context) {
    return InkWell(
      onTap: () {
        ShowDialog.showMyDialog(
          context,
          icon: FontAwesomeIcons.image,
          title: '',
          discription: '',
          choiceTrue: 'Gallery',
          choiceFalse: 'Camera',
          onChoiceTrue: () async {
            mediaFile = await ImagePickerHelper.pickImageFromGallery();
            setState(() {});
          },
          onChoiceFalse: () async {
            mediaFile = await ImagePickerHelper.pickImageFromCamera();
            setState(() {});
          },
        );
      },
      child: Row(
        children: [
          const Icon(FontAwesomeIcons.image),
          setHorizentalSpace(2),
          CustomText(text: 'Photos'),
        ],
      ),
    );
  }

  TextFormField _buildPostDescription() {
    return TextFormField(
      maxLines: mediaFile == null ? 5 : 1,
      onChanged: (value) {
        _discription = value;
        setState(() {
          _isDirty = true;
        });
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "please enter something";
        }
        return null;
      },
      decoration: const InputDecoration(
        errorStyle: TextStyle(color: Colors.red),
        border: OutlineInputBorder(),
        hintText: "What's on your mind?",
      ),
    );
  }

  Row _buildUserDetails(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context, listen: false);
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(
            userViewModel.currentUser.imageProfileUrl
          ),
          radius: 19,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userViewModel.currentUser.userName,
                style: TextStyle(fontWeight: FontWeight.bold)),
            setVerticalSpace(0.5),
          ],
        ),
      ],
    );
  }

  AppBar _appbar(BuildContext context) {
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
                    onChoiceTrue: () {
                      return;
                    },
                    onChoiceFalse: () {
                      Navigator.pop(context);
                    },
                    height: 30.0,
                  );
                } else {
                  Navigator.pop(context);
                }
              },
              icon: const Icon(Icons.arrow_back)),
          CustomText(
            text: 'Create Post',
            fontSize: 15,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
