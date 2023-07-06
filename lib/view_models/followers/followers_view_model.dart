// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:movie_app/view_models/followers/followers_controller.dart';
import 'package:provider/provider.dart';

class FollowersViewModel with ChangeNotifier {
  final FollowersProvider _followersProvider;
  
  FollowersViewModel(this._followersProvider) ;

 static provider(context, {listen = false}) =>
      Provider.of<FollowersViewModel>(context, listen: listen);

  List? get myFollowers => _followersProvider.myFollowers ?? [];
  List? get myFollowing => _followersProvider.myFollowing ?? [];

  int ? get userFollowingCount =>_followersProvider.userFollowingCount;
  int ? get userFollowersCount =>_followersProvider.userFollowersCount;
  

  getUserData(userId) async {
    await _followersProvider.getUserFollowers(userId);
    await _followersProvider.getUserFollowing(userId);
  }






  bool isFollowed(userId) {
    int userIndex = myFollowing!.indexWhere((user) {
      return user['userId'] == userId;
    });

    return userIndex >= 0 ? myFollowing![userIndex]['userId'] != null : false;
  }

  // toggleIsFollowed() {
  //   log('from toggle');
  //   log(_isFollowed.toString());
  //   _isFollowed = !_isFollowed;
  //   log(_isFollowed.toString());
  //   notifyListeners();
  // }

  _followSomeOne({required String someOneId, required String currentUserId}) {
    _followersProvider.followSomeOne(
      currentUserId: currentUserId,
      someOneId: someOneId,
    );
  }

  _unFollowSomeOne({required String someOneId, required String currentUserId}) {
    _followersProvider.unFollowSomeOne(
      currentUserId: currentUserId,
      someOneId: someOneId,
    );
  }

  follow({required String someOneId, required String currentUserId}) {
    int userIndex =
        myFollowing!.indexWhere((user) => user['userId'] == someOneId);
    if (isFollowed(someOneId)) {
      myFollowing!.remove(myFollowing![userIndex]);
      _unFollowSomeOne(
        currentUserId: currentUserId,
        someOneId: someOneId,
      );
      notifyListeners();
    } else {
      myFollowing?.add({'userId': someOneId});
      _followSomeOne(
        currentUserId: currentUserId,
        someOneId: someOneId,
      );
      notifyListeners();
    }
  }
}
