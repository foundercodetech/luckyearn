import 'package:luckyearn/main.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/components/app_bar.dart';
import 'package:luckyearn/res/components/app_btn.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/helper/api_helper.dart';
import 'package:luckyearn/res/provider/TermsConditionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';


class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  State<TermsCondition> createState() => _TermsConditionState();
}

class _TermsConditionState extends State<TermsCondition> {

  @override
  void initState() {
    fetchtc();
    // TODO: implement initState
    super.initState();
  }

  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  Widget build(BuildContext context) {

    final DataTc = Provider.of<TermsConditionProvider>(context).TcData;


    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
        leading: AppBackBtn(),
          title: textWidget(
              text: 'Terms and Condition',
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.primaryappbargrey),
      body: DataTc!= null?Container(
        height: height,
        width: width,
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: HtmlWidget(DataTc.disc.toString(),textStyle: const TextStyle(color: AppColors.primaryTextColor)),
                ),

              ],
            )),


      ):Container(),
    ));
  }
  Future<void> fetchtc() async {
    try {
      final Dataterms = await  baseApiHelper.fetchdataTC();
      print(Dataterms);
      print("Dataterms");
      if (Dataterms != null) {
        Provider.of<TermsConditionProvider>(context, listen: false).setterms(Dataterms);
      }
    } catch (error) {
      // Handle error here
    }
  }

}
