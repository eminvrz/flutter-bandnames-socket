import 'dart:io';

import 'package:band_names/models/band.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Band> bands = [
    Band(id: '1', name: 'Metallica', votes: 5),
    Band(id: '2', name: 'Queen', votes: 1),
    Band(id: '3', name: 'Heroes del Silencio', votes: 2),
    Band(id: '4', name: 'Bon Jovi', votes: 5),
  ];

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('BandNames', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bands.length,
        itemBuilder: (context, i) => _bandTile(bands[i])
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBand,
      ),
   );
  }

  Widget _bandTile(Band band) {
    return Dismissible(
      key: Key(band.id),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction){
        print('direction: $direction');
        print('id: ${ band.id}');
        //TODO: llamar el borrado en el server
      },
      background: Container(
        padding: const EdgeInsets.only(left: 8.0),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Text('Delete Band', style: TextStyle( color: Colors.white ),),
        ),
      ),
      child: ListTile(
            leading: CircleAvatar(
              child: Text( band.name.substring(0,2)),
              backgroundColor: Colors.blue[100],
            ),
            title: Text(band.name),
            trailing: Text('${ band.votes }', style: const TextStyle( fontSize: 20),),
            onTap: () {
              print(band.name);
        },
      ),
    );
  }

  addNewBand(){

    final textController = TextEditingController();

    if( Platform.isAndroid ){
      // Android
      return showDialog(
      context : context, 
      builder: ( context ) {
        return AlertDialog(
          title: const Text('New Band name:'),
          content: TextField(
            controller: textController,
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Add'),
              elevation: 5,
              textColor: Colors.blue,
              onPressed: () => addBandtoList( textController.text )
            )
          ],
        );
      }
    );
  }

    showCupertinoDialog(
      context: context, 
      builder: ( _ ){
        return CupertinoAlertDialog(
          title: const Text('New Band name:'),
          content: CupertinoTextField(
            controller: textController,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: const Text('Add'),
              onPressed: ( ) => addBandtoList( textController.text ),
            ),
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('Dismiss'),
              onPressed: ( ) => Navigator.pop(context),
            )
          ],
        );
      }
    );
 }

  void addBandtoList(String name){
    print(name);

    if(name.length > 1) {
      bands.add( Band(
        id: DateTime.now().toString(), 
        name: name, 
        votes: 0 )
      );
      setState(() {});
    }

     Navigator.pop(context); // Para salirnos del mensaje
  }
}
