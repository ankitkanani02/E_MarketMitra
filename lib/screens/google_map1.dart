import 'package:emmitra/models/directions_model.dart';
import 'package:emmitra/screens/direction_repo.dart';
import 'package:emmitra/screens/homeDemo.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapPage extends StatefulWidget {
  final latitude;
  final longitude;
  final isLatLangSet;

  const GoogleMapPage(
      {Key? key,
      this.latitude = null,
      this.longitude = null,
      this.isLatLangSet = true})
      : super(key: key);
  @override
  State<GoogleMapPage> createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {
  late GoogleMapController _controller;
  Location _location = Location();
  var _info;

  late var shoplati;
  late var shoplongi;
  var _origin;
  var _destination;
  var _shopLocation;

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(21.755948872923476, 72.14400964342323),
    zoom: 15,
  );

  @override
  void initState() {
    if (widget.latitude != null) {
      shoplati = double.parse(widget.latitude);
      shoplongi = double.parse(widget.longitude);
    }

    // setState(() {
    //   if (widget.isLatLangSet) {
    //   }
    // });
    // getShopLocation();

    getCurrentLocation();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
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
              return const HomeDemo();
            }));
          },
        ),
        title: Text('Navigation', style: _style(22)),
        backgroundColor: Colors.white,
        actions: [
          if (_origin != null)
            TextButton(
              onPressed: () {
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _origin.position, zoom: 17.5, tilt: 50),
                  ),
                );
              },
              child: const Text(
                "ORIGIN",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          if (_shopLocation != null)
            TextButton(
              onPressed: () {
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _shopLocation.position, zoom: 17.5, tilt: 50),
                  ),
                );
              },
              child: const Text(
                "DEST",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          if (_destination != null)
            TextButton(
              onPressed: () {
                _controller.animateCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: _destination.position, zoom: 17.5, tilt: 50),
                  ),
                );
              },
              child: const Text(
                "CUS.DEST",
                style: TextStyle(
                  fontFamily: 'Outfit',
                  color: Color(0xFF0F1113),
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          GoogleMap(
            markers: {
              if (_origin != null) _origin as Marker,
              if (_destination != null) _destination as Marker,
              if (_shopLocation != null) _shopLocation as Marker
            },
            myLocationButtonEnabled: false,
            // zoomControlsEnabled: true,
            myLocationEnabled: true,
            polylines: {
              if (_info != null)
                Polyline(
                    polylineId: const PolylineId("overview_polyline"),
                    color: Colors.red,
                    width: 4,
                    points: _info.polylinePoints
                        .map<LatLng>((e) => LatLng(e.latitude, e.longitude))
                        .toList())
            },
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (controller) => _controller = controller,
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              top: 20,
              child: Container(
                child: Text(
                  "${_info.totalDistance}, ${_info.totalDuration}",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w800),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                decoration: const BoxDecoration(
                    color: Colors.yellowAccent,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 2),
                          blurRadius: 6.0)
                    ]),
              ),
            )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          getShopLocation();

          final directions = await DirectionRepo().getDirection(
              origin: _origin.position, destination: _shopLocation.position);
          setState(() {
            _info = directions as Directions;
          });
          // _controller.animateCamera(
          //     CameraUpdate.newCameraPosition(_initialCameraPosition));
        },
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }

  _style(double fontsize) {
    return TextStyle(
      fontFamily: 'Outfit',
      color: const Color(0xFF0F1113),
      fontSize: fontsize,
      fontWeight: FontWeight.normal,
    );
  }

  Future<void> getShopLocation() async {
    // var location = await _location.getLocation();

    // controller.animateCamera(CameraUpdate.newCameraPosition(_kGooglePlex));

    // setState(() {
    //   _shopLocation = Marker(
    //     markerId: MarkerId('ShopLocation'),
    //     infoWindow: const InfoWindow(title: "Shop Location"),
    //     icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
    //     position: LatLng(
    //         shoplati ?? 21.76353606785761, shoplongi ?? 72.12294900893889),
    //   );
    // });

    if (shoplati != null) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(shoplati!, shoplongi!), zoom: 15),
        ),
      );

      _shopLocation = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        markerId: const MarkerId('ShopLocation'),
        infoWindow: const InfoWindow(title: "Shop Location"),
        position: LatLng(
            shoplati ?? 21.76353606785761, shoplongi ?? 72.12294900893889),
      );
    }
  }

  Future<void> getCurrentLocation() async {
    var location = await _location.getLocation();

    // controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));

    _location.onLocationChanged.listen(
      (l) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 16),
          ),
        );
        setState(() {
          _origin = Marker(
            markerId: const MarkerId('Your Location'),
            infoWindow: const InfoWindow(title: "Your Location"),
            position: LatLng(
              l.latitude ?? 21.76353606785761,
              l.longitude ?? 72.12294900893889,
            ),
          );
        });
      },
    );
  }

  Future<void> _addMarker(LatLng argument) async {
    // if (_origin != null || (_origin != null && _destination != null)) {

    // setState(() {

    //   _origin = Marker(
    //       markerId: MarkerId("origin"),
    //       infoWindow: InfoWindow(title: "Your Location"),
    //       icon:
    //           BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    //       position: argument);
    // });
    // } else {
    setState(() {
      _destination = Marker(
          markerId: const MarkerId("destination"),
          infoWindow: const InfoWindow(title: "Shop Location"),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: argument);
    });

    final directions = await DirectionRepo().getDirection(
        origin: _origin.position, destination: _destination.position);
    setState(() {
      _info = directions as Directions;
    });

    // }
  }
}
