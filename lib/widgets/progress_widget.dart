import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:landlord_tenent/utils/utils.dart';

class ProgressWidget extends StatelessWidget {
  final Widget child;
  final bool isShow;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  const ProgressWidget({
    Key? key,
    required this.child,
    required this.isShow,
    this.opacity = 0.3,
    this.color = Colors.grey,
    required this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (isShow) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: Utils.isAndroidPlatform()
                ? CircularProgressIndicator(
                    valueColor: valueColor,
                  )
                : const CupertinoActivityIndicator(
                    animating: true,
                  ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}
