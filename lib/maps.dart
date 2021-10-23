import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:math';

class IcePolygon {
  final List<LatLng> points;
  final int id;

  IcePolygon({required this.points, required this.id});
}

class CusMap extends StatefulWidget {
  const CusMap({
    Key? key,
    required this.points,
    this.ice,
    this.cam,
  }) : super(key: key);

  final List<LatLng> points;
  final List<IcePolygon>? ice;
  final CameraPosition? cam;

  @override
  State<CusMap> createState() => _CusMapState();
}

class _CusMapState extends State<CusMap> {
  final Completer<GoogleMapController> _controller = Completer();

  late CameraPosition _kCam;

  double scale = 25, zoom = 18;

  Set<Circle> circles = {};
  Set<Polygon> ice = {};

  @override
  void initState() {
    for (var e in widget.points) {
      Color color = Colors.blue;

      if (widget.cam != null && widget.cam!.target == e) {
        color = Colors.red;
      }

      circles.add(
        Circle(
          circleId: CircleId(
            "circle_${e.latitude.toString()}_${e.longitude.toString()}",
          ),
          center: e,
          radius: 5,
          strokeColor: Colors.white,
          strokeWidth: 1,
          fillColor: color,
        ),
      );
    }

    if (widget.ice != null) {
      for (var e in widget.ice!) {
        ice.add(
          Polygon(
            polygonId: PolygonId("ice_${e.id.toString()}"),
            points: e.points,
            strokeWidth: 2,
            strokeColor: Colors.white,
            fillColor: Colors.lightBlue,
          ),
        );
      }
    }

    _kCam = CameraPosition(
      target: widget.points[0],
      zoom: 18,
    );

    if (widget.cam != null) {
      _kCam = CameraPosition(
        target: widget.cam!.target,
        zoom: 18,
      );
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          polylines: {
            Polyline(
              points: widget.points,
              polylineId: const PolylineId("fill"),
              width: 10,
              color: Colors.white,
            ),
            Polyline(
              points: widget.points,
              polylineId: const PolylineId("stroke"),
              width: 5,
              color: Colors.blue,
            ),
          },
          circles: circles,
          mapType: MapType.hybrid,
          initialCameraPosition: _kCam,
          onCameraMove: (pos) {
            setState(() {
              scale = (pow(2, 21 - pos.zoom).toDouble() * 256) / 65.52;
              zoom = pos.zoom.toDouble();
            });
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Positioned.fill(
          child: Align(
            child: Column(
              children: [
                Text(
                  "${scale.toStringAsFixed(2)}m",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    shadows: [Shadow(blurRadius: 20)],
                  ),
                ),
                Container(
                  width: 128,
                  height: 5,
                  color: Colors.white,
                ),
                const Text(
                  "масштаб приблизителен",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                    shadows: [Shadow(blurRadius: 20)],
                  ),
                ),
              ],
              mainAxisSize: MainAxisSize.min,
            ),
            alignment: const Alignment(0, 0.9),
          ),
        ),
      ],
    ));
  }
}
