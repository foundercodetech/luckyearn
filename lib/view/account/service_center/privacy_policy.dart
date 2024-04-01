// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:luckyearn/main.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/components/app_bar.dart';
import 'package:luckyearn/res/components/app_btn.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/helper/api_helper.dart';
import 'package:luckyearn/res/provider/privacypolicy_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {

  @override
  void initState() {
    fetchDataPrivacyPolicy();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final dataprivacy = Provider.of<PrivacyPolicyProvider>(context).PpData;


    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: const AppBackBtn(),
          title: textWidget(
              text: 'Privacy Policy',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: dataprivacy!= null?SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(dataprivacy.disc.toString(),textStyle: const TextStyle(color: AppColors.primaryTextColor),),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchDataPrivacyPolicy() async {
    try {
      final privacyDataa = await  baseApiHelper.fetchdataPP();
      print(privacyDataa);
      print("privacyDataa");
      if (privacyDataa != null) {
        Provider.of<PrivacyPolicyProvider>(context, listen: false).setPrivacy(privacyDataa);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
