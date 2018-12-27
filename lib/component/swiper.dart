import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../common/util/DetailImage.dart';

class SwiperTool extends StatefulWidget {
  @override
  _SwiperToolState createState() => _SwiperToolState();
}

class _SwiperToolState extends State<SwiperTool> {
  SwiperControl swiperControl;  // 轮播图控制器
  List<DetailImage> swiperImages = [
    DetailImage('轮播图1', ExactAssetImage('static/swiper1.jpg')),
    DetailImage('轮播图2', ExactAssetImage('static/swiper2.jpg')),
    DetailImage('轮播图3', ExactAssetImage('static/swiper3.jpg')),
  ];
  @override
  void initState() {
    super.initState();
    swiperControl = SwiperControl(
      iconNext: null,
      iconPrevious: null,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Swiper(
        itemBuilder: (BuildContext context, index) {
          return Container(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
              decoration: BoxDecoration(
                color: Color(0xaa000000),
              ),
              child: Text(swiperImages[ index ].text, style: TextStyle(color: Colors.white),),
            ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: swiperImages[ index ].image,
                fit: BoxFit.fitWidth,
              ),
            ),
          );
        },
        itemCount: 3,
        autoplayDelay: 5000,
        control: swiperControl,
        autoplay: true,
        onTap: (i){},
      ),
    );
  }
}