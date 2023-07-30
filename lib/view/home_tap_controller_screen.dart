import 'package:crypto_statistics/model/side_menu_model.dart';
import 'package:crypto_statistics/view/dashboard_screen_view.dart';
import 'package:crypto_statistics/view/transactions_scree_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeTapController extends StatefulWidget {
  const HomeTapController({Key? key}) : super(key: key);

  @override
  State<HomeTapController> createState() => _HomeTapControllerState();
}

class _HomeTapControllerState extends State<HomeTapController> {
  final List<SideMenu> _sideMenu = [
    SideMenu(imgUrl: "assets/icons/overview.svg", name: "Overview"),
    SideMenu(imgUrl: "assets/icons/transaction.svg", name: "Transactions"),
  ];
  final List<Widget> _screens = [
    const DashboardScreenView(),
    const TransactionsScreenView()
  ];
  int selectedComponent = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              color: const Color(0xff1B2028),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/icons/chainlink.svg",
                          color: const Color(0xff3A6FF8),
                          height: size.height * 0.05,
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Crypto",
                            style: TextStyle(
                                color: Color(0xffFFFFFF),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _sideMenu.length,
                      itemBuilder: (context, index) =>
                          _buildSideMenu(_sideMenu[index], index),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              child: _screens[selectedComponent],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSideMenu(SideMenu _component, int index) {
    return InkWell(
      onTap: () {
        selectedComponent = index;
        setState(() {});
      },
      child: Container(
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: selectedComponent == index
                ? const Color(0xff3A6FF8)
                : Colors.transparent),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: SvgPicture.asset(
                  _component.imgUrl,
                  color: const Color(0xffFFFFFF),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  _component.name,
                  style: const TextStyle(color: Color(0xffFFFFFF)),
                ))
          ],
        ),
      ),
    );
  }
}
