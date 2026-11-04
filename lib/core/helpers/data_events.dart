import 'package:flutter/foundation.dart';

/// Tells the screens that show numbers (Home, Growth...) that something was
/// saved on the server, so they reload. Usage: DataEvents.instance.changed();
class DataEvents extends ChangeNotifier {
  DataEvents._();

  static final DataEvents instance = DataEvents._();

  void changed() => notifyListeners();
}
