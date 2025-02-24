import 'package:geocoding/geocoding.dart';

class GetLocationName {
  static Future<String?> getLocationName(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);

      if (placemarks.isNotEmpty) {
        String? locationName;
        return locationName =
            '${placemarks[0].locality}, ${placemarks[0].country}';
      } else {
        return null; // If no placemarks found
      }
    } catch (e) {
      // Throw an exception instead of returning an error string
      throw Exception("Error getting location name: $e");
    }
  }
}
