import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/state.dart';

import '../../../Model/social_app/social_user_model.dart';
import '../../../Modules/social_app/chats/chat_screen.dart';
import '../../../Modules/social_app/feeds/feeds_screen.dart';
import '../../../Modules/social_app/new_post/new_post_screen.dart';
import '../../../Modules/social_app/settings/setting_screen.dart';
import '../../../Modules/social_app/users/Users_screen.dart';
import '../../../Shared/components/constans.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? model;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      if (value.data() != null) {
        model = SocialUserModel.fromJson(value.data()!);
        emit(SocialGetUserSuccessState());
      } else {
        emit(SocialGetUserErrorState("User data is null"));
      }
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }
}
