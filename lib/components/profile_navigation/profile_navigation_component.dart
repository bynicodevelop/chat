import 'package:chat/components/profile_avatar/profile_avatar_component.dart';
import 'package:chat/components/profile_display_name/profile_display_name_component.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/responsive.dart';
import 'package:chat/screens/profile/profile_screen.dart';
import 'package:chat/services/profile/profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileNavigationComponent extends StatelessWidget {
  const ProfileNavigationComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if ((state as ProfileInitialState).profileModel != null) {
          return Container(
            color: kDefaultBackgroundColor,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: kDefaultPadding,
                  ),
                  child: ProfileAvatarComponent(
                    photoURL: state.profileModel!.photoURL,
                  ),
                ),
                ProfileDisplayNameComponent(
                  displayName: state.profileModel!.displayName,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: kProfileNavigation.length,
                    itemBuilder: (context, index) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: BorderSide(
                            color: !Responsive.isMobile(context)
                                ? kCTAColor
                                : Colors.transparent,
                            width: 3,
                          ),
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(kDefaultPadding),
                        title:
                            Text(kProfileNavigation[index]["title"] as String),
                        subtitle: Text(
                          kProfileNavigation[index]["subtitle"] as String,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        onTap: () {
                          if (Responsive.isMobile(context)) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }

        return Center(child: Text("loading"));
      },
    );
  }
}
