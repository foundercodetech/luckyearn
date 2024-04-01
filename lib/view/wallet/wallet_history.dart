// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'dart:convert';
import 'package:luckyearn/generated/assets.dart';
import 'package:luckyearn/main.dart';
import 'package:luckyearn/model/user_model.dart';
import 'package:luckyearn/model/wallet_history_model.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/api_urls.dart';
import 'package:luckyearn/res/components/app_bar.dart';
import 'package:luckyearn/res/components/app_btn.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/provider/user_view_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;



class WalletHistory extends StatefulWidget {
  final String? name;
  final String? type;
  const WalletHistory({super.key, this.name,this.type});

  @override
  State<WalletHistory> createState() => _WalletHistoryState();
}

class _WalletHistoryState extends State<WalletHistory> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    WalletHistoryyy();
    super.initState();
  }

  int ?responseStatuscode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,
      appBar: GradientAppBar(
          leading: const AppBackBtn(),
          title: textWidget(
              text:widget.name.toString(),
              fontSize: 25,
              color: AppColors.primaryTextColor),
          gradient: AppColors.secondaryappbar),
      body: ScrollConfiguration(
        behavior: const ScrollBehavior().copyWith(overscroll: false),
        child: ListView(
          shrinkWrap: true,
          physics: const ClampingScrollPhysics(),
          children: [
            responseStatuscode== 400 ?
            const Notfounddata(): historyItem.isEmpty? const Center(child: CircularProgressIndicator()):
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: historyItem.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 3,
                        color: Color(0xFF3f3f3f),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Container(
                          decoration: BoxDecoration(gradient: AppColors.secondaryappbar,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              const SizedBox(height: 4),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Balance",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    textWidget(
                                        text: "₹${historyItem[index].amount}",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor)
                                  ],
                                ),
                              ),
                              Padding(
                                padding:  const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Type",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    textWidget(
                                        text: historyItem[index].type=="1"?"Winning":historyItem[index].type=="2"?"Bonus":"Commission",
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.primaryTextColor),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                        text: "Time",
                                        fontSize: width * 0.04,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.secondaryTextColor),
                                    Text(DateFormat("dd-MMM-yyyy, hh:mm a").format(
                                        DateTime.parse(historyItem[index].datetime.toString())),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
          ],
        ),
      ),

    );
  }

  UserViewProvider userProvider = UserViewProvider();

  List<WalletHistoryModal> historyItem = [];

  Future<void> WalletHistoryyy() async {
    var type= widget.type.toString();
    UserModel user = await userProvider.getUser();
    String token = user.id.toString();

    final response = await http.get(Uri.parse("${ApiUrl.walletHistory}$token&typeid=$type"),);
    if (kDebugMode) {
      print("${ApiUrl.walletHistory}$token&typeid=$type");
      print('WalletHistory');
    }

    setState(() {
      responseStatuscode = response.statusCode;
    });

    if (response.statusCode==200) {
      final List<dynamic> responseData = json.decode(response.body)['data'];
      setState(() {

        historyItem = responseData.map((item) => WalletHistoryModal.fromJson(item)).toList();
        // selectedIndex = items.isNotEmpty ? 0:-1; //
      });

    }
    else if(response.statusCode==400){
      if (kDebugMode) {
        print('Data not found');
      }
    }
    else {
      setState(() {
        historyItem = [];
      });
      throw Exception('Failed to load data');
    }
  }

}

class Notfounddata extends StatelessWidget {
  const Notfounddata({super.key});

  @override
  Widget build(BuildContext context){
    final heights = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(Assets.imagesNoDataAvailable),
          height: heights / 3,
          width: width / 2,
        ),
        const Text("Data not found",style: TextStyle(color: AppColors.primaryTextColor),)
      ],
    );
  }

}


