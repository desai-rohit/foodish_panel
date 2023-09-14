import 'package:flutter/material.dart';
import 'package:food_app_panel/const.dart';
import 'package:food_app_panel/pages/add_address/addAddress_provider.dart';
import 'package:food_app_panel/pages/bottom_nav.dart';
import 'package:food_app_panel/pages/user/profile_page.dart';
import 'package:food_app_panel/pages/user/userprovider.dart';
import 'package:food_app_panel/services/api_services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({super.key});

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {
  GoogleMapController? googleMapController;
  final Map<String, Marker> _marker = {};

  // double lat = 22.634192;
  // double lng = 79.610161;

  @override
  void initState() {
    super.initState();
    checkPermission(Permission.location, context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false)
          .getRestaurantWonerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AddAddressProvider>(
        builder: (context, provider, child) {
          return provider.lat == 0
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Expanded(
                      child: GoogleMap(
                        onTap: (LatLng latlng) {
                          provider.latlang(
                              latitude: latlng.latitude,
                              longitude: latlng.longitude);

                          addmarker(
                              "test1", LatLng(provider.lat, provider.lng));
                        },
                        onMapCreated: (controller) {
                          googleMapController = controller;
                        },
                        markers: _marker.values.toSet(),
                        initialCameraPosition: CameraPosition(
                            target: LatLng(provider.lat, provider.lng),
                            zoom: 15),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            onPressed: () async {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      padding: const EdgeInsets.all(16),
                                      child: Column(
                                        children: [
                                          const Text(
                                            "Enter Complete Address",
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          TextField(
                                            controller: provider.areaController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText: 'Area/Sector/Locality',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          TextField(
                                            controller:
                                                provider.landmarkController,
                                            decoration: const InputDecoration(
                                              border: OutlineInputBorder(),
                                              labelText:
                                                  'Nearby LandMark(Optional)',
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16),
                                              color: Colors.grey.shade300,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 16),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8)),
                                                  ),
                                                  onPressed: () {
                                                    updateUser(
                                                            gmail:
                                                                currentEmail!,
                                                            lat: provider.lat
                                                                .toString(),
                                                            lng: provider.lng
                                                                .toString(),
                                                            area: provider
                                                                .areaController
                                                                .text,
                                                            landmark: provider
                                                                .landmarkController
                                                                .text)
                                                        .then((value) => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const ProfilePage())));
                                                  },
                                                  child: const Text(
                                                    "Save Address",
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                    ),
                                                  )))
                                        ],
                                      ),
                                    );
                                  });
                            },
                            child: const Text(
                              "Confirm Location",
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            )))
                  ],
                );
        },
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.only(
          bottom: 180,
        ),
        child: FloatingActionButton(
          backgroundColor: Colors.grey.shade100.withOpacity(0.8),
          onPressed: () {
            checkPermission(Permission.location, context);
          },
          child: const Icon(Icons.my_location),
        ),
      ),
    );
  }

  void addmarker(String markerid, LatLng location) {
    var marker = Marker(markerId: MarkerId(markerid), position: location);
    _marker[markerid] = marker;

    setState(() {});
  }

  Future<void> checkPermission(
      Permission permission, BuildContext context) async {
    final status = await permission.request();
    AddAddressProvider provider =
        // ignore: use_build_context_synchronously
        Provider.of<AddAddressProvider>(context, listen: false);
    if (status.isGranted) {
      await Geolocator.isLocationServiceEnabled()
          .then((enabled) => {if (enabled) {} else {}});

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      provider.lat = position.latitude;
      provider.lng = position.longitude;
      addmarker("test1", LatLng(provider.lat, provider.lng));

      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    } else if (status.isPermanentlyDenied) {
      // ignore: use_build_context_synchronously
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Location Enable'),
          content: const Text(
              'Kindly allow Permission from App Setting, without this permission app would not show maps'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pushAndRemoveUntil<void>(
                context,
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => const BottomNav()),
                ModalRoute.withName('/'),
              ),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () =>
                  openAppSettings().then((value) => const AddAddress()),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
