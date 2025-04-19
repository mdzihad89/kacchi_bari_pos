import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachi_bari_pos/features/home/presentation/bloc/home_bloc.dart';
import 'package:kachi_bari_pos/service_locator.dart';
import 'package:paged_datatable/l10n/generated/l10n.dart';
import 'core/app/app_router.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'features/cart/presentation/bloc/cart_bloc.dart';
import 'features/contact/presentation/bloc/contact_bloc/contact_bloc.dart';
import 'features/order/presentation/bloc/order_bloc.dart';


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
        BlocProvider<OrderBloc>(
          create: (context)=>instance<OrderBloc>(),
        ),
        BlocProvider<ContactBloc>(
          create: (context)=>instance<ContactBloc>(),
        ),

      ],
      child: MaterialApp.router(
        localizationsDelegates: const [
          PagedDataTableLocalization.delegate
        ],
        routerConfig: AppRouter().router,
        title: 'Kacchi Bari',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple,brightness: Brightness.dark),
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

