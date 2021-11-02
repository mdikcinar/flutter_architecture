import 'package:flutter/material.dart';

class RateWidget extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  const RateWidget({Key? key, this.onChanged}) : super(key: key);

  @override
  _RateWidgetState createState() => _RateWidgetState();
}

class _RateWidgetState extends State<RateWidget> {
  int currentRate = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 1; i <= 5; i++)
          InkWell(
            onTap: () {
              currentRate = i;
              if (widget.onChanged != null) {
                widget.onChanged!(i);
              }
              setState(() {});
            },
            child: Icon(
              Icons.star_rate_rounded,
              color: currentRate >= i ? Colors.yellow : Theme.of(context).textTheme.headline1!.color,
              size: 35,
            ),
          ),
      ],
    );
  }
}
