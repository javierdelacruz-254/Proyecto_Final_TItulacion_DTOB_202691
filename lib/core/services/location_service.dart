import 'package:geolocator/geolocator.dart';

class LocationService {

  static Future<Position> obtenerUbicacion() async {

    bool servicioHabilitado =
        await Geolocator.isLocationServiceEnabled();

    if (!servicioHabilitado) {
      throw Exception("Ubicación desactivada");
    }

    LocationPermission permiso =
        await Geolocator.checkPermission();

    if (permiso == LocationPermission.denied) {
      permiso = await Geolocator.requestPermission();
    }

    return await Geolocator.getCurrentPosition();
  }
}
