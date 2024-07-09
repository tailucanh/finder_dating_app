import 'package:geocoding/geocoding.dart';

Future<List<Placemark>> getLocationMap({required double latitude,required double longitude}) async {
  List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude, longitude);
  return placemarks;
}

Future<String?> getLocationCity({required double latitude,required double longitude}) async {
  List<Placemark> placemarks = await getLocationMap(latitude: latitude, longitude: longitude);
  return '${placemarks[0].administrativeArea}, ${placemarks[0].country}';
}
