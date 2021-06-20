import 'package:flutter/material.dart';

import 'package:dragnode/curved_painter.dart';
import 'package:dragnode/node.dart';
import 'mock_up_list_nodes.dart';
import 'package:dragnode/constants/Constants.dart';

//This is only a example, in a real production you need to implement state management , like prodider

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final String title = appTitle;

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: title),
    );
  }
}


class MyHomePage extends StatefulWidget {
  final String title;
  bool dashedLine = false;
  bool curvedLine = false;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){},
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //curvedLine
              Text('Curvedline'),
              Checkbox(
              value: widget.curvedLine, 
              onChanged: (value){
                if(widget.curvedLine){
                  widget.curvedLine = false;
                }else{
                  widget.curvedLine = true;
                }
                setState(() {});
              },
              ),
              //dashedLine
              Text('Dashedline'),
              Checkbox(
              value: widget.dashedLine, 
              onChanged: (value){
                if(widget.dashedLine){
                  widget.dashedLine = false;
                }else{
                  widget.dashedLine = true;
                }
                setState(() {});
              },
              ),
              //More
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: (){},
              ),
              //Search
              Container(
                margin: EdgeInsets.all(10.0),
                height: 25,
                width: 250,
                padding: EdgeInsets.all(10.0),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0), color: Colors.white),
                child: Center(
                  child: TextField(
                    controller: null,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search',
                        ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Container(
          child: ItemsScene(dashedLine: widget.dashedLine, curvedLine: widget.curvedLine,),
          decoration: BoxDecoration(
            border: Border.all(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Add node',
        child: Icon(Icons.add),
      ),
    );
  }
}

class ItemsScene extends StatefulWidget {
  final bool dashedLine;
  final bool curvedLine;

  ItemsScene({Key key, @required this.dashedLine, @required this.curvedLine}) : super(key: key);

  @override
  _ItemsSceneState createState() => _ItemsSceneState();
}

class _ItemsSceneState extends State<ItemsScene> {

  Function onDragStart(int index) => (x, y) {
        setState(() {
          items[index] = items[index].copyWithNewOffset(Offset(x, y));
        });
      };

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      // scale and pan Stack/scene
      boundaryMargin: EdgeInsets.all(20.0),
      minScale: 0.5,
      maxScale: 2.5,
      child: Stack(
        children: <Widget>[
          //background
          Container(
            color: Color.fromRGBO(51, 51, 51, 1.0),
          ),
          //connections
          CustomPaint(
            size: Size(double.infinity, double.infinity),
            painter: ConnectionDrawer(
              offsets: items.map((item) => item.offset).toList(),
              dashLine: widget.dashedLine,
              curvedLine: widget.curvedLine,
            ),
          ),
          //nodes 
          ..._buildItems()
        ],
      ),
    );
  }

  List<Widget> _buildItems() {
    final res = <Widget>[];
    items.asMap().forEach((ind, item) {
      res.add(Node(
        onDragStart: onDragStart(ind),
        offset: item.offset,
        text: item.text,
      ));
    });
    return res;
  }
}
