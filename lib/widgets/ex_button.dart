import 'package:flutter/material.dart';

class ExButton extends StatefulWidget {
  final double? width, height;
  final EdgeInsetsGeometry? margin, padding;
  final String? text;
  final double? textSize;
  final FontWeight? textStyle;
  final double borderRadius;
  final bool enabled;
  final Function()? onClick;
  final IconData? icon;
  final double iconSize;
  final bool expended;
  final EdgeInsetsGeometry? iconPadding;
  final IconAlignment iconAlignment;
  final bool textAllCaps;

  final String? Function(ButtonState state)? textState;
  final IconData? Function(ButtonState state)? iconState;
  final Color? Function(ButtonState state)? colorState;
  final Color? Function(ButtonState state)? backgroundState;

  const ExButton({
    super.key,
    this.text,
    this.textSize = 16,
    this.textStyle,
    this.width,
    this.height,
    this.margin,
    this.padding,
    this.borderRadius = 0,
    this.enabled = true,
    this.onClick,
    this.icon,
    this.expended = false,
    this.iconSize = 18,
    this.iconPadding,
    this.iconAlignment = IconAlignment.end,
    this.textState,
    this.iconState,
    this.colorState,
    this.backgroundState,
    this.textAllCaps = false,
  });

  @override
  State<ExButton> createState() => _ExButtonState();
}

class _ExButtonState extends State<ExButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = widget.enabled && widget.onClick != null
        ? Colors.white
        : Colors.grey.shade400;
    final background = widget.enabled && widget.onClick != null
        ? theme.primaryColor
        : Colors.grey.shade200;

    return Container(
      margin: widget.margin,
      child: Material(
        color: widget.backgroundState?.call(state) ?? background,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: InkWell(
          onTap: widget.enabled ? widget.onClick : null,
          child: AbsorbPointer(
            child: Container(
              width: widget.width,
              height: widget.padding == null ? widget.height : null,
              padding: widget.padding ??
                  const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _IconView(
                    visible: (widget.iconState ?? widget.icon) != null &&
                        widget.iconAlignment == IconAlignment.start,
                    state: state,
                    icon: widget.icon,
                    iconState: widget.iconState,
                    color: color,
                    colorState: widget.colorState,
                    size: widget.iconSize,
                    padding: widget.iconPadding,
                  ),
                  if ((widget.iconState ?? widget.icon) != null &&
                      widget.iconAlignment == IconAlignment.start &&
                      widget.expended)
                    const Spacer(),
                  _TextView(
                    state: state,
                    primary: color,
                    text: widget.text,
                    textSize: widget.textSize,
                    textStyle: widget.textStyle,
                    textState: widget.textState,
                    colorState: widget.colorState,
                    textAllCaps: widget.textAllCaps,
                  ),
                  if ((widget.iconState ?? widget.icon) != null &&
                      widget.iconAlignment == IconAlignment.end &&
                      widget.expended)
                    const Spacer(),
                  _IconView(
                    visible: (widget.iconState ?? widget.icon) != null &&
                        widget.iconAlignment == IconAlignment.end,
                    state: state,
                    icon: widget.icon,
                    iconState: widget.iconState,
                    color: color,
                    colorState: widget.colorState,
                    size: widget.iconSize,
                    padding: widget.iconPadding,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  ButtonState get state {
    if (widget.enabled && widget.onClick != null) {
      return ButtonState.enabled;
    } else {
      return ButtonState.disabled;
    }
  }
}

class _TextView extends StatelessWidget {
  final Color? primary;
  final String? text;
  final double? textSize;
  final FontWeight? textStyle;
  final bool textAllCaps;
  final String? Function(ButtonState state)? textState;
  final Color? Function(ButtonState state)? colorState;
  final ButtonState state;

  const _TextView({
    Key? key,
    required this.state,
    this.primary,
    this.text,
    this.textSize = 14,
    this.textStyle,
    this.textState,
    this.colorState,
    this.textAllCaps = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = textState?.call(state) ?? text ?? "";
    return Text(
      textAllCaps ? title.toUpperCase() : title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: colorState?.call(state) ?? primary,
        fontSize: textSize,
        fontWeight: textStyle,
      ),
    );
  }
}

class _IconView extends StatelessWidget {
  final ButtonState state;
  final IconData? icon;
  final bool visible;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final double? size;
  final IconData? Function(ButtonState state)? iconState;
  final Color? Function(ButtonState state)? colorState;

  const _IconView({
    Key? key,
    required this.state,
    this.icon,
    this.visible = true,
    this.padding,
    this.color,
    this.size,
    this.iconState,
    this.colorState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: padding,
        child: Icon(
          iconState?.call(state) ?? icon,
          color: colorState?.call(state) ?? color,
          size: size,
        ),
      ),
    );
  }
}

enum IconAlignment {
  start,
  end,
}

enum ButtonState {
  disabled,
  enabled,
}
