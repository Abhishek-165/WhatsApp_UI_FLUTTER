import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/calls.dart';
import 'package:whatsapp/camera.dart';
import 'package:whatsapp/chatscreen.dart';
import 'package:whatsapp/statusscreen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(accentColor: Color(0xFFFFFFFF),
    primaryColor: Color(0xff075E54)),
    home:MyApp(cameras:cameras,)
  ));
}





class MyApp extends StatefulWidget {
final List<CameraDescription> cameras;
MyApp({this.cameras});

  @override
  _MyAppState createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {

  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
      backgroundColor:Color(0xff25D366),child: Icon(Icons.message,color: Theme.of(context).accentColor),onPressed:()=> print("open Chats"),),
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        actions: [
          Icon(Icons.search),
          Padding(padding: EdgeInsets.symmetric(horizontal:5.0)),
          Icon(Icons.more_vert),
          
          Padding(padding: EdgeInsets.symmetric(horizontal:5.0)),
        ],
        bottom: TabBar(controller: _tabController,
        //if (!widget.isScrollable && index != 0)
        //wrappedTabs[index] = Expanded(child: wrappedTabs[index]);
        tabs: [
          Tab(icon:Icon(Icons.camera_alt)),
          Tab(text: "CHATS",),
          Tab(text: "STATUS",),
          Tab(text: "CALLS"),

        ],),
      ),
      body:TabBarView(
        controller: _tabController,
        children: [
        CameraScreen(cameras:cameras),
        ChatScreen(),
        StatusScreen(),
        CallScreen()
      
        
      
      ])
    );
  }
}