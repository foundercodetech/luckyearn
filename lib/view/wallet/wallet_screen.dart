// ignore_for_file: use_build_context_synchronously

import 'package:luckyearn/generated/assets.dart';
import 'package:luckyearn/main.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/components/app_bar.dart';
import 'package:luckyearn/res/components/app_btn.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/helper/api_helper.dart';
import 'package:luckyearn/utils/routes/routes_name.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luckyearn/view/wallet/wallet_history.dart';
import 'package:provider/provider.dart';

import '../../res/provider/wallet_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  BaseApiHelper baseApiHelper = BaseApiHelper();

  @override
  void initState() {
    walletfetch();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final userData = Provider.of<ProfileProvider>(context).userData;
    //
    final walletdetails = Provider.of<WalletProvider>(context).walletlist;

    
    return Scaffold(
      backgroundColor: AppColors.scaffolddark,

      appBar: GradientAppBar(

          title: textWidget(
              text: 'Wallet', fontSize: 25, color: AppColors.browntextprimary,),
          gradient: AppColors.goldenGradientDironecolor),
      body: walletdetails != null
          ? Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 135,
                      width: width,
                      decoration:   BoxDecoration(
                          gradient: AppColors.goldenGradientDir),
                      child: Column(
                        children: [
                          Image.asset(Assets.iconsWallets),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.currency_rupee,
                                  size: 20, color: AppColors.browntextprimary),
                              textWidget(
                                  text: walletdetails.wallet.toString(),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20,
                                  color:AppColors.browntextprimary,),
                              InkWell(
                                  onTap: (){
                                    walletfetch();
                                  },
                                  child: Image.asset(Assets.iconsTotalBal,color: AppColors.browntextprimary,height: height*0.03,)),
                            ],
                          ),
                          textWidget(
                            text: 'Total Balance',
                            color: AppColors.browntextprimary,
                            fontSize: 14,

                          ),
                          const SizedBox(height: 40)
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: height * 0.13,
                    child: Container(
                      height: height * 0.38,
                      width: width * 0.95,
                      decoration: BoxDecoration(
                          gradient: AppColors.secondaryappbar,
                          borderRadius: BorderRadiusDirectional.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 35, 15, 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Winning Wallet",
                                                type: "1")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.goldenGradientDir,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Winning Wallet",
                                            fontSize: 12,
                                            color: AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.winning_wallet}",
                                            fontSize: 13,
                                            color: AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Bonus",
                                                type: "2")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.goldenGradientDir,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Bonus",
                                            fontSize: 12,
                                            color: AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.bonus}",
                                            fontSize: 13,
                                            color: AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => const WalletHistory(
                                                name: "Commission",
                                                type: "3")));
                                  },
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)),
                                    child: Container(
                                      height: height * 0.10,
                                      width: width * 0.25,
                                      decoration: BoxDecoration(
                                        gradient: AppColors.goldenGradientDir,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          textWidget(
                                            text: "Commission",
                                            fontSize: 12,
                                            color: AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                          textWidget(
                                            text: "₹ ${walletdetails.commission}",
                                            fontSize: 13,
                                            color:AppColors.browntextprimary,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // AppBtn(
                            //   titleColor: AppColors.browntextprimary,
                            //   gradient: AppColors.goldenGradientDir,
                            //   hideBorder: true,
                            //   title: 'Main wallet transfer',
                            //   fontSize: 18,
                            //   fontWeight: FontWeight.w900,
                            // ),
                            // const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                itemWidget(() {
                                  Navigator.pushNamed(context, RoutesName.depositScreen);
                                }, Assets.iconsProDeposit, 'Deposit'),
                                itemWidget(() {
                                  Navigator.pushNamed(context, RoutesName.withdrawScreen);
                                }, Assets.iconsProWithdraw, 'Withdraw'),

                              ],
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            )
          : Container(),
    );
  }

  Future<void> walletfetch() async {
    try {
      if (kDebugMode) {
        print("qwerfghj");
      }
      final wallet_data = await baseApiHelper.fetchWalletData();
      if (kDebugMode) {
        print(wallet_data);
        print("wallet_data");
      }
      Provider.of<WalletProvider>(context, listen: false).setWalletList(wallet_data!);
    } catch (error) {
      if (kDebugMode) {
        print("hiiii $error");
      }
    }
  }


  Widget itemWidget(Function()? onTap, String image, String title) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(image, height: 50),
          const SizedBox(height: 10),
          textWidget(
              text: title,
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: AppColors.secondaryTextColor),
        ],
      ),
    );
  }
}
