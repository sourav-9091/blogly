import 'package:blog_firebase/core/resources/theme_manager.dart';
import 'package:blog_firebase/features/auth/presentation/auth/auth_bloc.dart';
import 'package:blog_firebase/features/auth/presentation/pages/sign_in_page.dart';
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
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blogly',
      theme: ThemeManager.darkThemeMode,
      home: SignInPage(),
    );
  }
}
