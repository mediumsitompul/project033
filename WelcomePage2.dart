import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
import 'api.dart';

class WelcomePage2 extends StatefulWidget {
  final String lat1, lng1;

  const WelcomePage2({super.key, required this.lat1, required this.lng1});

  @override
  State<WelcomePage2> createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  CameraPosition? _cameraPosition;
  String address = "";
  Set<Marker> marker1 = Set();

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  _initCameraPosition() async {
    double lat1c = double.parse('${widget.lat1.toString()}');
    double lng1c = double.parse('${widget.lng1.toString()}');
    _cameraPosition = CameraPosition(
        target: LatLng(lat1c, lng1c), zoom: 19, bearing: 90, tilt: 45);
  }

  // //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  _convertToAddress(double lat, double long, String apikey) async {
    Dio dio = Dio();
    String apiurl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$apikey";
    Response response = await dio.get(apiurl);

    if (response.statusCode == 200) {
      Map data = response.data;
      if (data["status"] == "OK") {
        if (data["results"].length > 0) {
          Map firstresult = data["results"][0];

          address = firstresult["formatted_address"];
          print('address');
          print(address);

          setState(() {});
        }
      } else {
        print(data["error_message"]);
      }
    } else {
      print("error while fetching geoconding data");
    }
  }

  //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  @override
  void initState() {
    double _lat1 = double.parse('${widget.lat1.toString()}');
    double _lng1 = double.parse('${widget.lng1.toString()}');
    LatLng _showLocation = LatLng(_lat1, _lng1);

    marker1.add(
      Marker(
          markerId: MarkerId(_showLocation.toString()),
          position: _showLocation,
          infoWindow: InfoWindow(
            title: 'Latitude: ${widget.lat1}',
            snippet: 'Longitude: ${widget.lng1}',
          )),
    );
    // TODO: implement initState
    _convertToAddress(_lat1, _lng1, googleApikey);
    _initCameraPosition();
    super.initState();
  }

  // //xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            //initialCameraPosition: CameraPosition(target: showLocation1,),
            initialCameraPosition: _cameraPosition!,
            markers: marker1,
            mapType: MapType.hybrid,
          ),
          Positioned(
            bottom: 58.0,
            left: 80.0,
            right: 80.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                    elevation: 15,
                    color: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Text('Address:\n$address'),
                            Text('\nLatitude: ${widget.lat1}'),
                            Text('\Longitude: ${widget.lng1}'),
                          ],
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
