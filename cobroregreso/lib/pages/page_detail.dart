import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DetailCobro extends StatefulWidget {
  DetailCobro({Key key}) : super(key: key);

  @override
  _DetailCobroState createState() => _DetailCobroState();
}

class _DetailCobroState extends State<DetailCobro> {
  File _imagefile;
  List<File> _images = List<File>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.description)),
                Tab(icon: Icon(Icons.camera_alt)),
              ],
            ),
            title: Text('Guias cobro al Regreso'),
          ),
          body: TabBarView(
            children: [
              _formPicture(),
              ListView.builder(
                  itemCount: _images.length, itemBuilder: _itemBuilder),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formPicture() {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _takePicture(ImageSource.camera);
        },
        child: Icon(Icons.camera_alt),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Form(
        child: Container(
          child: Column(
            children: [
              TextFormField(
                controller: null,
                decoration: InputDecoration(
                  icon: Icon(Icons.description),
                  labelText: 'NumGuia',
                  suffixIcon: Container(
                    color: Colors.blue,
                    child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        onPressed: () {}),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            child: Image.file(
              _images[index],
              width: 250.0,
              height: 250.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FlatButton.icon(
                icon: Icon(
                  Icons.delete_forever,
                  color: Colors.blue,
                ),
                label: Text("Borrar Foto"),
                onPressed: () {
                  setState(() {
                    _images.removeAt(index);
                  });
                },
              ),
              FlatButton.icon(
                icon: Icon(Icons.send),
                label: Text("Guardar"),
                onPressed: () {},
              )
            ],
          )
        ],
      ),
    );
  }

  //Aqui recibimos por parametro de donde vamos a leer la imagen
  void _takePicture(ImageSource source) async {
    ImagePicker _picker = ImagePicker();
    PickedFile _pickFile = await _picker.getImage(source: source);
    setState(() {
      _imagefile = File(_pickFile.path);
      _images.add(_imagefile);
    });
  }
}
