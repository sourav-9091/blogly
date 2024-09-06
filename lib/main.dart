import 'package:blog_firebase/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_firebase/core/resources/theme_manager.dart';
import 'package:blog_firebase/features/auth/presentation/auth/auth_bloc.dart';
import 'package:blog_firebase/features/auth/presentation/pages/sign_in_page.dart';
import 'package:blog_firebase/features/blog/presentation/pages/blog_page.dart';
import 'package:blog_firebase/features/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => serviceLocator<AuthBloc>(),
      ),
      BlocProvider(
        create: (_) => serviceLocator<AppUserCubit>(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogly',
      theme: ThemeManager.darkThemeMode,
      home: BlocSelector<AppUserCubit, AppUserState, bool>(
        selector: (state) {
          return state is AppUserLoggedIn;
        },
        builder: (context, isLoggedIn) {
          print(isLoggedIn);
          if (isLoggedIn) {
            return BlogPage();
          }
          return SignInPage();
        },
      ),
    );
  }
}
