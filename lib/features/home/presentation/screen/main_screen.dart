import 'dart:developer';
import 'dart:ui';

import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kachi_bari_pos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kachi_bari_pos/features/order/presentation/screen/order_screen.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/network/network_info.dart';
import '../../../../service_locator.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/event/auth_event.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../../order/presentation/screen/unsync_order_screen.dart';
import '../widgets/calculator_screen.dart';
import 'new_order_screen.dart';

class MainScreen extends StatefulWidget {
  final User? user;

  const MainScreen({super.key, this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _widgetOptions = <Widget>[
    const NewOrderScreen(),
    const OrderScreen(),
    const UnSyncedOrderScreen(),
  ];

  int _selectedIndex = 0;

  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    if (widget.user == null) {
      context.read<AuthBloc>().add(GetUserData());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async{
        if (state is UnAuthenticated) {
          context.replace('/login');
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is AuthError) {
          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          );
        }
        if (state is Authenticated) {
          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            appBar: AppBar(
              backgroundColor: ColorConstants.cardBackgroundColor,
              title: Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(0);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(150, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "New Order",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(1);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "All Order",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(2);
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 40),
                      backgroundColor: ColorConstants.primaryColor,
                      shape: const RoundedRectangleBorder(),
                    ),
                    child: Text(
                      "UnSynced Order",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () async{
                    await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return BackdropFilter(
                          filter:  ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Dialog(
                            elevation: 40,
                              insetPadding: const EdgeInsets.symmetric(vertical: 20),
                              backgroundColor: Color(0xFF393636),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              child: StatefulBuilder(
                                  builder: (context,setState) {
                                    return  CalculatorScreen();
                                  }
                              )
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(Icons.calculate_outlined,color: ColorConstants.primaryColor,size: 40,),
                ),
                const SizedBox(width: 20),
                Text(
                  state.user.branchName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: PopupMenuButton(
                    child: state.user.image.isNotEmpty? CircleAvatar(
                      backgroundColor: ColorConstants.primaryColor,
                      radius: 20,
                      backgroundImage: NetworkImage(state.user.image)  ,
                    ):CircleAvatar(
                      backgroundColor: ColorConstants.primaryColor,
                      radius: 20,
                      child: Text(state.user.name.split("").first.toUpperCase())
                    ),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          value: 'logout',
                          child: Text('Logout'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                     if (value == "logout") {
                        context.read<AuthBloc>().add(SignOutRequested());
                      }
                    },
                  ),
                ),
              ],
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
