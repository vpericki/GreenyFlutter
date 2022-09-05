import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:greeny_flutter_app/business_logic/cubit/Navbar/navbar_items.dart';

part 'navbar_state.dart';

class NavbarCubit extends Cubit<NavbarState> {
  NavbarCubit() : super(const NavbarState(NavbarItem.dashboard, 2));

  void getNavbarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.qrcode:
        emit(const NavbarState(NavbarItem.qrcode, 0));
        break;

      case NavbarItem.achievements:
        emit(const NavbarState(NavbarItem.achievements, 1));
        break;

      case NavbarItem.dashboard:
        emit(const NavbarState(NavbarItem.dashboard, 2));
        break;
    }
  }
}
