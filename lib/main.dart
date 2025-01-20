import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachi_bari_pos/features/home/presentation/bloc/home_bloc.dart';
import 'package:kachi_bari_pos/service_locator.dart';
import 'core/app/app_router.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  initAppModule();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context)=>instance<AuthBloc>(),

        ),

        BlocProvider<HomeBloc>(
          create: (context)=>instance<HomeBloc>(),
        ),


        BlocProvider<CartBloc>(
          create: (context)=>instance<CartBloc>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter().router,
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: TextTheme(
            displaySmall: GoogleFonts.inter(fontSize: 11,fontWeight: FontWeight.w500, color: Colors.white),
            bodySmall: GoogleFonts.inter(fontSize: 13,fontWeight: FontWeight.w500, color: Colors.white),
            bodyMedium: GoogleFonts.inter(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
            bodyLarge: GoogleFonts.inter(fontSize: 19,  fontWeight: FontWeight.w800, color: Colors.white),
            titleMedium: GoogleFonts.inter(fontSize: 25, color: Colors.white , fontWeight: FontWeight.bold),
            titleLarge: GoogleFonts.inter(fontSize: 38, color: Colors.white , fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

