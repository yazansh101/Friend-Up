import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../../models/user_model.dart';
import '../user/user_provider.dart';

class SearchViewModel with ChangeNotifier {
  final UserProvider _userProvider;
  SearchViewModel(this._userProvider);

  bool isSearching = false;

  List<User> _usersOfSearchingReslut = [];
  List<User> get usersOfSearchingReslut => _usersOfSearchingReslut;

  TextEditingController controller = TextEditingController();

  Future<void> searchforUser(String searchTerm) async {
    toggleIsSearching();
    try {
      final documents = await _userProvider.searchForUser(searchTerm);
      _usersOfSearchingReslut =
          documents.docs.map((doc) => User.fromJson(doc)).toList();
      log('search success');
    } catch (e) {
      log(e.toString());
    }

    toggleIsSearching();

    notifyListeners();
  }

  toggleIsSearching() {
    isSearching = !isSearching;
    notifyListeners();
  }

  closeSearching() {
    controller.clear();
    notifyListeners();
  }
}
