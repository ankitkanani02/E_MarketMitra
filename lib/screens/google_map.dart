import 'package:emmitra/screens/homeDemo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'package:location/location.dart';

class GoogleMapApi extends StatefulWidget {
  final latitude;
  final longitude;

  const GoogleMapApi({Key? key, this.latitude = null, this.longitude = null})
      : super(key: key);

  @override
  State<GoogleMapApi> createState() => _GoogleMapApiState();
}

class _GoogleMapApiState extends State<GoogleMapApi> {
  Completer<GoogleMapController> _controller = Completer();
  Location _location = Location();
  late final CameraPosition _kLake;
  late var shoplati;
  late var shoplongi;

  Set<Marker> _markers = {};

  _style(double fontsize) {
    return TextStyle(
      fontFamily: 'Outfit',
      color: const Color(0xFF0F1113),
      fontSize: fontsize,
      fontWeight: FontWeight.normal,
    );
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(21.763032835661125, 72.14872560595875),
    zoom: 11,
  );

  Future<void> getShopLocation() async {
    final GoogleMapController controller = await _controller.future;
    // var location = await _location.getLocation();

    // controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId('ShopLocation'),
          infoWindow: const InfoWindow(title: "Shop Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
          position: LatLng(
              shoplati ?? 21.76353606785761, shoplongi ?? 72.12294900893889),
        ),
      );
    });
    // _location.onLocationChanged.listen(
    //   (l) {
    //     controller.animateCamera(
    //       CameraUpdate.newCameraPosition(
    //         CameraPosition(target: LatLng(shoplati!, shoplongi!), zoom: 15),
    //       ),
    //     );
    //     setState(() {
    //       _markers.add(
    //         Marker(
    //           markerId: MarkerId('ShopLocation'),
    //           infoWindow: const InfoWindow(title: "Shop Location"),
    //           position: LatLng(shoplati ?? 21.76353606785761,
    //               shoplongi ?? 72.12294900893889),
    //         ),
    //       );
    //     }
    //     );
    //   },
    // );
  }

  Future<void> getCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    var location = await _location.getLocation();

    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    _location.onLocationChanged.listen(
      (l) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 12),
          ),
        );

        setState(() {
          _markers.add(Marker(
              markerId: MarkerId('Your Location'),
              infoWindow: InfoWindow(title: "Your Location"),
              position: LatLng(l.latitude ?? 21.76353606785761,
                  l.longitude ?? 72.12294900893889)));
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    print("-------------------------------------------------");

    shoplati = double.parse(widget.latitude);
    shoplongi = double.parse(widget.longitude);
    _kLake = CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(shoplati, shoplongi),
        tilt: 59.440717697143555,
        zoom: 10);
    print(shoplati);
    print(shoplongi);
    getCurrentLocation();
    getShopLocation();
    // setState(() {
    //   getCurrentLocation();
    //   // getLocation();
    //   // getShopLocation();
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Color(0xFF0F1113),
            size: 30,
          ),
          onPressed: () async {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return HomeDemo();
            }));
          },
        ),
        title: Text('Navigation', style: _style(22)),
        backgroundColor: Colors.white,
      ),
      body: GoogleMap(
        compassEnabled: true,
        buildingsEnabled: true,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
        initialCameraPosition: _kGooglePlex,
        // myLocationEnabled: true,
        mapType: MapType.normal,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // await getCurrentLocation();
            // if (shoplati != null && shoplongi != null) {
            //   await getShopLocation();
            // }
            getShopLocation();
          },
          // onPressed: () => _controller,
          child: const Icon(Icons.center_focus_strong)),
    );
  }
}
