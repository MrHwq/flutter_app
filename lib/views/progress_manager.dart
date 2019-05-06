import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/wave/WavePainterFactory.dart';

class ProgressManager extends StatefulWidget {
    @override
    _ProgressManagerState createState() =>
        _ProgressManagerState()
            .._factory = WavePainterFactory();
}

class _ProgressManagerState extends State<ProgressManager>
    with TickerProviderStateMixin {
    AnimationController xController;
    AnimationController yController;
    Animation<double> xAnimation;
    Animation<double> yAnimation;
    List<double> _progressList = [];
    double curProgress = 0;
    BasePainterFactory _factory;

    set painter(BasePainterFactory factory) {
        _factory = factory;
    }

    setProgress(double progress) {
        _progressList.add(progress);
        onProgressChange();
    }

    onProgressChange() {
        if (_progressList.length > 0) {
            if (yController != null && yController.isAnimating) {
                return;
            }
            double nextProgress = _progressList[0];
            _progressList.removeAt(0);
            final double begin = curProgress;
            yController = AnimationController(
                vsync: this, duration: Duration(milliseconds: 1000));
            yAnimation = Tween(begin: begin, end: nextProgress).animate(yController);
            yAnimation.addListener(_onProgressChange);
            yAnimation.addStatusListener(_onProgressStatusChange);
            yController.forward();
        }
    }

    Timer timer;

    @override
    void initState() {
        super.initState();
        xController = AnimationController(vsync: this, duration: Duration(milliseconds: 4000));
        xAnimation = Tween(begin: 0.0, end: 1.0).animate(xController);
        xAnimation.addListener(_change);
        yController = AnimationController(vsync: this, duration: Duration(milliseconds: 5000));
        yAnimation = Tween(begin: 0.0, end: 1.0).animate(yController);
        yAnimation.addListener(_onProgressChange);
        yAnimation.addStatusListener(_onProgressStatusChange);

        doDelay(xController, 0);

        timer = Timer.periodic(Duration(seconds: 2), (timer) {
            setProgress(timer.tick > 100 ? 1 : 0.01 * timer.tick);
            print(timer.tick);
        });
//        Future.delayed(Duration(milliseconds: 3000), () {
//            setProgress(0.66);
//        });
    }

    @override
    Widget build(BuildContext context) {
        return Center(
            child:
            Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 400.0,
                child: CustomPaint(
                    painter: _factory.getPainter()
                        ..XAnimation = xAnimation
                        ..YAnimation = yAnimation,
                    size: Size(MediaQuery
                        .of(context)
                        .size
                        .width, 400.0),
                ),
            ),
        );
    }

    void _change() {
        setState(() {});
    }

    void _onProgressChange() {
        setState(() {
            curProgress = yAnimation.value;
        });
    }

    void _onProgressStatusChange(status) {
        if (status == AnimationStatus.completed) {
            onProgressChange();
        }
    }

    void doDelay(AnimationController controller, int delay) async {
        Future.delayed(Duration(milliseconds: delay), () {
            controller..repeat();
        });
    }

    @override
    void dispose() {
        xController.dispose();
        yController.dispose();
        xAnimation.removeListener(_change);
        yAnimation.removeListener(_onProgressChange);
        yAnimation.removeStatusListener(_onProgressStatusChange);
        timer.cancel();
        super.dispose();
    }
}