import 'dart:async';

import 'package:flutter/material.dart';
import 'package:map_view/figure_joint_type.dart';
import 'package:map_view/map_view.dart';
import 'package:map_view/polygon.dart';
import 'package:map_view/polyline.dart';

const API_KEY = "AIzaSyDrHKl8IxB4cGXIoELXQOzzZwiH1xtsRf4";

class DetailsDonationPage extends StatefulWidget {
  String title;

  DetailsDonationPage(this.title);

  @override
  _DetailsDonationPageState createState() =>
      new _DetailsDonationPageState(title);
}

class _DetailsDonationPageState extends State<DetailsDonationPage> {
  String title;

  _DetailsDonationPageState(this.title);

  MapView mapView = new MapView();
  CameraPosition cameraPosition;
  var compositeSubscription = new CompositeSubscription();
  var staticMapProvider = new StaticMapProvider(API_KEY);
  Uri staticMapUri;

  //Marker bubble
  List<Marker> _markers = <Marker>[
    new Marker(
      "1",
      "Something fragile!",
      46.942637,
      7.510835,
      color: Colors.blue,
      draggable: true, //Allows the user to move the marker.
      markerIcon: new MarkerIcon(
        "images/flower_vase.png",
        width: 112.0,
        height: 75.0,
      ),
    ),
  ];

  //Line
  List<Polyline> _lines = <Polyline>[
    new Polyline(
        "11",
        <Location>[
          new Location(46.942637, 7.510835),
          new Location(46.764299, 7.670142),
        ],
        width: 15.0,
        color: Colors.blue),
  ];

  //Drawing
  List<Polygon> _polygons = <Polygon>[
    new Polygon(
        "111",
        <Location>[
          new Location(45.5231233, -122.6733130),
          new Location(45.5231195, -122.6706147),
        ],
        jointType: FigureJointType.bevel,
        strokeWidth: 5.0,
        strokeColor: Colors.red,
        fillColor: Color.fromARGB(75, 255, 0, 0)),
  ];

  @override
  initState() {
    super.initState();
    cameraPosition = new CameraPosition(Locations.portland, 2.0);
  }

  List<DropdownMenuItem> donations = [
    DropdownMenuItem(
      child: Text("Spende 1"),
    ),
    DropdownMenuItem(
      child: Text("Spende 2"),
    ),
    DropdownMenuItem(
      child: Text("Spende 3"),
    ),
    DropdownMenuItem(
      child: Text("Spende 4"),
    ),
  ];

  String selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$title"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        padding:
            EdgeInsets.only(left: 30.0, right: 30.0, top: 40.0, bottom: 40.0),
        child: Card(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 150.0,
                child: Stack(
                  children: <Widget>[
                    Positioned.fill(
                        child: Image.network(
                      "https://r.hswstatic.com/w_907/gif/now-TwuUAjsF-coins_chuckcross_eyeem_gettyimagesjpg-1210-680.jpg",
                      fit: BoxFit.cover,
                    )),
                  ],
                ),
              ),
              Divider(),
              Center(
                child: Text(
                  "Unterstützte Projekte",
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text("Projekt 1"),
                      subtitle: Text("1 CHF"),
                    ),
                    ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text("Projekt 3"),
                      subtitle: Text("10 CHF"),
                    ),
                    ListTile(
                      leading: Icon(Icons.attach_money),
                      title: Text("Projekt 7"),
                      subtitle: Text("25 CHF"),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.only(bottom: 25.0),
                    child: RaisedButton(
                      onPressed: () {
                        showMap();
                      },
                      child: Text("SPENDE AUF KARTE ZEIGEN", style: TextStyle(color: Colors.white),),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      elevation: 10.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      /*Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Text('Top'),
          new Expanded(
            child: new Align(
              alignment: FractionalOffset.bottomCenter,
              child: Container(
                padding: EdgeInsets.only(bottom: 25.0),
                child: RaisedButton(
                  onPressed: () {showMap();},
                  child: Text("SHOW DONATION ON MAP"),
                  color: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0)),
                  elevation: 10.0,
                ),
              ),
            ),
          ),
        ],
      ),*/
    );
  }

  showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.satellite,
            showUserLocation: true,
            showMyLocationButton: true,
            showCompassButton: true,
            initialCameraPosition:
                new CameraPosition(new Location(46.6622394, 7.7037007), 9.33),
            hideToolbar: false,
            title: "Recently Visited"),
        toolbarActions: [new ToolbarAction("Close", 1)]);
    StreamSubscription sub = mapView.onMapReady.listen((_) {
      mapView.setMarkers(_markers);
      mapView.setPolylines(_lines);
      mapView.setPolygons(_polygons);
    });
    compositeSubscription.add(sub);
    sub = mapView.onLocationUpdated.listen((location) {
      print("Location updated $location");
    });
    compositeSubscription.add(sub);
    sub = mapView.onTouchAnnotation
        .listen((annotation) => print("annotation ${annotation.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolyline
        .listen((polyline) => print("polyline ${polyline.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onTouchPolygon
        .listen((polygon) => print("polygon ${polygon.id} tapped"));
    compositeSubscription.add(sub);
    sub = mapView.onMapTapped
        .listen((location) => print("Touched location $location"));
    compositeSubscription.add(sub);
    sub = mapView.onCameraChanged.listen((cameraPosition) =>
        this.setState(() => this.cameraPosition = cameraPosition));
    compositeSubscription.add(sub);
    sub = mapView.onAnnotationDragStart.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging started");
    });
    sub = mapView.onAnnotationDragEnd.listen((markerMap) {
      var marker = markerMap.keys.first;
      print("Annotation ${marker.id} dragging ended");
    });
    sub = mapView.onAnnotationDrag.listen((markerMap) {
      var marker = markerMap.keys.first;
      var location = markerMap[marker];
      print("Annotation ${marker.id} moved to ${location.latitude} , ${location
          .longitude}");
    });
    compositeSubscription.add(sub);
    sub = mapView.onToolbarAction.listen((id) {
      print("Toolbar button id = $id");
      if (id == 1) {
        _handleDismiss();
      }
    });
    compositeSubscription.add(sub);
    sub = mapView.onInfoWindowTapped.listen((marker) {
      print("Info Window Tapped for ${marker.title}");
    });
    compositeSubscription.add(sub);
  }

  _handleDismiss() async {
    double zoomLevel = await mapView.zoomLevel;
    Location centerLocation = await mapView.centerLocation;
    List<Marker> visibleAnnotations = await mapView.visibleAnnotations;
    List<Polyline> visibleLines = await mapView.visiblePolyLines;
    List<Polygon> visiblePolygons = await mapView.visiblePolygons;
    print("Zoom Level: $zoomLevel");
    print("Center: $centerLocation");
    print("Visible Annotation Count: ${visibleAnnotations.length}");
    print("Visible Polylines Count: ${visibleLines.length}");
    print("Visible Polygons Count: ${visiblePolygons.length}");
    var uri = await staticMapProvider.getImageUriFromMap(mapView,
        width: 900, height: 400);
    setState(() => staticMapUri = uri);
    mapView.dismiss();
    compositeSubscription.cancel();
  }
}

class CompositeSubscription {
  Set<StreamSubscription> _subscriptions = new Set();

  void cancel() {
    for (var n in this._subscriptions) {
      n.cancel();
    }
    this._subscriptions = new Set();
  }

  void add(StreamSubscription subscription) {
    this._subscriptions.add(subscription);
  }

  void addAll(Iterable<StreamSubscription> subs) {
    _subscriptions.addAll(subs);
  }

  bool remove(StreamSubscription subscription) {
    return this._subscriptions.remove(subscription);
  }

  bool contains(StreamSubscription subscription) {
    return this._subscriptions.contains(subscription);
  }

  List<StreamSubscription> toList() {
    return this._subscriptions.toList();
  }
}
