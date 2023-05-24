import 'package:dio/dio.dart';
import 'package:emmitra/models/directions_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionRepo {
  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/directions/json?";
  final Dio _dio;

  DirectionRepo({dio}) : _dio = dio ?? Dio();

  Future<Directions> getDirection(
      {required LatLng origin, required LatLng destination}) async {
    final response = await _dio.get(_baseUrl, queryParameters: {
      'origin': "${origin.latitude},${origin.longitude}",
      'destination': "${destination.latitude},${destination.longitude}",
      'key': "AIzaSyB90MNbOztaQ7riWjotC_Jv9tZm5PMe3iE"
    });
    // if (response.statusCode == 200) {
    return Directions.fromMap(response.data);
    // }
    // return null;
  }
}
