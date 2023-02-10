import 'package:help2turkey/utils/constants.dart';
import 'package:help2turkey/screens/bank_accounts/bank_accounts.dart';
import 'package:help2turkey/screens/crypto_wallets/crypto_wallets.dart';
import 'package:help2turkey/components/full_page.dart';
import 'package:help2turkey/screens/information_sources/sources.dart';
import 'package:help2turkey/services/firebase_manager.dart';
import 'package:help2turkey/services/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vrouter/vrouter.dart';

import 'services/providers/menu_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await FirebaseManager.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MenuProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => DonationProvider(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return VRouter(
        debugShowCheckedModeBanner: false,
        title: 'Turkey Earthquake Donation Sources',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: bgColor,
          textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: Colors.white),
          canvasColor: secondaryColor,
        ),
        mode: VRouterMode.history,
        transitionDuration: Duration.zero,
        routes: [
          VNester(
            path: '/',
            widgetBuilder: (child) => FullPage(child: child),
            nestedRoutes: [
              VWidget(path: '/', widget: DashboardScreen()),
              VWidget(path: 'dashboard', widget: DashboardScreen()),
              VWidget(path: 'bankaccounts', widget: BankAccountsScreen()),
              VWidget(path: 'sources', widget: SourcesScreen()),
              VRouteRedirector(
                redirectTo: 'dashboard',
                path: r'*',
              ),
            ],
          )
        ]);
  }
}
