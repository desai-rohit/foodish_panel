import 'package:flutter/material.dart';
import 'package:food_app_panel/pages/profile_page.dart';
import 'package:food_app_panel/provider/App_provider.dart';
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

  double lat = 22.634192;
  double lng = 79.610161;

  // void _onMapCreated(GoogleMapController controller) {
  //   googleMapController = controller;
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<AppProvider>(context, listen: false).getRestaurantWonerData();
    });
  }

  @override
  Widget build(BuildContext context) {
    // double lat = 22.634192;
    // double lng = 79.610161;
    //final formKey = GlobalKey<FormState>();

    setState(() {
      lat;
      lng;
    });

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<AppProvider>(
        builder: (context, provider, child) {
          return

              //  provider.restaurantWonerData[0].address[0].lat == ""
              //     ?

              Column(
            children: [
              Expanded(
                child: GoogleMap(
                  onTap: (LatLng latlng) {
                    setState(() {
                      lat = latlng.latitude;
                      lng = latlng.longitude;

                      addmarker("test1", LatLng(lat, lng));
                    });
                  },
                  onMapCreated: (controller) {
                    googleMapController = controller;

                    // setState(() {
                    //   addmarker('test', LatLng(lat, Lng));
                    // });
                  },
                  markers: _marker.values.toSet(),
                  initialCameraPosition:
                      CameraPosition(target: LatLng(lat, lng), zoom: 4),
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.grey.shade300,
                  padding: const EdgeInsets.only(bottom: 8),
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Colors.red),
                      onPressed: () async {
                        // final url =
                        //     'https://www.google.com/maps/search/?api=1&query=$lat,$Lng';
                        // if (await canLaunch(url)) {
                        //   await launch(url);
                        // } else {
                        //   throw 'Could not launch $url';
                        // }
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
                                      controller: provider.landmarkController,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        labelText: 'Nearby LandMark(Optional)',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        color: Colors.grey.shade300,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                backgroundColor: Colors.red),
                                            onPressed: () {
                                              updateUser(
                                                      gmail:
                                                          provider.finalEmail!,
                                                      lat: lat.toString(),
                                                      lng: lng.toString(),
                                                      area: provider
                                                          .areaController.text,
                                                      landmark: provider
                                                          .landmarkController
                                                          .text)
                                                  .then((value) => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const ProfilePage())));
                                            },
                                            child: const Text(
                                              "Save Address",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            )))
                                  ],
                                ),
                              );
                            });
                      },
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )))
            ],
          );
          // : SizedBox(
          //     height: 500,
          //     child: Column(
          //       children: [
          //         GestureDetector(
          //           onTap: () {},
          //           child: ListTile(
          //             leading: const Icon(Icons.home),
          //             title: Text(
          //                 provider.restaurantWonerData[0].address[0].area),
          //             subtitle: Text(provider.restaurantWonerData[0]
          //                 .address[0].nearbyLandmark),
          //           ),
          //         ),
          //         Container(
          //             margin: const EdgeInsets.symmetric(horizontal: 16),
          //             width: MediaQuery.of(context).size.width,
          //             child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                     padding:
          //                         const EdgeInsets.symmetric(vertical: 16),
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(8)),
          //                     backgroundColor: Colors.red),
          //                 onPressed: () {
          //                   // Navigator.push(
          //                   //     context,
          //                   //     MaterialPageRoute(
          //                   //         builder: (context) => PaymentPage(
          //                   //               lat: lat.toString(),
          //                   //               lng: Lng.toString(),
          //                   //               House: data[0]
          //                   //                   .address[0]
          //                   //                   .flatHouseNo,
          //                   //               area:
          //                   //                   data[0].address[0].area,
          //                   //               landmark: data[0]
          //                   //                   .address[0]
          //                   //                   .nearbyLandmark,
          //                   //             )));
          //                 },
          //                 child: const Text(
          //                   "Continue",
          //                   style: TextStyle(
          //                       fontSize: 18, color: Colors.white),
          //                 ))),
          //         const SizedBox(
          //           height: 24,
          //         ),
          //         Container(
          //             margin: const EdgeInsets.symmetric(horizontal: 16),
          //             width: MediaQuery.of(context).size.width,
          //             child: ElevatedButton(
          //                 style: ElevatedButton.styleFrom(
          //                     padding:
          //                         const EdgeInsets.symmetric(vertical: 16),
          //                     shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(8)),
          //                     backgroundColor: Colors.red),
          //                 onPressed: () {},
          //                 child: const Text(
          //                   "Add New Address",
          //                   style: TextStyle(
          //                       fontSize: 18, color: Colors.white),
          //                 )))
          //       ],
          //     ));
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
    if (status.isGranted) {
      await Geolocator.isLocationServiceEnabled()
          .then((enabled) => {if (enabled) {} else {}});

      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      lat = position.latitude;
      lng = position.longitude;
      addmarker("test1", LatLng(lat, lng));

      // Provider.of<UserProvider>(context, listen: false)
      //     .latlag(position.latitude, position.longitude);

      CameraPosition(
          target: LatLng(position.latitude, position.longitude), zoom: 15);

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Granted")));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Permission is Denied")));
    }
  }
}
