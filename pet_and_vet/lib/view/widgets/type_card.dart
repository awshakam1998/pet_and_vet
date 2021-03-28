import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pet_and_vet/constance.dart';
import 'package:pet_and_vet/models/products.dart';
import 'package:pet_and_vet/utils/local_storage/local_sorage.dart';
import 'package:pet_and_vet/view/screens/login.dart';

class TypeCard extends StatefulWidget {
  final Product product;

  const TypeCard({Key key, this.product}) : super(key: key);

  @override
  _TypeCardState createState() => _TypeCardState();
}

class _TypeCardState extends State<TypeCard> {
  LocalStorage localStorage;

  @override
  void initState() {
    localStorage = LocalStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              '${PathUrls.baseUrl}Images/${widget.product.image}', height: 100,
              width: 100,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(child: Text(
                    widget.product.name, textAlign: TextAlign.center,)),
                  Text('${widget.product.price} jd'),
                ],
              ),
            ),
            InkWell(onTap: () async {
              if(await localStorage.isLogin){
                print('asd');
              }else{
                Get.to(Login());
              }
              }, child: Icon(Icons.add))
          ],
        ),
      ),

    );
  }
}
