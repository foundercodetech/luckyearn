// ignore_for_file: deprecated_member_use, prefer_typing_uninitialized_variables, depend_on_referenced_packages

import 'dart:convert';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/foundation.dart';
import 'package:luckyearn/generated/assets.dart';
import 'package:luckyearn/main.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/api_urls.dart';
import 'package:luckyearn/res/components/app_btn.dart';
import 'package:luckyearn/res/components/launcher.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/helper/api_helper.dart';
import 'package:luckyearn/view/home/mini/Aviator/test.dart';
import 'package:luckyearn/view/home/notification.dart';
import 'package:luckyearn/view/home/widgets/category_elements.dart';
import 'package:luckyearn/view/home/widgets/category_widgets.dart';
import 'package:luckyearn/view/home/widgets/slider_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    versionCheck();
    // TODO: implement initState
    super.initState();
  }
  BaseApiHelper baseApiHelper = BaseApiHelper();
  int selectedCategoryIndex = 0;

  bool verssionview = false;

  @override
  Widget build(BuildContext context) {


    Future.delayed(const Duration(seconds: 3), () => showAlert(context));

    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.secondaryappbar
          ),
        ),
        // title: Image.asset(Assets.imagesAppBarSecond,height: 36),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(Assets.imagesAppBarSecond,height: 30),
            Center(child: textWidget(text: "Welcome to Lucky Earn",color: AppColors.goldencolor,fontWeight: FontWeight.bold,fontSize: width*0.037)),
          ],
        ),
        actions: [
          kIsWeb==true?
          Row(
            children: [
              IconButton(
                onPressed: () {
                  _launchURL2();
                },
                icon: const Icon(Icons.download_for_offline,color:AppColors.goldencolor),
              ),
              IconButton(
                onPressed: () {
                  Launcher.openwhatsapp(context);
                },
                icon: const Icon(Icons.support_agent,color:AppColors.goldencolor),
              )
            ],
          ):
          IconButton(
            onPressed: () {
              Launcher.openwhatsapp(context);
            },
            icon: const Icon(Icons.support_agent,color:AppColors.goldencolor),
          ),
          // InkWell(
          //     onTap: (){
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=>const NotificationScreen()));
          //       // Navigator.push(context, MaterialPageRoute(builder: (context)=>const AviatorWait()));
          //     },
          //     child: Image.asset(Assets.iconsProNotification,height: height*0.07,)
          // ),

        ],
      ),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            children: [
              const SliderWidget(),
              Container(
                height: height*0.07,
                margin: const EdgeInsets.only(right: 10, left: 10),
                decoration: BoxDecoration( color: const Color(0xff3A3A3A),borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    const Icon(Icons.volume_up, color: AppColors.goldencolor),
                    SizedBox(width: width*0.01),
                    _rotate()
                    // AppBtn(
                    //   onTap: () {
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>RandomList()));
                    //   },
                    //   gradient: AppColors.goldenGradient,
                    //   height: height*0.04,
                    //   width: width* 0.30,
                    //   title: '🔥 Details',
                    //   hideBorder: true,
                    //   titleColor: AppColors.primaryTextColor,
                    // ),
                  ],
                ),
              ),
              CategoryWidget(
                onCategorySelected: (index) {
                  setState(() {
                    selectedCategoryIndex = index;
                  });
                },
              ),
              CategoryElement(selectedCategoryIndex: selectedCategoryIndex),
            ],
          ),
        ),
      ),
    );
  }
  Widget _rotate(){
    return Column(
      mainAxisSize: MainAxisSize.max,
      children:[
        DefaultTextStyle(
          style: const TextStyle(
              fontSize: 13,
              color: Colors.white
          ),
          child: AnimatedTextKit(
              repeatForever: true,
              isRepeatingAnimation: true,
              animatedTexts: [
                RotateAnimatedText('Please Fill In The Correct Bank Card Information.'),
                RotateAnimatedText('Been Approved By The Platform. The Bank'),
                RotateAnimatedText('Will Complete The Transfer Within 1-7 Working Days,'),
                RotateAnimatedText('But Delays May Occur, Especially During Holidays.But'),
                RotateAnimatedText('You Are Guaranteed To Receive Your Funds.'),
              ]),
        ),
      ],
    );


  }

  void showAlert(BuildContext context) {
    verssionview == true
        ? showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 80,
                  height: 100,
                  child: Image(image: AssetImage(Assets.imagesAppBarSecond)),
                ),
                const Text('new version are available',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
                Text(
                    'Update your app  ${ApiUrl.version}  to  $map',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    )),
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              _launchURL();
              if (kDebugMode) {
                print(versionlink);
                print("versionlink");
              }
            }, child: const Text("UPDATE"))

          ],
        ))
        : Container();
  }

  var map;
  var versionlink;

  Future<void> versionCheck() async {
    final response = await http.get(
      Uri.parse(ApiUrl.versionlink),
    );
   if (kDebugMode) {
     print(jsonDecode(response.body));

    }
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      if (kDebugMode) {
        print(responseData);
        print('rrrrrrrr');

      }
      if (responseData['version'] != ApiUrl.version) {
        setState(() {
          map = responseData['version'];
          versionlink = responseData['link'];
          verssionview=true;
        });
      } else {
        if (kDebugMode) {
          print('Version is up-to-date');
        }
      }
    } else {
      if (kDebugMode) {
        print('Failed to fetch version data');
      }
    }
  }

  _launchURL() async {
    var url = versionlink.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // _launchURL1() async {
  //   var url = 'https://telegram.me/Wingo01';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }


  _launchURL2() async {
    var url = "https://luckyearns.in/apk/luckyearns.apk";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


}