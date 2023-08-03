import 'package:crypto_statistics/dialog/new_transaction_dialog.dart';
import 'package:crypto_statistics/model/pop_menu_model.dart';
import 'package:crypto_statistics/utils/util_logic.dart';
import 'package:crypto_statistics/view/login_screen_view.dart';
import 'package:crypto_statistics/view_model/dashboard_screen_view_model.dart';
import 'package:crypto_statistics/view_model/login_screen_view_model.dart';
import 'package:crypto_statistics/view_model/transaction_screen_view_model.dart';
import 'package:crypto_statistics/widget/custom_pop_menu.dart';
import 'package:crypto_statistics/widget/custom_text_from_field.dart';
import 'package:crypto_statistics/widget/reload_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  final TextEditingController _search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // final dash = Provider.of<LoginViewModel>(context);
    final size = MediaQuery.of(context).size;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: Text(
            widget.title,
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
              controller: _search,
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
        ReloadButton(
          onTap: () {
            _reloadAll();
          },
        ),
        const Spacer(),
        _buildNotificationButton(),
        const Spacer(),
        _builUserPhotoPlaceHolder(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Selector<LoginViewModel, String>(
            selector: (context, listenTo) =>
                listenTo.userModel?.userName ?? "Not signed yet",
            builder: (context, userName, child) => Text(
              userName,
              style: const TextStyle(color: Color(0xffFFFFFF)),
            ),
          ),
        ),
        CustomPopMenu(
          popMenuModel: getList(context),
        )
      ],
    );
  }

  List<PopMenuModel> getList(BuildContext ctx) {
    List<PopMenuModel> menuItems = [];
    menuItems.add(
      PopMenuModel(
          icon: Icons.add,
          desc: "Transaction",
          onPressed: () {
            showDialog(
                context: ctx,
                barrierDismissible: false,
                builder: (context) => const NewTransactionDialog());
          }),
    );
    menuItems.add(
      PopMenuModel(
          icon: Icons.info,
          desc: "User info",
          onPressed: () {
            ctx.read<UtilLogic>().showUserInfo();
          }),
    );
    menuItems.add(
      PopMenuModel(
          icon: Icons.logout_outlined,
          desc: "Logout",
          onPressed: () {
            // ctx.read<LoginViewModel>()
            ctx.read<DashboardViewModel>().logOut();
            Navigator.pushReplacement(
                ctx,
                MaterialPageRoute(
                  builder: (context) => const LoginScreenView(),
                ));
          }),
    );
    return menuItems;
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

  void _reloadAll() {
    context.read<DashboardViewModel>().fetchUserPortfolo(context);
    context.read<DashboardViewModel>().fetchLiveData();
    context.read<TransactionViewModel>().fetchTransactions(context);
  }
}
