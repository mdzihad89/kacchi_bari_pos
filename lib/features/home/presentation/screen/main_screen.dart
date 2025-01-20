import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/color_constants.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/event/auth_event.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import 'new_order_screen.dart';

class MainScreen extends StatefulWidget {
  final User? user;
  const MainScreen({super.key, this.user});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  final List<Widget> _widgetOptions = <Widget>[
    NewOrderScreen(),
    Center(child: Text('All Order')),
    Center(child: Text('Due Order')),
  ];

  int _selectedIndex = 0;
  void _onButtonPressed(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {

    if(widget.user == null){
      context.read<AuthBloc>().add(GetUserData());
    }


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is UnAuthenticated) {
          context.replace('/login');
        }
      },
      builder: (context, state) {
        if(state is AuthLoading){
          return const Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }else if(state is AuthError){
          return Scaffold(
            backgroundColor: ColorConstants.backgroundColor,
            body: Center(
              child: Text(state.message,style: Theme.of(context).textTheme.bodyMedium,),
            ),
          );
        }else if(state is Authenticated){

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
                    child: Text("New Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
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
                    child: Text("All Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
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
                    child: Text("Due Order", style: Theme
                        .of(context)
                        .textTheme
                        .bodyMedium,),
                  ),
                ],
              ),
              actions: [
                Text(
                  state.user.branchName,
                  style: Theme
                      .of(context)
                      .textTheme
                      .bodyMedium,
                ),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: PopupMenuButton(
                    child: CircleAvatar(
                      backgroundColor: ColorConstants.primaryColor,
                      radius: 20,
                      child: state.user.image == ""
                          ? Text(state.user.name
                          .split("")
                          .first
                          .toUpperCase())
                          : Image.network(state.user.image),
                    ),
                    itemBuilder: (context) {
                      return [

                        const PopupMenuItem(
                          value: 'profile',
                          child: Text('Profile'),
                        ),

                        const PopupMenuItem(
                          value: 'logout',
                          child: Text('Logout'),
                        ),
                      ];
                    },
                    onSelected: (value) {
                      if (value == "profile") {} else if (value == "logout") {
                        context.read<AuthBloc>().add(SignOutRequested());
                      }
                    },
                  ),
                ),
              ],
            ),

            body: _widgetOptions.elementAt(_selectedIndex),
          );
        }else{

          return const SizedBox();

        }

      },

    );
  }
}
