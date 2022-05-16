import 'package:flutter/material.dart';

class NameFormField extends StatefulWidget {
  final Function(String)? name;
  const NameFormField({Key? key, this.name}) : super(key: key);

  @override
  State<NameFormField> createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<NameFormField> {
  final _controllerName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controllerName,
      textAlign: TextAlign.center,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      maxLength: 21,
      validator: (value) {
        var name = value ?? '';
        name = name.replaceAll(' ', '');
        if (name.isEmpty) {
          return 'Tidak boleh kosong';
        }
        if (name.length < 2) {
          return 'Min 2 huruf';
        }
        return null;
      },
      onSaved: (value) {
        var name = value ?? '';
        name = name.trim();
        var nameFunc = widget.name;
        if (name.isNotEmpty && nameFunc != null) {
          nameFunc(name);
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerName.dispose();
  }
}
