import 'package:flutter/material.dart';
import 'brainstorm_graph.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Button Page',
      theme: ThemeData(primarySwatch: Colors.grey),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  void _showPrototypeMenu(BuildContext context) {
    TextEditingController appNameController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 250, // adjust width as needed
                  child: TextField(
                    controller: appNameController,
                    decoration: InputDecoration(
                      labelText: "Enter App Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(height: 15,),
                ElevatedButton(
                  onPressed: () {
                    String appName = appNameController.text.trim();
                    if (appName.isEmpty) return; // prevent empty
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BrainstormGraphPage(rootName: appName),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Generate Questions",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // close popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    "Start Directly",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WhiteBoard")),
      body: Stack(
        children: [
          // Prototype button positioned higher
          Positioned(
            top: 300,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () => _showPrototypeMenu(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  "Prototype",
                  style: TextStyle(fontSize: 21, color: Colors.white),
                ),
              ),
            ),
          ),

          // Bottom-right icon buttons
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.brush, size: 40),
                  onPressed: () => print("Draw pressed"),
                ),
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(Icons.text_fields, size: 40),
                  onPressed: () => print("Text pressed"),
                ),
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(Icons.crop_square, size: 40),
                  onPressed: () => print("Rectangle pressed"),
                ),
                SizedBox(height: 10),
                IconButton(
                  icon: Icon(Icons.image, size: 40),
                  onPressed: () => print("Picture pressed"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
