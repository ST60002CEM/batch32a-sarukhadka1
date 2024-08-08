import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:final_assignment/core/common/show_my_snackbar.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/dashboard_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/profile_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/wishlist_view.dart';
import 'package:final_assignment/features/home/presentation/view/bottom_view/booking_view.dart';
import 'package:final_assignment/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:final_assignment/features/profile/presentation/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  int selectedIndex = 0;
  List<Widget> lstScreen = [
    const DashboardView(),
    const WishlistView(),
    const BookingView(),
    //const HomeeView(),
    const ProfileView()
  ];
  bool showYesNoDialog = true;
  bool isDialogShowing = false;

  List<double> _gyroscopeValues = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];

  @override
  // void initState() {
  //   _streamSubscription.add(gyroscopeEvents!.listen((GyroscopeEvent event) {
  //     setState(() {
  //       _gyroscopeValues = <double>[event.x, event.y, event.z];

  //       _checkGyroscopeValues(_gyroscopeValues);
  //     });
  //   }));

  //   super.initState();
  // }

  // void _checkGyroscopeValues(List<double> values) async {
  //   const double threshold = 5; // Example threshold value, adjust as needed
  //   if (values.any((value) => value.abs() > threshold)) {
  //     if (showYesNoDialog && !isDialogShowing) {
  //       isDialogShowing = true;
  //       final result = await AwesomeDialog(
  //         context: context,
  //         dialogType: DialogType.warning,
  //         title: 'Logout',
  //         desc: 'Are You Sure You Want To Logout?',
  //         btnOkOnPress: () {
  //           ref.read(homeViewModelProvider.notifier).logout();
  //         },
  //         btnCancelOnPress: () {},
  //       ).show();

  //       isDialogShowing = false;
  //       if (result) {
  //         showMySnackBar(
  //           message: 'Logged Out Successfully!',
  //           color: Colors.green,
  //         );
  //       }
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: lstScreen[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Wislist',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.home),
          //   label: 'Home',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Bookings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
