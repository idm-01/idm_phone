import 'package:flutter/material.dart';
import 'package:idm_phone/data.dart';
import 'package:idm_phone/history.dart';
import 'package:idm_phone/maps.dart';
import 'package:idm_phone/point.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _curI = 0;

  late IdmData data;

  @override
  void initState() {
    data = IdmData.fromSerial();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("IDM Client"),
      ),
      body: _curI == 0
          ? CusMap(
              data: data,
            )
          : Padding(
              padding: EdgeInsets.all(_curI == 0 ? 0 : 20),
              child: (_curI == 1
                  ? IdmHistory(
                      data: data,
                    )
                  : PointInfo(
                      isRecent: true,
                      data: data,
                      point: data.path[data.path.length - 1],
                    )),
            ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _curI,
        onTap: (i) {
          setState(() {
            _curI = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Главная",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: "История",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            label: "Сейчас",
          ),
        ],
      ),
    );
  }
}
