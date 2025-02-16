import 'package:flutter/material.dart';
import '../constants/color_constants.dart';

class CDropdownFormField<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final String? label;
  final String? Function(T?)? validator;
  final void Function(T?)? onChanged;

  const CDropdownFormField({
    super.key,
    required this.items,
    this.value,
    this.label,
    this.validator,
    this.onChanged,
  });

  @override
  State<CDropdownFormField> createState() => _CDropdownFormFieldState();
}

class _CDropdownFormFieldState extends State<CDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      value: widget.value,
      style: Theme.of(context).textTheme.bodyMedium,
      items: widget.items,
      dropdownColor: Colors.black,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: ColorConstants.primaryColor),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        labelText: widget.label,
        labelStyle: Theme.of(context).textTheme.bodyMedium,
      ),
      validator: widget.validator,
    );
  }
}
