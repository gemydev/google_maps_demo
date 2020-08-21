import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps/screens/maps.dart';
import 'package:location/location.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  @override
  void initState() {
    checkLocationServices();

    super.initState();
  }

  Future<void> checkLocationServices() async {
    Location location = Location();
    _serviceEnabled = await location.serviceEnabled();
    _permissionGranted = await location.hasPermission();
    if (_serviceEnabled) {
      print("GPS enabled");
      if (_permissionGranted == PermissionStatus.granted) {
        // To get the location once

        // await location.getLocation().then((value) => _locationData = value);

        // To get the location whenever it changes
        location.onLocationChanged.listen((currentLocation) {
          setState(() {
            _locationData = currentLocation;
          });
        });
      } else {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted == PermissionStatus.granted) {
          print("GPS granted after request");
        } else {
          print("GPS not granted after request");
          SystemNavigator.pop();
        }
      }
    } else {
      _serviceEnabled = await location.requestService();
      if (_serviceEnabled) {
        if (_permissionGranted == PermissionStatus.granted) {
          print("GPS granted");
        } else {
          _permissionGranted = await location.requestPermission();
          if (_permissionGranted == PermissionStatus.granted) {
            print("GPS granted after request");
          } else {
            print("GPS not granted after request");
            SystemNavigator.pop();
          }
        }
      } else {
        SystemNavigator.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50, right: 50),
          child: RaisedButton(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[Icon(Icons.map), Text("Move to maps")],
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MapSample(
                              latitude: _locationData.latitude,
                              longitude: _locationData.longitude,
                            )));
              }),
        ),
      ),
    );
  }
}
