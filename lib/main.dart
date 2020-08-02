import 'package:flutter/material.dart';
import 'package:flutterfooddelivery/my_index.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned(
            top: 80.0,
            right: 80.0,
            child: DragTarget<int>(
              onWillAccept: (int value) {
                setState(() {
                  MyIndex.color = MyIndex.color * (10 + 5);
                });
                return true;
              },
              onAccept: (int value) {
                //remove from list code come here
                setState(() {
                  MyIndex.decrement();
                });
                print("success");
              },
              onLeave: (index) {
                setState(() {
                  MyIndex.color = 0xFFcc00;
                });
              },
              builder: (context, List<int> incomingData,
                  List<dynamic> rejectedData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.delete,
                    color: Colors.black54,
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 150.0,
            right: 30.0,
            left: 30.0,
            bottom: 10.0,
            child: ListView(
              children: List.generate(
                MyIndex.index,
                (index) => Draggable(
                  data: index,
                  maxSimultaneousDrags: 1,
                  feedback: DraggableContainerFeedback(
                    index: index,
                  ),
                  child: DraggableContainer(
                    index: index,
                  ),
                  childWhenDragging: index > 1
                      ? DraggableContainer(
                          index:
                              index) //https://www.youtube.com/watch?v=pKO54ttCV5I&t=97s
                      : Container(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DraggableContainer extends StatelessWidget {
  final int index;
  DraggableContainer({this.index});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      width: 100.0,
      height: 100.0,
      color: Color(0xFF00000 * (index + 5)),
      child: Center(
        child: Text(
          "$index",
          textScaleFactor: 1.5,
        ),
      ),
    );
  }
}

class DraggableContainerFeedback extends StatelessWidget {
  final int index;
  DraggableContainerFeedback({this.index});
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Material(
        child: Container(
          margin: EdgeInsets.only(
            top: 10.0,
          ),
          width: 100.0,
          height: 100.0,
          color: Color(MyIndex.color * (index + 5)),
          child: Center(
            child: Text(
              "$index",
              textScaleFactor: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
