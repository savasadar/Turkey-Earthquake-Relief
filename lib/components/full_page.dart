import 'package:admin/components/responsive.dart';
import 'package:admin/components/side_menu.dart';
import 'package:admin/services/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class FullPage extends StatefulWidget {
  final Widget? child;

  const FullPage({Key? key, this.child}) : super(key: key);
  
  @override
  State<FullPage> createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  @override
  Widget build(BuildContext context) {

    MenuProvider menuProvider = context.watch<MenuProvider>();

    return Scaffold(
      key: menuProvider.scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: widget.child ?? Placeholder(),
            ),
          ],
        ),
      ),
    );
  }
}