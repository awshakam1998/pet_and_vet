import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:like_button/like_button.dart';
import 'package:pet_and_vet/models/consult.dart';

class ConsultCard extends StatelessWidget {
  final Consult consult;
  double width;

  ConsultCard({Key key, this.consult}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.all(10),
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        child: Column(
          children: [headerPost(), contentPost(), footerPost()],
        ),
      ),
    );
  }

  contentPost() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: this.consult.desc == null
              ? Container()
              : Text(this.consult.desc),
        )),
        this.consult.img == null||consult.img==''
            ? Container()
            : Row(
                children: [
                  Expanded(
                      child: Image.network(
                    this.consult.img,
                    height: 200,
                    fit: BoxFit.cover,
                  )),
                ],
              ),
        Divider()
      ],
    );
  }

  headerPost() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: Colors.grey.shade200,
              padding: EdgeInsets.all(8),
              child: SvgPicture.asset(
                'assets/svg/man.svg',
                height: 40,
                width: 40,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(this.consult.userName),
                  Text(TimeAgo.getTimeAgo(this.consult.createdIn,locale: Get.locale.languageCode),textDirection: Get.locale.languageCode=='ar'?TextDirection.rtl:TextDirection.ltr,),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  footerPost() {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              LikeButton(),
              Icon(
                Icons.comment,
                color: Colors.grey,
              )
            ],
          ),
        ],
      ),
    );
  }
}
