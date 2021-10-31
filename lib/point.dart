import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:idm_phone/data.dart';
import 'package:idm_phone/maps.dart';

class PointInfo extends StatelessWidget {
  const PointInfo(
      {Key? key,
      required this.point,
      required this.data,
      this.isRecent = false,
      this.isOnMap = false})
      : super(key: key);

  final IdmPathPoint point;
  final bool isRecent;
  final IdmData data;
  final bool isOnMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          isRecent ? "Данные о последней точке" : "Данные о точке",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 28,
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Icon(Icons.speed),
            SizedBox(
              width: 5,
            ),
            Text("Процент льда"),
            Expanded(
              child: Center(
                child: Text(
                  "${point.iceFill.toStringAsFixed(1)}%",
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
        Row(
          children: [
            Icon(Icons.date_range),
            SizedBox(
              width: 5,
            ),
            Text("Дата замера"),
            Expanded(
              child: Center(
                child: Text(
                  point.scanDate.toString(),
                  style: TextStyle(fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                  softWrap: true,
                ),
              ),
            )
          ],
        ),
        if (!isOnMap) SizedBox(height: 10),
        if (!isOnMap)
          MaterialButton(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.blue),
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(
                    Icons.place,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Посмотреть на карте",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Scaffold(
                          body: CusMap(
                            data: data,
                            cam: CameraPosition(target: point.pos),
                          ),
                          appBar: AppBar(title: Text("Просмотр точки")),
                        )),
              );
            },
            padding: EdgeInsets.zero,
          ),
        if (isOnMap)
          Row(
            children: [
              Icon(Icons.travel_explore),
              SizedBox(
                width: 5,
              ),
              Text("Широта"),
              Expanded(
                child: Center(
                  child: Text(
                    "${point.pos.latitude.toString()}°",
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
              )
            ],
          ),
        if (isOnMap)
          Row(
            children: [
              Icon(Icons.radar),
              SizedBox(
                width: 5,
              ),
              Text("Долгота"),
              Expanded(
                child: Center(
                  child: Text(
                    "${point.pos.longitude.toString()}°",
                    style: TextStyle(fontSize: 18),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    softWrap: true,
                  ),
                ),
              )
            ],
          ),
      ],
    );
  }
}
