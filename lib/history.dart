import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idm_phone/data.dart';
import 'package:idm_phone/maps.dart';

class IdmHistory extends StatelessWidget {
  const IdmHistory({Key? key, required this.data}) : super(key: key);

  final IdmData data;

  @override
  Widget build(BuildContext context) {
    List<Widget> _w = [];

    for (var e in data.path) {
      _w.add(
        Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${e.iceFill.toStringAsFixed(1)}%",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        e.scanDate.toString(),
                      ),
                    ],
                  ),
                  MaterialButton(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue),
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.place,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "Карта",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                                  body: CusMap(
                                    points: data.getLatLng(),
                                    cam: CameraPosition(target: e.pos),
                                  ),
                                  appBar: AppBar(title: Text("Просмотр точки")),
                                )),
                      );
                    },
                    padding: EdgeInsets.zero,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scrollbar(
      child: ListView(
        children: _w,
      ),
      isAlwaysShown: true,
      radius: Radius.circular(10),
    );
  }
}
