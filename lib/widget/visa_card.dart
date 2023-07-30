import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VisaCard extends StatelessWidget {
  const VisaCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, bottom: 5, right: 5),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: const Color(0xff1573FE),
          borderRadius: BorderRadius.circular(15)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Credit Card",
                  style: TextStyle(
                      color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
                ),
                SvgPicture.asset(
                  "assets/icons/chip.svg",
                )
              ],
            ),
            const Text(
              "3475 7381 3759 4512",
              style: TextStyle(color: Color(0xffFFFFFF)),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Hassan Ismat",
                  style: TextStyle(color: Color(0xffFFFFFF)),
                ),
                Text(
                  "VISA",
                  style: TextStyle(
                      color: Color(0xffFFFFFF), fontWeight: FontWeight.bold),
                )
              ],
            ),
          ]),
    );
  }
}
