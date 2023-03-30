import 'package:book_relax_flutter_app/component/auto_rotating.dart';
import 'package:flutter/material.dart';

class ElevatedButtonWithLoading extends StatelessWidget {
  // 是否加载中
  final bool loading;

  // button的onPressed事件
  final VoidCallback? onPressed;

  // 延迟显示时间间隔（防抖）
  final Duration delayDuration;

  // 子组件
  final Widget child;

  const ElevatedButtonWithLoading({
    super.key,
    required this.loading,
    required this.onPressed,
    this.delayDuration = const Duration(milliseconds: 200),
    required this.child,
  });

  Widget get _button {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: child,
    );
  }

  Widget get _iconButton {
    return ElevatedButton.icon(
      onPressed: loading ? null : onPressed,
      icon: AutoRotatingWidget(
        duration: const Duration(seconds: 1),
        child: Icon(
          Icons.autorenew,
          color: Colors.white.withOpacity(0.8),
        ),
      ),
      label: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return FutureBuilder(
        future: Future.delayed(delayDuration).then((value) => true),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return snapshot.hasData ? _iconButton : _button;
        },
      );
    }

    return _button;
  }
}

class CircleButton extends StatelessWidget {
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? disabledColor;
  final Widget child;

  const CircleButton({
    Key? key,
    this.height,
    this.onPressed,
    this.color,
    required this.child,
    this.disabledColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const CircleBorder(),
      height: height,
      onPressed: onPressed,
      color: color,
      disabledColor: disabledColor,
      child: child,
    );
  }
}

class CircleIconButton extends StatelessWidget {
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? disabledColor;
  final Icon icon;

  const CircleIconButton({
    Key? key,
    this.height,
    this.onPressed,
    this.color,
    this.disabledColor,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      height: height,
      onPressed: onPressed,
      color: color,
      disabledColor: disabledColor,
      child: icon,
    );
  }
}

class CircleIconButtonWithLoading extends StatelessWidget {
  final double? height;
  final VoidCallback? onPressed;
  final Color? color;
  final Icon icon;

  // 是否加载中
  final bool loading;

  // 延迟显示时间间隔（防抖）
  final Duration delayDuration;

  const CircleIconButtonWithLoading({
    Key? key,
    this.height,
    this.onPressed,
    this.color,
    required this.icon,
    required this.loading,
    this.delayDuration = const Duration(milliseconds: 200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleButton(
      height: height,
      onPressed: loading ? null : onPressed,
      color: color,
      disabledColor: color,
      child: loading
          ? AutoRotatingWidget(
              duration: const Duration(seconds: 1),
              child: Icon(
                Icons.autorenew,
                color: Colors.white.withOpacity(0.8),
              ),
            )
          : icon,
    );
  }
}
