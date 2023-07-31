import 'package:crypto_statistics/model/pop_menu_model.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';

class CustomPopMenu extends StatefulWidget {
  const CustomPopMenu({
    Key? key,
    required this.popMenuModel,
  }) : super(key: key);
  final List<PopMenuModel> popMenuModel;
  @override
  State<CustomPopMenu> createState() => _CustomPopMenuState();
}

class _CustomPopMenuState extends State<CustomPopMenu> {
  final CustomPopupMenuController _controller = CustomPopupMenuController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return CustomPopupMenu(
      child: Container(
        child: const Icon(Icons.keyboard_arrow_down_outlined,
            color: Color(0xffBDBDBD)),
        padding: const EdgeInsets.all(20),
      ),
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.transparent,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.popMenuModel
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        item.onPressed();
                        _controller.hideMenu();
                      },
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.1,
                        decoration:
                            const BoxDecoration(color: Color(0xff1B2028)),
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          children: [
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Icon(
                                    item.icon,
                                    color: const Color(0xffFFFFFF),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    margin: const EdgeInsets.only(left: 10),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Text(
                                      item.desc,
                                      style: const TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 1,
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: _controller,
    );
  }
}
