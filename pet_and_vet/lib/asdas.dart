// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
//
//
// class AddItem extends StatefulWidget {
//   final uid;
//
//   AddItem(this.uid);
//
//   @override
//   _AddItemState createState() => _AddItemState(this.uid);
// }
//
// class _AddItemState extends State<AddItem> {
//   final uid;
//
//   _AddItemState(this.uid);
//
//   final bebeBlue = Color(0xff5EC0EB);
//   Color white = Colors.white;
//   final dark = Color(0xff165D84);
//   final lightBlue = Color(0xffD6EFFa);
//   String _title;
//   String _imageUrl;
//   String _descripition;
//   String _price;
//   String _section;
//
//   void getSection() {
//     Firestore.instance
//         .collection('sections')
//         .snapshots()
//         .listen((data) => data.documents.forEach((doc) {
//       print(doc.data['name']);
//       setState(() {
//         sections.add(doc.data['name']);
//       });
//     }));
//   }
//
//   List<String> sections = [];
//   List<String> errorSection = ['Error'];
//
//   final _formKey = GlobalKey<FormState>();
//   var image;
//   var url;
//   var defUrl =
//       'https://firebasestorage.googleapis.com/v0/b/bazar-d6323.appspot.com/o/Component%2093%20%E2%80%93%201%403x.png?alt=media&token=3d2f34a7-edeb-40c0-b5b9-608bf21c6ce0';
//   final fireStoreInstance = Firestore.instance;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     getSection();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     User user = Provider.of<User>(context);
//
//     Future getImage() async {
//       var _image = await ImagePicker.pickImage(source: ImageSource.gallery);
//
//       File croppedFile = await ImageCropper.cropImage(
//           maxHeight: 200,
//           maxWidth: 200,
//           sourcePath: _image.path,
//           aspectRatioPresets: Platform.isAndroid
//               ? [
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio16x9,
//           ]
//               : [
//             CropAspectRatioPreset.original,
//             CropAspectRatioPreset.square,
//             CropAspectRatioPreset.ratio3x2,
//             CropAspectRatioPreset.ratio4x3,
//             CropAspectRatioPreset.ratio5x3,
//             CropAspectRatioPreset.ratio5x4,
//             CropAspectRatioPreset.ratio7x5,
//             CropAspectRatioPreset.ratio16x9
//           ],
//           androidUiSettings: AndroidUiSettings(
//             toolbarTitle: 'Cropper',
//             toolbarColor: bebeBlue,
//             toolbarWidgetColor: Colors.white,
//             initAspectRatio: CropAspectRatioPreset.original,
//             backgroundColor: white,
//             activeControlsWidgetColor: dark,
//             cropGridColor: dark,
//             statusBarColor: dark,
//             lockAspectRatio: false,
//           ),
//           iosUiSettings: IOSUiSettings(
//             title: 'Cropper',
//           ));
//
//       if (croppedFile != null) {
//         _image = croppedFile;
//         setState(() {
//           image = _image;
//           print("Done = >" + image.path);
//         });
//       }
//     }
//
//     Future<String> uploadImage(BuildContext context) async {
//       String fileName = basename(image.path);
//       StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
//       StorageUploadTask uploadTask = ref.putFile(image);
//
//       var taskSnapshot =
//       await (await uploadTask.onComplete).ref.getDownloadURL();
//       var _url = taskSnapshot.toString();
//       print(_url);
//       setState(() {
//         url = _url;
//       });
//       return _url;
//     }
//
//     var screen = MediaQuery.of(context);
//     return Scaffold(
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: FloatingActionButton(
//           onPressed: () async {
//             if (_formKey.currentState.validate()) {
//               _formKey.currentState.save();
//
//               await DatabaseService(uid: widget.uid)
//                   .setDataProduct(
//                 urlImage: url == null ? defUrl : url,
//                 price: _price,
//                 section: _section,
//                 title: _title,
//                 description: _descripition,
//               )
//                   .then((_) {
//                 Navigator.pop(context);
//               }).catchError((e) {
//                 showDialog(
//                     context: context,
//                     builder: (context) {
//                       return Icon(
//                         Icons.error_outline,
//                         color: Colors.red,
//                       );
//                     });
//                 Navigator.pop(context);
//               });
//             }
//           },
//           elevation: 4,
//           child: Icon(
//             Icons.add,
//             color: white,
//           ),
//           backgroundColor: dark,
//         ),
//       ),
//       backgroundColor: white,
//       appBar: AppBar(
//         centerTitle: true,
//         backgroundColor: dark,
//         title: Text('Add item'),
//         leading: StreamBuilder(
//             stream: DatabaseService(uid: widget.uid).userData,
//             builder: (context, snapshot) {
//               UserData userData = snapshot.data;
//               if (snapshot.hasData) {
//                 return Container(
//                   height: 90,
//                   width: 90,
//                   child: InkWell(
//                     onTap: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (user) => Wrapper()));
//                     },
//                     child: Container(
//                       margin: const EdgeInsets.all(8.0),
//                       child: Container(
//                         decoration: new BoxDecoration(
//                           border: Border.all(color: bebeBlue, width: 0),
//                           shape: BoxShape.circle,
//                           image: new DecorationImage(
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                               userData.urlImage,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               } else
//                 return Loading();
//             }),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             height: 200,
//             width: screen.size.width,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.only(
//                   bottomLeft: Radius.circular(22),
//                   bottomRight: Radius.circular(22)),
//               color: Colors.grey[100],
//             ),
//             child: Center(
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: <Widget>[
//                   url == null
//                       ? Image.network(
//                     defUrl,
//                     fit: BoxFit.cover,
//                   )
//                       : Image.network(
//                     url,
//                     fit: BoxFit.cover,
//                   ),
//                   Container(
//                     alignment: Alignment.bottomLeft,
//                     child: IconButton(
//                         icon: Icon(
//                           Icons.camera_alt,
//                           size: 40,
//                           color: url == null ? white : Colors.transparent,
//                         ),
//                         onPressed: () {
//                           getImage().then((_) {
//                             uploadImage(context);
//                           });
//                         }),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           SingleChildScrollView(
//               child: Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       child: Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(22))),
//                           borderOnForeground: true,
//                           child: Padding(
//                             padding: EdgeInsets.all(0.0),
//                             child: TextFormField(
//                               validator: (val) {
//                                 if (val.isEmpty) {
//                                   return ' is empty';
//                                 } else {
//                                   if (val.length > 20)
//                                     return 'The title must be 20 characters or less';
//                                 }
//                                 return null;
//                               },
//                               onSaved: (val) {
//                                 setState(() {
//                                   _title = val;
//                                 });
//                               },
//                               maxLines: 8,
//                               decoration: InputDecoration(
//                                 alignLabelWithHint: true,
//                                 labelStyle: TextStyle(
//                                   color: dark,
//                                   fontSize: 15,
//                                 ),
//                                 hintText: 'Title',
//                                 labelText: 'Title',
//                                 hintStyle: TextStyle(color: dark, fontSize: 20),
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(width: 1, color: dark),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                       color: Colors.transparent, width: 0),
//                                 ),
//                               ),
//                             ),
//                           )),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       child: Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(22))),
//                           borderOnForeground: true,
//                           child: Padding(
//                             padding: EdgeInsets.all(0.0),
//                             child: TextFormField(
//                               validator: (val) {
//                                 if (val.isEmpty) {
//                                   return ' is empty';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               onSaved: (val) {
//                                 setState(() {
//                                   _descripition = val;
//                                 });
//                               },
//                               maxLines: 8,
//                               decoration: InputDecoration(
//                                 alignLabelWithHint: true,
//                                 labelStyle: TextStyle(
//                                   color: dark,
//                                   fontSize: 15,
//                                 ),
//                                 hintText: 'Describe',
//                                 labelText: 'Describe',
//                                 hintStyle: TextStyle(color: dark, fontSize: 20),
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(width: 1, color: dark),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                       color: Colors.transparent, width: 0),
//                                 ),
//                               ),
//                             ),
//                           )),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       height: 70,
//                       child: Card(
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(Radius.circular(22))),
//                           borderOnForeground: true,
//                           child: Padding(
//                             padding: EdgeInsets.all(0.0),
//                             child: TextFormField(
//                               validator: (val) {
//                                 if (val.isEmpty) {
//                                   return ' is empty';
//                                 } else {
//                                   return null;
//                                 }
//                               },
//                               onSaved: (val) {
//                                 setState(() {
//                                   _price = val;
//                                 });
//                               },
//                               maxLines: 8,
//                               decoration: InputDecoration(
//                                 alignLabelWithHint: true,
//                                 labelStyle: TextStyle(
//                                   color: dark,
//                                   fontSize: 15,
//                                 ),
//                                 hintText: 'Price',
//                                 labelText: 'Price',
//                                 hintStyle: TextStyle(color: dark, fontSize: 20),
//                                 filled: true,
//                                 fillColor: Colors.grey[100],
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(width: 1, color: dark),
//                                 ),
//                                 enabledBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                   borderSide: BorderSide(
//                                       color: Colors.transparent, width: 0),
//                                 ),
//                               ),
//                             ),
//                           )),
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                         color: Colors.grey[100],
//                         borderRadius: BorderRadius.all(Radius.circular(15)),
//                       ),
//                       child: Container(
//                         margin: EdgeInsets.only(left: 5, right: 5),
//                         child: DropdownButton(
//                           underline: Text(''),
//                           hint: Text(
//                             'Section',
//                             style: TextStyle(
//                               color: dark,
//                             ),
//                           ),
//                           style:
//                           TextStyle(color: dark, fontWeight: FontWeight.bold),
//                           iconEnabledColor: dark,
//
//                           // Not necessary for Option 1
//                           value: _section,
//                           onChanged: (newValue) {
//                             setState(() {
//                               _section = newValue;
//                             });
//                           },
//                           items: (sections).map((location) {
//                             return DropdownMenuItem(
//                               child: new Text(location),
//                               value: location.isNotEmpty ? location : 'Other',
//                             );
//                           }).toList(),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     SizedBox(
//                       height: 70,
//                     )
//                   ],
//                 ),
//               )),
//         ],
//       ),
//     );
//   }
// }