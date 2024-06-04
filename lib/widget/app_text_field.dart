import 'package:flutter/material.dart';
import 'package:rider/constant/app_color.dart';
import 'package:rider/constant/font-family.dart';
import 'package:rider/constant/my_size.dart';
import 'package:rider/constant/style.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  const CustomTextFormFieldWidget({
    super.key,
    this.validator,
    this.controller,
    this.onSaved,
    this.hintText,
    this.hintStyle,
    this.onchanged,
    this.minLine,
    this.txtColor,
    this.icon,
    this.keyboardType,
    this.errorText,
    this.hintTpadding,
    this.sufixIconWidget,
    this.hintBpadding,
    this.border,
    this.hintRpadding,
    this.lblTxt,
    this.hintLpadding,
    this.fillColor,
    this.enable,
    this.maxLine,
    this.readOnly,
    this.prefixIcon,
    this.borderRadius,
    this.suffixTap,
    this.isCollapsed,
    this.isCapital,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final TextCapitalization? isCapital;
  final bool? readOnly;
  final void Function(String?)? onchanged;
  final bool? enable;
  final String? errorText;
  final bool? isCollapsed;

  final double? borderRadius;
  final String? hintText;
  final String? lblTxt;
  final TextStyle? hintStyle;

  final double? hintTpadding;
  final double? hintLpadding;
  final double? hintRpadding;
  final Widget? prefixIcon;
  final double? hintBpadding;
  final Color? txtColor;
  final Color? fillColor;
  final Widget? sufixIconWidget;
  final IconData? icon;
  final Color? border;
  final GestureTapCallback? suffixTap;
  final TextInputType? keyboardType;

  final int? minLine;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    MySize().init(
      context,
    );
    return Column(
      children: [

        TextFormField(
          keyboardType: keyboardType ?? TextInputType.text,
          style:  TextStyle(height: 1, color: black,fontFamily: FontFamily.primary1,fontSize: 14,fontWeight: FontWeight.w400),
          textCapitalization: isCapital == null
              ? TextCapitalization.none
              : TextCapitalization.words,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          textInputAction: TextInputAction.next,
          onSaved: onSaved,
          enabled: enable,

          controller: controller,
          readOnly: readOnly ?? false,
          validator: validator,
          minLines: minLine ?? 1,
          maxLines: maxLine ?? 1,
          onChanged: onchanged,
          decoration: InputDecoration(
            fillColor: fillColor ?? Colors.white,
            labelText: lblTxt,

            labelStyle: Styles.lable,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            filled: true,
            isDense: true,

            // suffixIconConstraints:
            //     BoxConstraints.loose(const Size.fromHeight(80)),
            prefixIcon: prefixIcon,
            errorText: errorText,


            prefixIconConstraints:
            BoxConstraints.loose(const Size.fromWidth(80)),
            isCollapsed: isCollapsed??false,
            suffixIcon: GestureDetector(
                onTap: suffixTap, child: sufixIconWidget ?? Icon(icon)),
            suffixStyle: const TextStyle(color: Colors.black),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: border ?? primary,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: border ?? primary,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? 8),
              borderSide: BorderSide(
                color: border ?? primary,
                width: 1.0,
              ),
            ),
            contentPadding: EdgeInsets.only(
              left: hintLpadding ?? 17.76,
              top: hintTpadding ?? 0,
              right: hintRpadding ?? 0.0,
              bottom: hintBpadding ?? 0.0,
            ),

            hintText: hintText,
            hintStyle: hintStyle ?? Styles.hint412,
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}

class CustomPasswordTextFormFieldWidget extends StatelessWidget {
  const CustomPasswordTextFormFieldWidget(
      {super.key,
        this.validator,
        this.controller,
        this.onSaved,
        this.hintText,
        this.onchanged,
        this.isEnable,
        required this.obscureText,
        this.icon,
        this.lblTxt,
        required this.suffixTap,
        this.minLine,
        this.maxLine});

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final void Function(String?)? onchanged;
  final String? hintText;
  final bool obscureText;
  final bool? isEnable;
  final String? lblTxt;
  final int? minLine;
  final IconData? icon;
  final GestureTapCallback suffixTap;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(height: 1),
      enabled: isEnable,
      obscureText: obscureText,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      onSaved: onSaved,
      controller: controller,
      validator: validator,
      minLines: minLine ?? 1,
      maxLines: maxLine ?? 1,
      onChanged: onchanged,
      decoration: InputDecoration(
        label: Text(
          lblTxt ?? "",
          style: Styles.lable,
        ),
        suffixIcon: GestureDetector(onTap: suffixTap, child: Icon(icon)),
        suffixStyle: const TextStyle(color: Colors.black),
        fillColor: Colors.white,
        labelStyle: Styles.lable,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        filled: true,
        isDense: true,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primary,
            width: 1.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primary,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(
            color: primary,
            width: 1.0,
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 17.76, right: 17.76),
        hintText: hintText,
        // hintStyle: Styles.primary14W400,
      ),
    );
  }
}

class CustomTextFormFieldSearch extends StatelessWidget {
  const CustomTextFormFieldSearch({
    super.key,
    this.validator,
    this.controller,
    this.onSaved,
    this.hintText,
    this.hintStyle,
    this.onchanged,
    this.minLine,
    this.txtColor,
    this.icon,
    this.keyboardType,
    this.hintTpadding,
    this.sufixIconWidget,
    this.hintBpadding,
    this.border,
    this.hintRpadding,
    this.lblTxt,
    this.hintLpadding,
    this.fillColor,
    this.enable,
    this.maxLine,
    this.readOnly,
    this.width,
    this.prefixIcon,
    this.borderRadius,
    this.suffixTap,
    this.isCapital,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final void Function(String?)? onSaved;
  final TextCapitalization? isCapital;
  final bool? readOnly;
  final void Function(String?)? onchanged;
  final bool? enable;

  final double? borderRadius;
  final String? hintText;
  final String? lblTxt;
  final TextStyle? hintStyle;

  final double? hintTpadding;
  final double? hintLpadding;
  final double? hintRpadding;
  final Widget? prefixIcon;
  final double? hintBpadding;
  final Color? txtColor;
  final Color? fillColor;
  final Widget? sufixIconWidget;
  final IconData? icon;
  final Color? border;
  final GestureTapCallback? suffixTap;
  final TextInputType? keyboardType;
  final double? width;
  final int? minLine;
  final int? maxLine;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(

          height: 45,
          width:width?? MySize.size200!,
          child: TextFormField(
            keyboardType: keyboardType ?? TextInputType.text,
            style: const TextStyle(height: 1, color: black),
            textCapitalization: isCapital == null
                ? TextCapitalization.none
                : TextCapitalization.words,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            textInputAction: TextInputAction.next,
            onSaved: onSaved,
            enabled: enable,
            controller: controller,
            readOnly: readOnly ?? false,
            validator: validator,
            minLines: minLine ?? 1,
            maxLines: maxLine ?? 1,
            onChanged: onchanged,
            decoration: InputDecoration(
              fillColor: fillColor ?? Colors.white,
              labelText: lblTxt,

              labelStyle: Styles.lable,
              floatingLabelBehavior: FloatingLabelBehavior.always,
              filled: true,
              isDense: true,

              // suffixIconConstraints:
              //     BoxConstraints.loose(const Size.fromHeight(80)),
              prefixIcon: prefixIcon,

              prefixIconConstraints:
              BoxConstraints.loose(const Size.fromWidth(80)),
              // isCollapsed: true,
              suffixIcon: GestureDetector(
                  onTap: suffixTap, child: sufixIconWidget ?? Icon(icon)),
              suffixStyle: const TextStyle(color: Colors.black),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(
                  color: border ?? primary,
                  width: 1.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(
                  color: border ?? primary,
                  width: 1.0,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius ?? 8),
                borderSide: BorderSide(
                  color: border ?? primary,
                  width: 1.0,
                ),
              ),
              contentPadding: const EdgeInsets.only(
                left: 10.0,
                top: 0,
                right: 2.0,
                bottom: 0.0,
              ),

              hintText: hintText,
              hintStyle: hintStyle ?? Styles.hint412,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}