import 'package:admin/controllers/MenuProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MenuProvider menuProvider = context.watch<MenuProvider>();

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Crypto Wallets",
            svgSrc: "assets/icons/chains/ethereum.svg",
            press: () {
              context.vRouter.to('/dashboard');
              menuProvider.closeMenu();
            },
          ),
          DrawerListTile(
            title: "Bank Accounts",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              context.vRouter.to('/bankaccounts');
              menuProvider.closeMenu();
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: Colors.white54,
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
