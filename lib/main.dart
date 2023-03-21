import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:url_launcher/url_launcher.dart";

///20230320 - 此代码主要学习了GridView的用法，GridView主要实现了将比较复杂的界面布局，简化一些，比如将（带文字说明的图片/图标）
///这样的组合部件作为一个item，这样的一组item放入GridView中，
/// 具体的做法是，
/// 0. 构建一个class，里面实现两个widget，一个是item，一个是界面（内包含gridview的定义）
/// 1. 单独构建一个Widget来构建这个图片加文字的item，其数据源为一个MapList，如代码中的List<Map> navigatorList。在这个widget类中，
/// 一个item可以用column或row来实现，还要把item的Ontap事件响应函数也构建好
/// 2. 再单独构建一个Container Widget，里面加入一个GridView，在其builder方法中将前面构建的item作为参数传递进来
/// 用map的方式，将item迭代取出，并添加到GridView的children（这个children是List<Widget>）中
///           children: navigatorList.map(
///   (item) {
///     return _gridViewItemUI(context, item);
///   },
/// ).toList(),
///总结：这样就将items添加到了GrideView中，又因为每个item自带Ontap响应事件处理函数，于是可以响应点击事件
///
///20230320 - 添加dial_shop功能widget，引用了url_launcher这个插件
///

void main() => runApp(MyApp());

/// 自制的数据源
class DataSrc {
  List<Map> navigatorList = [
    {
      "image":
          "https://images.pexels.com/photos/4270243/pexels-photo-4270243.jpeg",
      "mallCategoryName": "Book1"
    },
    {
      "image":
          "https://images.pexels.com/photos/3457273/pexels-photo-3457273.jpeg",
      "mallCategoryName": "Book2"
    },
    {
      "image":
          "https://images.pexels.com/photos/4273468/pexels-photo-4273468.jpeg",
      "mallCategoryName": "Book3"
    },
    {
      "image":
          "https://images.pexels.com/photos/4270243/pexels-photo-4270243.jpeg",
      "mallCategoryName": "Book4"
    },
    {
      "image":
          "https://images.pexels.com/photos/3457273/pexels-photo-3457273.jpeg",
      "mallCategoryName": "Book5"
    },
    {
      "image":
          "https://images.pexels.com/photos/4273468/pexels-photo-4273468.jpeg",
      "mallCategoryName": "Book6"
    },
  ];
  var adPicture = {
    'PICTURE_ADDRESS': "images/adbanner.png",
  };
  Map dialShopper = {
    'shopperImage': "images/dial_phone.png",
    'shopperPhone': '4038888888'
  };
  List<Map> recommendList = [
    {
      "image":
          "https://images.pexels.com/photos/4270243/pexels-photo-4270243.jpeg",
      "mallprice": 101,
      "price": 151,
    },
    {
      "image":
          "https://images.pexels.com/photos/3457273/pexels-photo-3457273.jpeg",
      "mallprice": 201,
      "price": 251,
    },
    {
      "image":
          "https://images.pexels.com/photos/4273468/pexels-photo-4273468.jpeg",
      "mallprice": 301,
      "price": 351,
    },
    {
      "image":
          "https://images.pexels.com/photos/4270243/pexels-photo-4270243.jpeg",
      "mallprice": 401,
      "price": 451,
    },
  ];
}

//程序入口
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: "",
          home: Scaffold(
            appBar: AppBar(title: Text("TopNavigator demo")),
            body: child,
          ),
        );
      },
      //首页框架中的ListView，用于呈现页面中的各个Widget，如TopNavigators, AdBanner, DialShopper, RecommendList
      child: ListView(
        children: [
          //顶部导航栏
          TopNavigator(
            navigatorList: DataSrc().navigatorList,
          ),
          //AdBanner

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ADBanner(
              adPicture: DataSrc().adPicture["PICTURE_ADDRESS"].toString(),
            ),
          ),

          //商店电话
          Padding(
            padding: EdgeInsets.all(8.0),
            child: DialShopper(
              dialShopper: DataSrc().dialShopper,
            ),
          ),
          RecommendList(recommendList: DataSrc().recommendList),
        ],
      ),
    );
  }
}

// GridView 顶部导航TopNavigators栏的实现
class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({required this.navigatorList, super.key});

  Widget _gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print("Navigator-${item['mallCategoryName']} Clicked.");
      },
      child: Column(
        children: <Widget>[
          Image.network(
            item['image'],
            width: ScreenUtil().setWidth(30),
          ),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(200),
      padding: EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 3,
        padding: EdgeInsets.all(5.0),
        children: navigatorList.map(
          (item) {
            return _gridViewItemUI(context, item);
          },
        ).toList(),
      ),
    );
  }
}

// ADBanner条的实现，这个widget很简单，没什么可讲的内容，只是嵌套了一个图片进来
class ADBanner extends StatelessWidget {
  final String adPicture;
  const ADBanner({required this.adPicture, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 50,
      child: Image.asset(
        adPicture,
        // width: 200,
        //height: 20,
        fit: BoxFit.cover,
      ),
    );
  }
}

//商店电话
class DialShopper extends StatelessWidget {
  final Map dialShopper;
  DialShopper({required this.dialShopper, super.key});

  void _launchURL() async {
    String url = dialShopper["shopperPhone"];

    // if (await canLaunchUrl(Uri(
    //     scheme: "tel",
    //     path: url))) {
    try {
      await launchUrl(Uri(scheme: "tel", path: url));
    } catch (e) {
      print("Error: ${e}");
    }
    // }
    // else {
    //   throw "Cannot access the URL: $url...";
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _launchURL,
        child: Image.asset(
          dialShopper["shopperImage"],
        ),
      ),
    );
  }
}

//商品推荐列表（横滑）
class RecommendList extends StatelessWidget {
  final List recommendList;
  final String rListTitle = "商品推荐";
  RecommendList({required this.recommendList, super.key});

  Widget _rcommendListTitle(rListTitle) {
    ScreenUtil().setHeight(20);
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(5, 5, 0, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: Text(
        rListTitle,
        style: TextStyle(
          // TextDecoration(
          //   color: Colors.white,
          //   border: Border.all(color: Colors.black12, width: 3),
          // ),
          color: Colors.pink,
        ),
      ),
    );
  }

  Widget _recommendItem(index) {
    Map item = DataSrc().recommendList[index];
    // print(item["image"]);
    // print(item["mallprice"]);
    // print(item["price"]);
    return InkWell(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          // border: Border(
          //   left: BorderSide(width: 2.0, color: Colors.black12),
          // ),
          gradient: LinearGradient(
            stops: [0.02, 0.02],
            colors: [Colors.black12, Colors.white],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        width: ScreenUtil().setWidth(130),
        height: ScreenUtil().setHeight(100),
        child: Column(
          children: [
            Image.network(
              item["image"],
              // width: ScreenUtil().setWidth(130),
              height: ScreenUtil().setHeight(100),
              fit: BoxFit.cover,
            ),
            Text(
              "${item["mallprice"]}",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            Text(
              "${item["price"]}",
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recommendListView() {
    var rList = this.recommendList;
    return Container(
      width: ScreenUtil().setWidth(300),
      height: ScreenUtil().setHeight(150),
      margin: EdgeInsets.only(top: 10.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: rList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.only(top: 8.0),
            // decoration: BoxDecoration(
            //   border: BoxBorder().top,
            //   borderRadius: BorderRadius.all(Radius(3)),
            // ),
            child: _recommendItem(index),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _rcommendListTitle(rListTitle),
        _recommendListView(),
      ],
    );
  }
}
