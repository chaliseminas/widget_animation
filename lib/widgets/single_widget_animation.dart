import 'dart:async';

import 'package:flutter/material.dart';
import 'package:widget_animation/enums/enums.dart';

class SingleWidgetAnimation extends StatefulWidget {

  ///widget to be animated
  final Widget child;

  ///animation offset
  final double offset;

  ///animation curve type
  final Curve curve;

  ///direction for animation
  final Direction direction;

  ///widget to start in delay
  final Duration delayStart;

  ///animation duration
  final Duration animationDuration;

  ///fade begin value
  final double fadeBegin;

  ///slide animation enable disable
  final bool enableSlideAnimation;
  final Animation<double>? fadeAnimation;

  const SingleWidgetAnimation({
    Key? key,
    required this.child,
    this.offset = 0.2,
    this.curve = Curves.easeIn,
    this.direction = Direction.vertical,
    this.delayStart = const Duration(seconds: 0),
    this.animationDuration = const Duration(milliseconds: 800),
    this.fadeBegin = -1.0,
    this.enableSlideAnimation = true,
    this.fadeAnimation,
  }) : super(key: key);

  @override
  State<SingleWidgetAnimation> createState() => _SingleWidgetAnimationState();
}

class _SingleWidgetAnimationState extends State<SingleWidgetAnimation> with SingleTickerProviderStateMixin {

  Animation<Offset>? _animationSlide;
  AnimationController? _animationController;
  late Animation<double> _animationFade;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    if (_isDisposed) {
      return;
    } else {
      _animationController = AnimationController(
        vsync: this,
        duration: widget.animationDuration,
      );

      if (widget.enableSlideAnimation) {
        if (widget.direction == Direction.vertical) {
          _animationSlide =
              Tween<Offset>(begin: Offset(0, widget.offset), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
                curve: widget.curve,
                parent: _animationController!,
              ));
        } else {
          _animationSlide =
              Tween<Offset>(begin: Offset(widget.offset, 0), end: const Offset(0, 0))
                  .animate(CurvedAnimation(
                curve: widget.curve,
                parent: _animationController!,
              ));
        }
      }

      _animationFade = widget.fadeAnimation ??
          Tween<double>(begin: widget.fadeBegin, end: 1.0).animate(
              CurvedAnimation(
                curve: widget.curve,
                parent: _animationController!,
              ));

      Timer(widget.delayStart, () {
        if (_animationController != null && !_isDisposed) {
          _animationController?.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _isDisposed = true;
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget child = widget.child;
    if (widget.enableSlideAnimation && _animationSlide != null) {
      child = SlideTransition(
        position: _animationSlide!,
        child: child,
      );
    }
    return FadeTransition(
      opacity: _animationFade,
      child: child,
    );
  }
}