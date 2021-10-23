import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idm_phone/maps.dart';
import 'package:idm_phone/predefined.dart';

class IdmPathPoint {
  LatLng pos;
  DateTime scanDate;
  double iceFill;

  IdmPathPoint({
    required this.pos,
    required this.scanDate,
    required this.iceFill,
  });
}

class IdmData {
  late List<IdmPathPoint> path;
  late List<IcePolygon>? iceParts;

  List<LatLng> getLatLng() {
    List<LatLng> ret = [];

    for (var e in path) {
      ret.add(e.pos);
    }

    return ret;
  }

  // so because of no availability
  // to do real tests of copter
  // hardware/software, we
  // can only simulate data transfer.
  IdmData.fromSerial() {
    path = IdmPredefinedData().points;
    iceParts = null;
  }
}
