import 'package:b2b_app/Shared/app_style.dart';
import 'package:b2b_app/Widgets/circle_avatar_from_image.dart';
import 'package:flutter/material.dart';
import 'dart:math';

Container buildBrandsRowContainer({List urls}) {
//  List<String> imageUrls = urls;
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/texture_6.jpg'))),
    child: Column(
      children: <Widget>[
        Text('Featured Brands',
          style: AppStyle.headingStyle2.copyWith(color: Colors.black87),),

        Container(
            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
            width: 400.0,
            height: 100.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                getCircularLogo(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/29/HP_New_Logo_2D.svg/434px-HP_New_Logo_2D.svg.png'),
                getCircularLogo(
                    'https://1000logos.net/wp-content/uploads/2017/03/Nike-Logo.png'),
                getCircularLogo(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/2/20/Adidas_Logo.svg/1200px-Adidas_Logo.svg.png'),
                getCircularLogo(
                    'https://i.pinimg.com/originals/9a/54/d3/9a54d3272a85435f8aa767452b6cf0fe.png'),
              ],
            )),
      ],
    ),
  );
}

Widget getPopularCities() {
  var ranNum = Random().nextInt(5) + 1;
  return Container(
    padding: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/texture_$ranNum.jpg'))),
    child: Column(
      children: <Widget>[
        Container(
            margin: EdgeInsets.all(20),
            child: Text(
              'Popular Cities',
              style: AppStyle.headingStyle2.copyWith(color: Colors.black87),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            for (int i = 0; i < 3; i++)
              CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    'https://pmdvod.nationalgeographic.com/NG_Video/926/90/lgpost_1518055506936.jpg',
                  ))
          ],
        ),
      ],
    ),
  );
}
