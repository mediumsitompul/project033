import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'WelcomePage2.dart';

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
              child: Text(
                  "               Google Maps\n( Convert LatLng to Address )")),
        ),
        body: const MyMap(),
      ),
    );
  }
}

class MyMap extends StatefulWidget {
  const MyMap({super.key});

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  TextEditingController lat1 = TextEditingController();
  TextEditingController lng1 = TextEditingController();
  final LatLng showLocation = LatLng(3.6085, 98.6206);

  Set<Marker> marker1 = Set();
  @override
  void initState() {
    marker1.add(Marker(
        markerId: MarkerId(showLocation.toString()),
        position: showLocation,
        infoWindow: const InfoWindow(
          title: "My Location",
          snippet: "Medan, INDONESIA",
        )));
    // TODO: implement initState
    super.initState();
  }

//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> NEW ADDITIONAL >>>>>>>>>>>>>>>>>>>>
  Widget _getMarker() {
    return Container(
      width: 40,
      height: 40,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100),
          boxShadow: const [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                spreadRadius: 4,
                blurRadius: 6)
          ]),
      child: ClipOval(
        child: Image.asset(
          "assets/profile.jpg",
        ),
      ),
    );
  }
//>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: showLocation,
          ),
          markers: marker1,
          myLocationEnabled: true,
        ),
        Positioned.fill(
            child: Align(
          alignment: Alignment.center,
          child: _getMarker(),
        )),
        Positioned(
          bottom: 54.0,
          left: 50.0,
          right: 50.0,
          child: Card(
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Show Google Map address\n and Marker position LatLng",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        top: 0, left: 16.0, right: 16.0, bottom: 8.0),
                    child: Column(
                      children: [
                        const Padding(padding: EdgeInsets.all(6)),
                        TextField(
                          controller: lat1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Latitude"),
                        ),
                        const Padding(padding: EdgeInsets.all(6)),
                        TextField(
                          controller: lng1,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Longitude"),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
        Positioned(
            bottom: 2,
            left: 70.0,
            right: 70.0,
            child: Card(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          //MyProject(lat1: lat1.text, lng1: lng1.text)));
                          WelcomePage2(lat1: lat1.text, lng1: lng1.text)));
                },
                child: const Text('E N T E R'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, foregroundColor: Colors.black),
              ),
            ))
      ],
    ));
  }
}
