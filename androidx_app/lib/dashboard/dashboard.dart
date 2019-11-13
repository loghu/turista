import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';


class Dashboard extends StatefulWidget {
  @override
  DashboardState createState() => DashboardState();
}

class DashboardState extends State<Dashboard> {
  int _currentIndex = 1;

  // Development only, another widgets for map and user's profile will be here
  final _pages = <Widget>[
    Center(
      child: Text("Notificaciones"),
    ),
    Center(
      child: MapPage(),
    ),
    Center(
      child: Text("Perfil"),
    )
  ];

  //Text("Perfil")
  //Permiso()

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: this._rootWidget(),
      bottomNavigationBar: this._bottomNavigation(),
    );
  }

  Widget _rootWidget() {
    return this._pages[this._currentIndex];
  }

  List _navigationItems() {
    return <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.notifications),
        title: Text("Notificaciones"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.map),
        title: Text("Lugares"),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person),
        title: Text("Perfil"),
      )
    ];
  }

  Widget _bottomNavigation() {
    return BottomNavigationBar(
      items: this._navigationItems(),
      currentIndex: this._currentIndex,
      type: BottomNavigationBarType.fixed,
      fixedColor: Color.fromARGB(255, 228, 71, 120),
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
        });
      },
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}
class _MapPageState extends State<MapPage> {
  
 
 
  List<Marker> allMarkers = [
    brazil1Marker,
    brazil2Marker,
    brazil3Marker,
  ];

  List<Marker> maker1 = [
    calixtoMarker,
    brazilMarker,
    m1
  ];
  MapType _defaultMapType = MapType.normal;

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  PermissionStatus _status;
  GoogleMapController mapController;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(22.7747805,-102.5770593),
    zoom: 15,
  );
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Zacatecas',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.amber[300],
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_alert),
            color: Colors.black87,
            onPressed: _askpermission,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: Text('Zacatecas@gmail.com'),
              accountName: Text('Zactecas'),
              currentAccountPicture: CircleAvatar(
                child: Text('z'),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 25.0),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.monument, color: Colors.blue,size: 30.0),
              title: Text('Museos', style: TextStyle(fontSize: 20.0),),
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Dashboard()))
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.beer, color: Colors.blue, size: 30.0,),
              title: Text('Bares', style: TextStyle(fontSize: 20.0)),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.church, color: Colors.blue, size: 30),
              title: Text('Iglesias', style: TextStyle(fontSize: 20.0)),
            ),
            ListTile(
              leading: Icon(Icons.local_florist, color: Colors.blue, size: 30),
              title: Text('Parques', style: TextStyle(fontSize: 20.0)),
            ),
          ],
        ),
        //Text('hola'),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              mapType: _defaultMapType,
              myLocationEnabled: true,
              initialCameraPosition: _kGooglePlex,
              markers: Set.from(allMarkers),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                
              },
            ),
          ),
        ],
      ),
    );
  }
  void _updateStatus(PermissionStatus status) {
    if (status != _status) {
      setState(() {
        _status = status;
      });
    }
  }
  void _askpermission() {
    PermissionHandler().requestPermissions(
        [PermissionGroup.locationWhenInUse]).then(_onStatusRequested);
  }
  void _onStatusRequested(Map<PermissionGroup, PermissionStatus> statuses) {
    final status = statuses[PermissionGroup.locationWhenInUse];
    if (status == PermissionStatus.granted) {
      PermissionHandler().openAppSettings();
      
    }else if(status == PermissionStatus.denied){
      Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=>Dashboard()));
    }else{
      print('hola3');
      PermissionHandler().openAppSettings();
    }
  }
}

Marker m1 = Marker(
  markerId: MarkerId('Coppel Guerrero'),
  position: LatLng(22.7473864, -102.5141146),
  infoWindow: InfoWindow(title: 'Coppel Guerrero'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
);

Marker calixtoMarker = Marker(
  markerId: MarkerId('Gimnasio Marcelino'),
  position: LatLng(22.7561045, -102.5353246),
  infoWindow: InfoWindow(title: 'Gimnasio Marcelino'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
);
Marker brazilMarker = Marker(
  markerId: MarkerId('COZCyT'),
  position: LatLng(22.7611741, -102.5942326),
  infoWindow: InfoWindow(title: 'Consejo Zacatecano de Ciencia y Teconlogia'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
);

Marker brazil1Marker = Marker(
  markerId: MarkerId('Galerias'),
  position: LatLng(22.7626779, -102.589941),
  infoWindow: InfoWindow(title: 'Galerias'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
);
Marker brazil2Marker = Marker(
  markerId: MarkerId('Cerro de la bufa'),
  position: LatLng(22.7772214, -102.5712548),
  infoWindow: InfoWindow(title: 'Cerro de la bufa'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
);
Marker brazil3Marker = Marker(
  markerId: MarkerId('Museo Guadalupe'),
  position: LatLng(22.745897, -102.5166383),
  /*22.745897,-102.5166383 */
  infoWindow: InfoWindow(title: 'Museo Guadalupe'),
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta,),
);

class Location {
  final double lat;
  final double long;
  Location({this.lat, this.long});

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(
      lat: json['lat'],
      long: json['lng']
    );
    
  }
}