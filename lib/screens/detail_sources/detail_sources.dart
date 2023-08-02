import 'package:flutter/material.dart';
import 'package:pros_bot/components/common/menu_icon.dart';
import 'package:pros_bot/constants/app_colors.dart';
import 'package:pros_bot/screens/home/home.dart';

class DetailResources extends StatefulWidget {
  const DetailResources({Key key}) : super(key: key);

  // final String title;

  @override
  State<DetailResources> createState() => _DetailResourcesState();
}

class _DetailResourcesState extends State<DetailResources> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.PRIMARY_COLOR_NEW,
        actions: [
          IconButton(
              icon: Icon(
                Icons.home_filled,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) => false,
                );
              })
        ],
        centerTitle: true,
        title: Text('Detail Resources',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            )),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: AppColors.PRIMARY_COLOR_NEW,
      body: Container(
          color: AppColors.PRIMARY_COLOR_NEW,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // alignment: WrapAlignment.spaceBetween,
                children: [
                  Container(
                    width: size.width / 3.5,
                    height: size.width / 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/01.png"),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 4,
                    height: size.width / 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/02.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  Container(
                    width: size.width / 4,
                    height: size.width / 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/03.jpg"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  )
                ],
              ),
              for (int i = 0; i < 4; i++)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        width: size.width / 4,
                        height: size.width / 5,
                        child: Center(
                          child: Text(
                            '+',
                            style: TextStyle(fontSize: 50),
                          ),
                        ),
                      )
                  ],
                )
            ],
          )),
    );
  }
}
