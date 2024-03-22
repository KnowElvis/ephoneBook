import 'package:flutter/material.dart';

class FormContainerWidget extends StatefulWidget {
  final TextEditingController? controller;
  final Key? fieldKey;
  final bool? isPasswordField;
  final bool? isTextField;
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onFieldSubmitted;
  final TextInputType? keyboardType;
  final AutovalidateMode? autovalidateMode;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;


  const FormContainerWidget(
      {super.key,
      this.controller,
      this.fieldKey,
      this.isPasswordField,
      this.hintText,
      this.labelText,
      this.helperText,
      this.onSaved,
      this.validator,
      this.onFieldSubmitted,
      this.keyboardType,
      this.isTextField,
      this.autovalidateMode,
      this.onChanged});

  @override
  State<FormContainerWidget> createState() => _FormContainerWidgetState();
}

class _FormContainerWidgetState extends State<FormContainerWidget> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        key: widget.fieldKey,
        obscureText: widget.isPasswordField == true ? _obscureText : false,
        onSaved: widget.onSaved,
        validator: widget.validator,
        onFieldSubmitted: widget.onFieldSubmitted,
        autovalidateMode: widget.autovalidateMode,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.amber[50],
            hintText: widget.hintText,
            labelText: widget.labelText,
            helperText: widget.helperText,
            hintStyle: const TextStyle(color: Colors.black54),
            suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: widget.isPasswordField == true
                    ? Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                        color:
                            _obscureText == false ? Colors.blue : Colors.grey)
                    : const Text(''))),
      ),
    );
  }
}
