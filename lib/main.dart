import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sharing data between screens',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
  String? _result;
  final textEditingController = TextEditingController(text: "Text from first screen");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sharing data between screens'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: textEditingController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'TextField',
                ),
              ),
              ButtonBar(
                children: <Widget>[
                  OutlinedButton(
                    onPressed: () => goAhead(true),
                    child: Text("Standard"),
                  ),
                  OutlinedButton(
                    onPressed: () => goAhead(false),
                    child: Text("Using settings"),
                  ),
                ],
              ),
              Text(_result != null ? "Result from second page: '$_result'" : "")
            ]
        ),
      ),
    );
  }

  Future<void> goAhead(bool standardType) async {
    var result;
    if (standardType) {
      result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(true, textEditingController.text),
          )
      );
    } else {
      result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondPage(false),
            settings: RouteSettings(
              arguments: textEditingController.text,
            ),
          )
      );

    }

    if (result != null) {
      setState(() {
        _result = result;
      });
    }
  }
}

class SecondPage extends StatelessWidget {
  final String? _title;
  final bool passed;
  final textEditingController = TextEditingController(text: "Text from second screen");
  SecondPage([ this.passed = false, this._title]);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
           createTitle() ,
            TextField(
              controller: textEditingController,
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'TextField',
              ),
            ),
            ButtonBar(
              children: <Widget>[
                OutlinedButton(
                  onPressed: () => returnWithValue(context),
                  child: Text("Return with value"),
                ),
              ],
            ),
          ],
        )
      ),
    );
  }
    
  Widget createTitle(){

if (passed){
return Text("Passed data: $_title");
}
      return Text("");
  }

  void returnWithValue(BuildContext context) {
    Navigator.pop(context, textEditingController.text);
  }
}
