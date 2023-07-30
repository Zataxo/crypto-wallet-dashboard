import 'package:crypto_statistics/widget/custom_text_from_field.dart';
import 'package:flutter/material.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({Key? key, required this.search, required this.title})
      : super(key: key);
  final TextEditingController search;
  final String title;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            title,
            style: const TextStyle(
                color: Color(0xffFFFFFF),
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 3,
          child: SizedBox(
            width: size.width * 0.3,
            child: CustomTextFormField(
              controller: search,
              hintText: "Search",
              fillColor: const Color(0xff1B2028),
              inputColor: const Color(0xffFFFFFF),
              icon: const Icon(
                Icons.search,
                color: Color(0xff9E9E9E),
              ),
              hintTextStyle: const TextStyle(
                color: Color(0xff9E9E9E),
              ),
            ),
          ),
        ),
        const Spacer(),
        _buildNotificationButton(),
        const Spacer(),
        _builUserPhotoPlaceHolder(),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.0),
          child: Text(
            "Hassan Ismat",
            style: TextStyle(color: Color(0xffFFFFFF)),
          ),
        ),
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.keyboard_arrow_down_outlined,
              color: Color(0xff9E9E9E),
            ))
      ],
    );
  }

  Widget _buildNotificationButton() {
    return InkWell(
      onTap: () => print("Print"),
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xff1B2028),
        ),
        child: const Icon(
          Icons.notifications_outlined,
          color: Color(0xff9E9E9E),
        ),
      ),
    );
  }

  Container _builUserPhotoPlaceHolder() {
    return Container(
      // padding: const EdgeInsets.all(12),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color(0xff1B2028),
      ),
      child: Image.asset(
        "assets/imgs/profile.png",
        height: 25,
        fit: BoxFit.cover,
      ),
    );
  }
}
