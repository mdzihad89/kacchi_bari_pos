import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_window_close/flutter_window_close.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachi_bari_pos/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kachi_bari_pos/features/home/presentation/bloc/home_bloc.dart';
import 'package:kachi_bari_pos/features/home/presentation/bloc/home_state.dart';
import 'package:kachi_bari_pos/features/order/presentation/screen/order_screen.dart';
import 'package:kachi_bari_pos/features/expense/presentation/screen/expense_screen.dart';
import '../../../../core/constants/color_constants.dart';
import '../../../../core/network/network_info.dart';
import '../../../../service_locator.dart';
import '../../../auth/data/model/user_model.dart';
import '../../../auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/event/auth_event.dart';
import '../../../auth/presentation/bloc/state/auth_state.dart';
import '../../../contact/presentation/contact_widget.dart';
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
    const ExpenseScreen(),
    const ContactWidget(),
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
    FlutterWindowClose.setWindowShouldCloseHandler(() async {
      return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
                title: const Text('Do you really want to quit?'),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Yes')),
                  TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('No')),
                ]);
          });
    });


    super.initState();
  }

  OverlayEntry? overlayEntry;

  void _toggleNotificationPanel(BuildContext context) {
    if (overlayEntry == null) {
      overlayEntry = _createOverlayEntry(context);
      Overlay.of(context).insert(overlayEntry!);
    } else {
      _removeOverlay();
    }
  }

  void _removeOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  int unreadCount = 3;
  List<Map<String, String>> notifications = [
    {
      "title": "New Order Received",
      "message": "Order #123 has been placed",
      "isRead": "false"
    },
    {
      "title": "Stock Alert",
      "message": "Item X is low on stock",
      "isRead": "false"
    },
    {"title": "Reminder", "message": "Meeting at 5 PM", "isRead": "false"},
  ];

  OverlayEntry _createOverlayEntry(BuildContext context) {
    RenderBox renderBox = context.findRenderObject() as RenderBox;
    Offset position = renderBox.localToGlobal(Offset.zero);
    double height = MediaQuery.of(context).size.height;

    return OverlayEntry(
      builder: (context) => Stack(
        children: [
          GestureDetector(
            onTap: _removeOverlay,
            behavior: HitTestBehavior.opaque,
            child: Container(color: Colors.transparent),
          ),
          Positioned(
            top: position.dy + 50,
            right: 30,
            width: 400,
            child: Material(
              elevation: 10.0,
              color: ColorConstants.cardBackgroundColor,
              borderRadius: BorderRadius.circular(5),
              child: Container(
                width: 400,
                height: height * 0.8,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: ColorConstants.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: const [
                    BoxShadow(color: Colors.black38, blurRadius: 10)
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Notifications',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        IconButton(
                          onPressed: _removeOverlay,
                          icon: const Icon(Icons.close),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: notifications.length,
                        itemBuilder: (context, index) {
                          return Card(
                              child: ListTile(
                            title: Text(notifications[index]['title']!),
                            subtitle: Text(notifications[index]['message']!),
                            onTap: () {
                              setState(() {
                                notifications[index]['isRead'] = "true";
                                unreadCount = unreadCount - 1;
                              });
                              _removeOverlay();
                            },
                          ));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
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
                  const SizedBox(width: 20),
                ],
              ),
              actions: [
                Text(
                  state.user.branchName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () async {
                    await showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) {
                        return BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Dialog(
                            elevation: 40,
                            insetPadding:
                                const EdgeInsets.symmetric(vertical: 20),
                            backgroundColor: const Color(0xFF393636),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            child:
                                StatefulBuilder(builder: (context, setState) {
                              return const CalculatorScreen();
                            }),
                          ),
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.calculate_outlined,
                    color: ColorConstants.primaryColor,
                    size: 40,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _toggleNotificationPanel(context);
                    },
                    icon: Badge.count(
                      count: unreadCount,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      child: const Icon(
                        Icons.notifications_none_outlined,
                        color: ColorConstants.primaryColor,
                        size: 40,
                      ),
                    )),
                const SizedBox(width: 20),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: state.user.image.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            height: 40,
                            fit: BoxFit.cover,
                            imageUrl: state.user.image,
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        )
                      : CircleAvatar(
                          backgroundColor: ColorConstants.primaryColor,
                          radius: 20,
                          child: Text(
                              state.user.name.split("").first.toUpperCase())),
                ),
              ],
            ),
            body: _widgetOptions.elementAt(_selectedIndex),
            drawer: Drawer(
              child: Column(
                children: [
                  DrawerHeader(
                    padding: EdgeInsets.zero,
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeLoaded) {
                        return CachedNetworkImage(
                          imageUrl: state.branchModel.image,
                          fit: BoxFit.cover,
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        );
                      } else {
                        return const SizedBox();
                      }
                    }),
                  ),
                  ListTile(
                    title: const Text('Expense'),
                    onTap: () {
                      showDialog(context: context, builder: (context) {
                        final TextEditingController passController = TextEditingController();
                        bool passwordVisible = true;
                        final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

                        return StatefulBuilder(
                          builder: (context,setState) {
                            return AlertDialog(
                              title: Center(child: Text("Password")),
                              content: Form(
                                key: _formKey,
                                child: TextFormField(
                                  controller: passController,
                                  maxLines: 1,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  style: GoogleFonts.inter(
                                    color: const Color(0xFF4F4F4F),
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Password can't be empty";
                                    }
                                    if(value!=state.user.mobile){
                                      return "Password doesn't match";
                                    }
                                    return null;
                                  },
                                  obscureText: passwordVisible,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      icon: Icon(passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off),
                                      onPressed: () {
                                        setState(
                                              () {
                                            passwordVisible = !passwordVisible;
                                          },
                                        );
                                      },
                                    ),
                                    filled: true,
                                    fillColor: const Color(0xFF16181B),
                                    border: InputBorder.none,
                                    hintText: "Password",
                                    hintStyle: GoogleFonts.inter(
                                      color: const Color(0xFF4F4F4F),
                                      fontSize: 16,
                                    ),


                                  ),
                                ),
                              ),

                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.pop(context);
                                }, child: const Text("Cancel"),
                                ),
                                TextButton(onPressed: () {
                                  if(_formKey.currentState!.validate()){
                                     Navigator.pop(context);
                                      _onButtonPressed(3);
                                     Navigator.pop(context);

                                  }

                                },
                                    child: Text("Submit")),
                              ],
                            );
                          }
                        );

                      },);


                    },
                  ),
                  ListTile(
                    title: const Text('Contact'),
                    onTap: () {



                      _onButtonPressed(4);
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: TextButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(SignOutRequested());
                      },
                      child: Text("Log out",style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: ColorConstants.primaryColor,fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
