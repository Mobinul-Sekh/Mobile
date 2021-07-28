// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:bitecope/config/themes/theme.dart';
import 'package:bitecope/widgets/gradient_widget.dart';

class UnderlinedTitle extends StatefulWidget {
  final String title;
  final Gradient gradient;
  final double underlineOvershoot;

  const UnderlinedTitle({
    Key? key,
    required this.title,
    this.gradient = AppGradients.primaryGradient,
    this.underlineOvershoot = 60,
  }) : super(key: key);

  @override
  _UnderlinedTitleState createState() => _UnderlinedTitleState();
}

class _UnderlinedTitleState extends State<UnderlinedTitle> {
  final GlobalKey _titleKey = GlobalKey();
  double _underlineWidth = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _underlineWidth =
            _titleKey.currentContext!.size!.width + widget.underlineOvershoot;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Column(
        children: [
          GradientWidget(
            key: _titleKey,
            gradient: widget.gradient,
            child: Text(
              widget.title,
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          const SizedBox(height: 3),
          Container(
            height: 3,
            width: _underlineWidth,
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ],
      ),
    );
  }
}
