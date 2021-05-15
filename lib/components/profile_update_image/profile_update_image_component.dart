import 'package:chat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:chat/components/profile_avatar/profile_avatar_component.dart';
import 'package:chat/components/profile_update_image/bloc/profile_update_image_bloc.dart';
import 'package:chat/config/constants.dart';
import 'package:chat/repositories/models/profile_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:universal_platform/universal_platform.dart';

class ProfileUpdateImageComponent extends StatelessWidget {
  final ProfileModel profileModel;

  const ProfileUpdateImageComponent({
    Key? key,
    required this.profileModel,
  }) : super(key: key);

  Future _uploadFile(BuildContext context) async {
    try {
      List<PlatformFile>? _paths = (await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      ))!
          .files;

      if (_paths.length > 0) {
        context.read<ProfileUpdateImageBloc>().add(
              ProfileUpdateImageSendEvent(
                file: _paths.first,
              ),
            );
      }
    } catch (e) {
      print(e);
    }
  }

  Future _info(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(
              "Le changement de votre photo de profil n'est pas pris en charge sur MacOs (utilisez un mobile ou la version Web)"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileUpdateImageBloc, ProfileUpdateImageState>(
      listener: (context, state) {
        if (state is ProfileUpdateImageUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Profile updated"),
            duration: Duration(
              seconds: 4,
            ),
          ));

          context.read<ProfileAvatarBloc>().add(ProfileAvatarRefreshEvent(
                photoURL: state.profileModel.photoURL,
              ));
        }
      },
      builder: (context, state) => Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          ProfileAvatarComponent(
            photoURL: profileModel.photoURL,
          ),
          ClipOval(
            child: Material(
              color: Colors.green,
              child: InkWell(
                splashColor: kCTAColor,
                onTap: state is ProfileUpdateImageUpdatingState
                    ? null
                    : () async {
                        if (!UniversalPlatform.isMacOS) {
                          _uploadFile(context);
                        } else {
                          _info(context);
                        }
                      },
                child: SizedBox(
                  width: 35,
                  height: 35,
                  child: state is ProfileUpdateImageUpdatingState
                      ? SpinKitThreeBounce(
                          color: Colors.white,
                          size: 10.0,
                        )
                      : Icon(
                          !UniversalPlatform.isMacOS
                              ? Icons.camera_alt_rounded
                              : Icons.info,
                          size: 18.0,
                          color: Colors.white,
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
