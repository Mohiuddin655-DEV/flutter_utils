import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/models/state_value.dart';
import 'view.dart';

class EditText extends StatefulWidget {
  final EditTextController? controller;
  final bool autoFocus;
  final double? width;
  final double border;
  final Color? borderColor;
  final bool borderHighlight;
  final bool enabled;
  final Color? primary;
  final Color? background;
  final String? text;
  final double textSize;
  final Color? textColor;
  final String hint;
  final Color? hintColor;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding, margin;
  final double borderRadius;
  final String? digits;
  final DrawableIcon? drawableStart;
  final DrawableIcon? drawableEnd;
  final double drawableSize;
  final double drawablePadding;
  final StateValue<Color>? drawableTint;
  final TextInputType inputType;
  final bool obscureText;

  final OnChangeListener? onChange;

  const EditText({
    Key? key,
    required this.hint,
    this.autoFocus = false,
    this.width,
    this.hintColor,
    this.border = 0,
    this.borderColor,
    this.borderHighlight = true,
    this.borderRadius = 0,
    this.enabled = true,
    this.primary,
    this.controller,
    this.text,
    this.textAlign = TextAlign.start,
    this.textColor,
    this.textSize = 18,
    this.background,
    this.padding,
    this.margin,
    this.digits,
    this.drawableStart,
    this.drawableEnd,
    this.drawableSize = 18,
    this.drawablePadding = 12,
    this.drawableTint,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.onChange,
  }) : super(key: key);

  @override
  State<EditText> createState() => _EditTextState();
}

class _EditTextState extends State<EditText> {
  late EditTextController controller;

  @override
  void initState() {
    controller = widget.controller ?? EditTextController();
    initController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant EditText oldWidget) {
    initController();
    super.didUpdateWidget(oldWidget);
  }

  void initController() {
    controller._editable.text = widget.text ?? "";
    controller.autoFocus = widget.autoFocus;
    controller.width = widget.width;
    controller.border = widget.border;
    controller.borderColor = widget.borderColor;
    controller.borderHighlight = widget.borderHighlight;
    controller.primary = widget.primary;
    controller.background = widget.background;
    controller.textSize = widget.textSize;
    controller.textColor = widget.textColor;
    controller.hint = widget.hint;
    controller.hintColor = widget.hintColor;
    controller.textAlign = widget.textAlign;
    controller.padding = widget.padding;
    controller.margin = widget.margin;
    controller.borderRadius = widget.borderRadius;
    controller.digits = widget.digits;
    controller.drawableStart = widget.drawableStart;
    controller.drawableEnd = widget.drawableEnd;
    controller.drawablePadding = widget.drawablePadding;
    controller.drawableSize = widget.drawableSize;
    controller.drawableTint = widget.drawableTint;
    controller.inputType = widget.inputType;
    controller.obscureText = widget.obscureText;
    controller.onChange = widget.onChange;
    controller.setNotifier(setState);
  }

  @override
  void dispose() {
    controller._dispose();
    super.dispose();
  }

  dynamic get iStart => controller.drawableStart?.detect(controller.isFocused);

  dynamic get iEnd => controller.drawableEnd?.detect(controller.isFocused);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = controller.primary ?? theme.primaryColor;
    const secondaryColor = Color(0xffbbbbbb);
    const underlineColor = Color(0xffe1e1e1);
    var drawableTint = controller.drawableTint ??
        StateValue<Color>(
          active: primaryColor,
          inactive: secondaryColor,
        );
    var style = TextStyle(
      color: controller.textColor ?? Colors.black,
      fontSize: controller.textSize,
    );
    return Container(
      width: controller.width ?? 0,
      margin: controller.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding:
                controller.padding ?? const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: controller.background,
              border: controller.border > 0
                  ? Border.all(
                      width: controller.borderHighlight
                          ? controller.isFocused
                              ? controller.border * 1.5
                              : controller.border
                          : controller.border,
                      color: controller.borderColor ?? primaryColor,
                    )
                  : null,
              borderRadius: BorderRadius.circular(controller.borderRadius),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  if (controller.drawableStart != null)
                    _Drawable(
                      icon: controller.drawableStart!,
                      size: controller.drawableSize,
                      focused: controller.isFocused,
                      tint: drawableTint,
                      padding: EdgeInsets.only(
                        right: controller.drawablePadding,
                      ),
                    ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (controller.text.isEmpty)
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              controller.hint,
                              textAlign: controller.textAlign,
                              style: style.copyWith(
                                color: controller.hintColor ?? secondaryColor,
                                fontFamily: "",
                              ),
                            ),
                          ),
                        EditableText(
                          textAlign: controller.textAlign,
                          controller: controller._editable,
                          focusNode: controller._node,
                          autofocus: controller.autoFocus,
                          style: style,
                          cursorHeight: controller.textSize,
                          cursorColor: primaryColor,
                          obscureText: controller.obscureText,
                          backgroundCursorColor: primaryColor,
                          onChanged: controller._handleEditingChange,
                          inputFormatters: controller.formatter,
                        ),
                      ],
                    ),
                  ),
                  if (controller.drawableEnd != null)
                    _Drawable(
                      icon: controller.drawableEnd!,
                      size: controller.drawableSize,
                      focused: controller.isFocused,
                      tint: drawableTint,
                      padding: EdgeInsets.only(
                        left: controller.drawablePadding / 2,
                      ),
                    )
                ],
              ),
            ),
          ),
          _Underline(
            visible: controller.background == null && controller.border <= 0,
            focused: controller.isFocused,
            enabled: controller.enabled,
            height: 1,
            primary: primaryColor,
            colorState: StateValue(
              active: primaryColor,
              inactive: underlineColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _Underline extends StatelessWidget {
  final Color? primary;
  final bool visible;
  final bool enabled;
  final bool focused;
  final double height;
  final StateValue<Color>? colorState;

  const _Underline({
    Key? key,
    this.primary,
    this.visible = true,
    this.enabled = true,
    this.focused = false,
    this.colorState,
    this.height = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = colorState ??
        StateValue<Color?>(
          active: primary,
          inactive: Colors.grey.withOpacity(0.2),
        );
    return Visibility(
      visible: visible,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.detect(enabled),
            ),
            height: focused ? height * 2 : height,
          ),
          SizedBox(
            height: focused ? 0 : height,
          ),
        ],
      ),
    );
  }
}

class _Drawable extends StatelessWidget {
  final bool focused;
  final DrawableIcon icon;
  final double size;
  final StateValue<Color>? tint;
  final EdgeInsetsGeometry? padding;

  const _Drawable({
    Key? key,
    required this.icon,
    this.focused = false,
    this.size = 18,
    this.tint,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = tint ??
        StateValue(
          active: Theme.of(context).primaryColor,
          inactive: Colors.grey,
        );
    final drawable = icon.detect(focused);
    print("${color.detect(focused)}");
    return Container(
      margin: padding,
      width: size,
      height: size,
      child: FittedBox(
        child: drawable is String
            ? SvgPicture.asset(
                drawable,
                width: size,
                height: size,
                color: color.detect(focused),
              )
            : drawable is IconData
                ? Icon(
                    drawable,
                    size: size,
                    color: color.detect(focused),
                  )
                : null,
      ),
    );
  }
}

class DrawableIcon<T> {
  final T active;
  final T inactive;

  const DrawableIcon({
    required this.active,
    dynamic inactive,
  }) : inactive = inactive ?? active;

  T detect(bool isActivated) => isActivated ? active : inactive;
}

class EditTextController extends ViewController {
  late TextEditingController _editable;
  late FocusNode _node;
  bool? _focused;

  bool autoFocus = false;
  double? width;
  double border = 0;
  Color? borderColor;
  bool borderHighlight = true;
  Color? primary;
  Color? background;
  double textSize = 18;
  Color? textColor;
  String hint = "";
  Color? hintColor;
  TextAlign textAlign = TextAlign.start;
  EdgeInsetsGeometry? padding, margin;
  double borderRadius = 0;
  String? digits;
  DrawableIcon? drawableStart;
  DrawableIcon? drawableEnd;
  double drawableSize = 18;
  double drawablePadding = 12;
  StateValue<Color>? drawableTint;
  TextInputType inputType = TextInputType.text;
  bool obscureText = false;

  late Function(String tag, bool valid)? onChecked;
  late Future<bool> Function(String)? onExecute;

  EditTextController() {
    _editable = TextEditingController();
    _node = FocusNode();
    _node.addListener(_handleFocusChange);
  }

  bool get isFocused => _focused ?? false;

  set text(String? value) => _editable.text = value ?? "";

  String get text => _editable.text;

  void _handleFocusChange() {
    if (_node.hasFocus != _focused) {
      _focused = _node.hasFocus;
      notify;
    }
  }

  void _handleEditingChange(String value) {
    onChange?.call(value);
    notify;
  }

  List<TextInputFormatter>? get formatter {
    final digit = digits ?? "";
    if (digit.isNotEmpty) {
      return [
        FilteringTextInputFormatter.allow(RegExp("[$digit]")),
      ];
    }
    return null;
  }

  void _dispose() {
    _editable.dispose();
    _node.dispose();
  }
}
