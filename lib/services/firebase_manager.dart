import 'package:admin/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseManager {
  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Map? tokens;

  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    getTokenPrices();
  }

  static Future getTokenPrices() async {
    DatabaseEvent event = await database.ref().child('token_prices').once();
    DataSnapshot snapshot = event.snapshot;

    tokens = snapshot.value as Map?;
  }

  static Future saveTokenPrice(String address, Map data, String chain) async {
    await database.ref().child('token_prices').child(chain).child(address).set(data);
  }

  static Future refresh() async {
    DatabaseEvent event = await database.ref().child('lastUpdated').once();

    DataSnapshot snapshot = event.snapshot;

    if (snapshot.value == null) {
      await database.ref().child('lastUpdated').set(DateTime.now().millisecondsSinceEpoch);
      return true;
    } else {
      int lastUpdated = snapshot.value as int;

      if (DateTime.now().millisecondsSinceEpoch - lastUpdated > 1000 * 60 * 60 * 1) {
        await database.ref().child('lastUpdated').set(DateTime.now().millisecondsSinceEpoch);
        return true;
      } else {
        return false;
      }
    }
  }
}
