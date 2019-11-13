import 'package:Turistas/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class Permiso extends StatefulWidget {
  @override
  _PermisoState createState() => _PermisoState();
}

class _PermisoState extends State<Permiso> {
  PermissionStatus _status;

  @override
  void initState(){
    super.initState();
    PermissionHandler().checkPermissionStatus(PermissionGroup.locationWhenInUse).then(_updateState);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Text('$_status'),
          RaisedButton(
            child: Text('Respuesta'),
            onPressed: _askpermission,
                      )
                    ],
                  )
                );
              }
              void _updateState(PermissionStatus status){
                if(status != _status){
                  setState(() {
                   _status =status; 
                  });
                }
              }
            
              void _askpermission() {
                PermissionHandler().requestPermissions([PermissionGroup.locationWhenInUse]).then(_onstatusrequested);
  }
              void _onstatusrequested(Map<PermissionGroup, PermissionStatus> statuses){
                final status = statuses[PermissionGroup.locationWhenInUse];
                if(status != PermissionStatus.granted){
                  PermissionHandler().openAppSettings();
                  print('$status');
                }
                else if(status != PermissionStatus.denied){
                  _updateState(status);
                  print('$status');
                  Dashboard();
                }
                
              }
}