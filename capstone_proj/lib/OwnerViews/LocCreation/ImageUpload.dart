import 'package:capstone_proj/sign_up_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'package:capstone_proj/services/auth_service.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:capstone_proj/Home.dart';
import 'package:capstone_proj/profile_view.dart';
import 'package:english_words/english_words.dart';
import 'package:capstone_proj/Models/Loc.dart';
import 'package:capstone_proj/OwnerViews/LocCreation/PriceCreate.dart';
import 'package:capstone_proj/widgets/provider_widget.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUpload extends StatefulWidget {
  final Loc loc;
  ImageUpload({Key key, @required this.loc}) : super(key: key);

  @override
  _ImageUpload createState() => _ImageUpload(loc: loc);
}

class _ImageUpload extends State<ImageUpload> {
  final Loc loc;
  _ImageUpload({Key key, @required this.loc});

  File _image;
  final picker = ImagePicker();

  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("Add Property- Photo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.only(left: 80.0),
              child: Text(
                "Add a picture of your property",
                style: new TextStyle(fontSize: 20.0),
              )),
          Padding(
            padding: const EdgeInsets.only(left: 80.0, top: 15.0),
            child: ElevatedButton(
              child: Text("Upload Image and Finish"),
              onPressed: () async {
                //save to firebase
                final String fuid = UniqueKey().toString();
                loc.picUrl = await _uploadFile(fuid);

                final String uid = await Provider.of(context).auth.getCurrentID();

                loc.ownerId = uid;

                //add to owner my properties
                await db
                    .collection("userData")
                    .doc(uid)
                    .collection("myProperties")
                    .add(loc.toJson());

                //add to public view
                await db.collection("Locations").add(loc.toJson());

                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<String> _uploadFile(filename) async {
    final _picker = ImagePicker();
    var image;
    final _storage = FirebaseStorage.instance;
    String url;

    //get permission for photo access
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //select image if have permission
      image = (await _picker.pickImage(source: ImageSource.gallery));
      var file = File(image.path);

      if (image != null) {
        String fid = UniqueKey().toString();
        //firebase
        var snapshot = await _storage.ref().child(fid).putFile(file);

        var downloadUrl = await (await snapshot).ref.getDownloadURL();

        setState(() {
          url = downloadUrl;
        });

        return url;
      } else {
        print("no image given");
      }
    } else {
      print("Permission not granted");
    }
  }
}
