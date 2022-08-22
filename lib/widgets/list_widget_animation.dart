import 'package:flutter/material.dart';
import 'package:widget_animation/widget_animation.dart';

class ListWidgetAnimation extends StatefulWidget {

  final List<Widget> children;
  final double offset;
  final Curve curve;
  final Direction direction;
  final Duration delayBetween;
  final Duration animationDuration;
  final bool enableLazyLoading;

  ListWidgetAnimation({
    Key? key,
    required this.children,
    this.offset = 0.2,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.enableLazyLoading = false,
    this.delayBetween = const Duration(milliseconds: 300),
    this.animationDuration = const Duration(milliseconds: 500)
  }) : assert(children.isNotEmpty), super(key: key);

  @override
  State<ListWidgetAnimation> createState() => _ListWidgetAnimationState();
}

class _ListWidgetAnimationState extends State<ListWidgetAnimation> {

  late List<Widget?> _animatedChildren;

  @override
  void initState() {
    super.initState();
    if (widget.enableLazyLoading) {
      return;
    } else {
      int length = widget.children.length;
      _animatedChildren = <Widget?>[];
      for (int i = 0; i < length; i++) {
        _animatedChildren[i] = SingleWidgetAnimation(
          animationDuration: widget.animationDuration,
          curve: widget.curve,
          offset: widget.offset,
          direction: widget.direction,
          delayStart: widget.delayBetween * (i + 1),
          child: widget.children[i]
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.enableLazyLoading) {
      return ListView.builder(
        itemCount: widget.children.length,
        itemBuilder: (BuildContext context, int index) {
          return SingleWidgetAnimation(
            delayStart: widget.delayBetween,
            animationDuration: widget.animationDuration,
            curve: widget.curve,
            direction: widget.direction,
            offset: widget.offset,
            child: widget.children[index],
          );
        });
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: _animatedChildren as List<Widget>,
      );
    }
  }
}