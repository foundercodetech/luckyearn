import 'package:luckyearn/generated/assets.dart';
import 'package:luckyearn/main.dart';
import 'package:luckyearn/res/aap_colors.dart';
import 'package:luckyearn/res/components/text_widget.dart';
import 'package:luckyearn/res/provider/services/splash_service.dart';
import 'package:luckyearn/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatefulWidget {
  const Logout({super.key});

  @override
  State<Logout> createState() => _LogoutState();
}

SplashServices splashServices = SplashServices();


class _LogoutState extends State<Logout> {
  @override
  Widget build(BuildContext context) {

    return Dialog(
      backgroundColor: AppColors.scaffolddark,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        height: 270,
        width: width,
        child: Column(
          children: [
            const SizedBox(height: 15,),
            Container(
              height: 80,
              width: width*0.50,
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(image: AssetImage(Assets.imagesLogoutcancel))
              ),

            ),
            SizedBox(height: height / 30),
            Text("Do you want to logout?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: width * 0.06,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: height / 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.goldencolortwo)
                    ),
                    child: Center(
                      child: textWidget(
                          text: "Cancel",
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        color: AppColors.browntextprimary
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.remove('token');

                    Navigator.pushNamed(context,RoutesName.loginScreen);
                  },
                  child: Container(
                    height: height*0.06,
                    width: width*0.28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.goldencolortwo
                    ),
                    child: Center(
                      child: textWidget(
                        text: "Confirm",
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.browntextprimary
                      ),
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
