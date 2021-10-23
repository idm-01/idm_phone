// read comment to IdmData.fromSerial()
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idm_phone/data.dart';

class IdmPredefinedData {
  List<IdmPathPoint> points = [
    IdmPathPoint(
      pos: LatLng(57.812160, 28.359461),
      scanDate: DateTime.fromMillisecondsSinceEpoch(1634998541775),
      iceFill: 75.2,
    ),
    IdmPathPoint(
      pos: LatLng(57.812060, 28.359061),
      scanDate: DateTime.fromMillisecondsSinceEpoch(1634998541875),
      iceFill: 55.3,
    ),
    IdmPathPoint(
      pos: LatLng(57.811760, 28.358761),
      scanDate: DateTime.fromMillisecondsSinceEpoch(1634998541975),
      iceFill: 55.2,
    ),
  ];
}
