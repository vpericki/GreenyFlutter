import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:greeny_flutter_app/Presentation/Screens/QRCode/UI/qrcode.dart';
import 'package:greeny_flutter_app/business_logic/cubit/Navbar/navbar_cubit.dart';
import 'package:greeny_flutter_app/business_logic/cubit/Navbar/navbar_items.dart';
import '../../Achievements/UI/achievements.dart';
import '../../Dashboard/UI/dashboard.dart';

class _Home extends State<Home> {
  int _selectedIndex = 2;

  static const List<Widget> _widgetOptions = <Widget>[
    QRCode(),
    Achievements(),
    Dashboard(title: "Your profile"),
  ];

  void _onItemTapped(int index) {
    if (index == 0) {
      BlocProvider.of<NavbarCubit>(context).getNavbarItem(NavbarItem.qrcode);
    } else if (index == 1) {
      BlocProvider.of<NavbarCubit>(context)
          .getNavbarItem(NavbarItem.achievements);
    } else if (index == 2) {
      BlocProvider.of<NavbarCubit>(context).getNavbarItem(NavbarItem.dashboard);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return Center(child: _widgetOptions.elementAt(state.index));
        },
      ),
      bottomNavigationBar: BlocBuilder<NavbarCubit, NavbarState>(
        builder: (context, state) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.qr_code), label: "ScanQR"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.star), label: "Achievements"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "Dashboard"),
            ],
            fixedColor: Colors.white,
            currentIndex: state.index,
            onTap: _onItemTapped,
          );
        },
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _Home createState() => _Home();
}
