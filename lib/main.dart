import 'package:chat/components/chat_groups_item/bloc/chat_groups_item_bloc.dart';
import 'package:chat/components/chat_groups_list_view/bloc/chat_group_list_view_bloc.dart';
import 'package:chat/components/chat_list_view/bloc/chat_list_view_bloc.dart';
import 'package:chat/components/chat_message_form/bloc/chat_message_form_bloc.dart';
import 'package:chat/components/profile_avatar/bloc/profile_avatar_bloc.dart';
import 'package:chat/components/profile_display_name/bloc/profile_display_name_bloc.dart';
import 'package:chat/components/profile_form_personal_data/bloc/profile_form_personal_data_bloc.dart';
import 'package:chat/components/profile_update_image/bloc/profile_update_image_bloc.dart';
import 'package:chat/config/theme.dart';
import 'package:chat/repositories/abstracts/authentication.dart';
import 'package:chat/repositories/abstracts/messaging.dart';
import 'package:chat/repositories/abstracts/profile.dart';
import 'package:chat/repositories/authentication_impl.dart';
import 'package:chat/repositories/messaging_impl.dart';
import 'package:chat/repositories/profile_impl.dart';
import 'package:chat/screens/auth/signin_screen.dart';
import 'package:chat/screens/auth/signup_screen.dart';
import 'package:chat/screens/home/home_screen.dart';
import 'package:chat/services/authentication/authentication_bloc.dart';
import 'package:chat/services/pageview/pageview_bloc.dart';
import 'package:chat/services/profile/profile_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseFunctions functions = FirebaseFunctions.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  String host = defaultTargetPlatform == TargetPlatform.android
      ? '10.0.2.2:8080'
      : 'localhost:8080';

  functions.useFunctionsEmulator(origin: 'http://localhost:5001');

  auth.useEmulator('http://localhost:9099');

  FirebaseFirestore.instance.settings = Settings(
    host: host,
    sslEnabled: false,
    // TODO: A supprimer
    persistenceEnabled: false,
  );

  runApp(App(
    auth: auth,
    firestore: firestore,
    functions: functions,
    storage: storage,
  ));
}

// ignore: must_be_immutable
class App extends StatelessWidget {
  FirebaseAuth auth;
  FirebaseFirestore firestore;
  FirebaseFunctions functions;
  FirebaseStorage storage;

  App({
    required this.auth,
    required this.firestore,
    required this.functions,
    required this.storage,
  }) : super();

  @override
  Widget build(BuildContext context) {
    AuthenticationRepository authenticationRepository =
        AuthenticationImplRepository(
      auth,
      firestore,
      functions,
    );

    // authenticationRepository.logout();

    ProfileRepository profileRepository = ProfileImplRepository(
      auth,
      firestore,
      functions,
      storage,
    );

    MessagingRepository messagingRepository = MessagingImplRepository(
      auth,
      firestore,
    );

    ChatGroupListViewBloc messagesItemsBloc =
        ChatGroupListViewBloc(messagingRepository);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(authenticationRepository)
            ..add(AuthenticationInitializeEvent()),
        ),
        BlocProvider(
          create: (context) =>
              ProfileBloc(profileRepository)..add(ProfileInitializeEvent()),
        ),
        BlocProvider(
          create: (context) => PageViewBloc()..add(PageViewInitializeEvent()),
        ),
        BlocProvider(
          create: (context) => messagesItemsBloc
            ..add(
              ChatGroupListViewInitializeEvent(),
            ),
        ),
        BlocProvider(
          create: (context) => ChatMessageFormBloc(messagingRepository),
        ),
        BlocProvider(
          create: (context) => ChatListViewBloc(messagingRepository),
        ),
        BlocProvider(
          create: (context) => ChatGroupsItemBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileUpdateImageBloc(profileRepository),
        ),
        BlocProvider(
          create: (context) => ProfileAvatarBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileDisplayNameBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileFormPersonalDataBloc(profileRepository)
            ..add(ProfileFormPersonalDataInitializeEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: CustomTheme.of(context),
        home: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is UnAuthenticatedState) {
              if (state.unAuthenticatedStatus == UnAuthenticatedStatus.logout) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUpScreen(),
                  ),
                  (route) => false,
                );
              }
            }
          },
          builder: (context, state) {
            if (state is UnAuthenticatedState) {
              return SignUpScreen();
            }

            if (state is AuthenticatedState) {
              return HomeScreen();
            }

            return Scaffold(
              body: Center(
                child: Text("loading"),
              ),
            );
          },
        ),
      ),
    );
  }
}
