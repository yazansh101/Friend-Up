import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/constants.dart';
import '../../../core/constants/size_config.dart';
import '../../../view_models/user/user_view_model.dart';

class ProfilePictuerOnline extends StatelessWidget {
  final double? radius1;
  final double? radius2;
  final String? ownerId;
  final String? imageUrl;

  const ProfilePictuerOnline({
    super.key,
    this.radius1,
    required this.ownerId,
    required this.radius2,
    required this.imageUrl,
    
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildProfilePicture(), _buildOnlineCircle()],
    );
  }

  Consumer<UserViewModel> _buildOnlineCircle() {
    return Consumer<UserViewModel>(builder: (context, userViewModel, child) {
      return StreamBuilder(
          stream: userViewModel.getUserStatus(ownerId),
          builder: (context, snapshot) {
            if(snapshot.connectionState==ConnectionState.done){
           userViewModel.initUserStatus(snapshot);
              
            }
            return Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                height: userViewModel.isOnline! ? radius2 : 0,
                width: userViewModel.isOnline! ? radius2 : 0,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(radius2!),
                  border: Border.all(color: getColorTheme(), width: 2),
                ),
              ),
            );
          });
    });
  }

  CircleAvatar _buildProfilePicture() {
    return CircleAvatar(
      backgroundColor: kPrimaryColor,
      backgroundImage: imageUrl == '' || imageUrl==null? null : NetworkImage(imageUrl!),
      radius: radius1,
      child: imageUrl == ''
          ? const Icon(
              size: 22,
              Icons.person,
              color: Colors.white70,
            )
          : null,
    );
  }
}
