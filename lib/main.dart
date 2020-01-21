import 'package:flutter/material.dart';
// 

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Tasks Finished';

    return MaterialApp(
      title: appTitle,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final descController = TextEditingController();

  void check() {
    print("CHKCI");
  }
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    descController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return new Scaffold(
          body: new Container(
              margin: new EdgeInsets.all(16.0),
              child: new Form(
                  key: _formKey,
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Container(
                          child: new TextFormField(
                            controller: myController,
                            style: TextStyle(fontSize: 20),
                            decoration: new InputDecoration(
                              labelText: "ID",
                              border: InputBorder.none,
                            ),
                            key: new Key("title"),
                            validator: (val) => val.isNotEmpty ? null : "Title must not be empty"
                          ),
                        ),
                        new Container(
                            child: new Divider(
                              color: Colors.black,)),
                        new TextFormField(
                          controller: descController,
                          style: TextStyle(
                            fontSize: 20,
                          ),
                          decoration: new InputDecoration(
                            labelText: "Description",
                            border: InputBorder.none,
                          ),
                          key: new Key("description"),
                          validator: (val) => val.isNotEmpty ? null : "Description must not be empty",
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                        )
                      ]))
          ),
          floatingActionButton: new FloatingActionButton(
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  print(myController.text);
                  print("%%%");
                  print(descController.text);
                  showDialog(context: context, child:
                  new AlertDialog(
                    title: new Center(child: Text(myController.text)),
                    content: new Text(descController.text),
                    actions: <Widget>[
                                        FlatButton(
                                          child: Text('Ok'),
                                          onPressed: () {
                                            //call db
                                            myController.clear();
                                            descController.clear();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ]
                  )
                 );
                }
              },
              child: new Icon(Icons.check)),
        );
  }
}