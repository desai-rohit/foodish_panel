import 'package:flutter/material.dart';

class AddAddressProvider extends ChangeNotifier {
  TextEditingController areaController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  double lat = 0;
  double lng = 0;

  latlang({latitude, longitude}) {
    lat = latitude;
    lng = longitude;
  }
}
