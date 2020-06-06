import 'dart:convert'; 

import 'package:curved_navigation_bar/curved_navigation_bar.dart';


import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http; 
import 'package:flutter/services.dart';
import 'package:location_example/profile.dart';
import 'package:location_example/zones.dart';

import 'maps.dart';



void main(){runApp(MyApp());_getLocation();}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Location',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const MyHomePage(title: 'Location '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  final Location location = Location();
bool safe= true;
int _page = 1;
GlobalKey _bottomNavigationKey = GlobalKey();
static  List<Widget> _screens = [
Zones(),
    Home(),
    
    Text(
      'Index 2: School',
    ),
    User(),

  ];
@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: safe?Colors.green:Colors.red,
      
      
      appBar: AppBar(
        title: Text(widget.title),
        
      ),
      
      bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 1,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.location_on, size: 30),
            Icon(Icons.map, size: 30),
            Icon(Icons.radio, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.blue,
          buttonBackgroundColor: Colors.orange,
          backgroundColor: safe?Colors.green:Colors.red,
          animationCurve: Curves.easeInCirc,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              _page = index;
              print(_page);
            });
          },
        ),
      
      body: Container(padding: EdgeInsets.all(10),child: _screens[_page],)
        );
    
  }
}


  final Location location = Location();

  LocationData _location;
  String _error;
 

  Future<void> _getLocation() async {
    
    try {
      final LocationData _locationResult = await location.getLocation();
      
        _location = _locationResult;
        print(_location);
        const url = 'https://location-4509d.firebaseio.com/locations.json';
    http.post(url, body:json.encode({
      'latitude':_location.latitude,
      'longitude':_location.longitude
      }));
      
    } 
    on PlatformException catch (err) {
      
        _error = err.code;
      
    }
    
    
  }
 


  class Home extends StatefulWidget {
    @override
    _HomeState createState() => _HomeState();
  }
  
  
  class _HomeState extends State<Home> {
  get safe => true; 

    @override
    Widget build(BuildContext context) {
      return Container(
        
        child: Container(color: safe?Colors.green:Colors.red,
        padding: EdgeInsets.all(10),
        child: MapSample(),
        ),
        
      );
    }
  }








