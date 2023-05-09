import 'package:flutter/material.dart';
import 'package:landlord_tenent/utils/utils.dart';

class HorizontalList extends StatefulWidget {
  final List<Widget> children;
  final ScrollPhysics? scrollPhysics;

  const HorizontalList({Key? key, required this.children, this.scrollPhysics})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _HorizontalListState();
}

class _HorizontalListState extends State<HorizontalList> {
  Screen? size;

  @override
  Widget build(BuildContext context) {
    size = Screen(MediaQuery.of(context).size);

    return Container(
      padding: EdgeInsets.all(size!.getWidthPx(4)),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const ClampingScrollPhysics(),
        child: Row(
          children: widget.children,
        ),
      ),
    );
  }
}
