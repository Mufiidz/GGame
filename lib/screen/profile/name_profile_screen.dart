import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/app_route.dart';
import 'viewmodel/profile_viewmodel.dart';

class NameProfileScreen extends StatefulWidget {
  const NameProfileScreen({Key? key}) : super(key: key);

  @override
  State<NameProfileScreen> createState() => _NameProfileScreenState();
}

class _NameProfileScreenState extends State<NameProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerName = TextEditingController();
  late ProfileViewModel _viewmodel;
  String _newName = '';
  String _name = '';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    _viewmodel = context.read<ProfileViewModel>()..getProfile();
    context.select<ProfileViewModel, String>((value) {
      _controllerName.text = value.name;
      _name = value.name;
      return value.name;
    });
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Change Name'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Change your new name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: TextFormField(
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

                      if (name == _name) {
                        return 'Nama tidak boleh sama seperti sebelumnya';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      var name = value ?? '';
                      name = name.trim();
                      if (name.isNotEmpty) {
                        _newName = name;
                      }
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                  width: size.width,
                  height: 40,
                  child: ElevatedButton(
                      onPressed: () => _onSaved(), child: const Text('Save')))
            ],
          ),
        ),
      ),
    );
  }

  _onSaved() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState?.save();
      _viewmodel.setName(_newName);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.teal,
        content: Text('Berhasil merubah nama'),
        duration: Duration(seconds: 3),
      ));
      AppRoute.back();
    }
  }

  @override
  void dispose() {
    _controllerName.dispose();
    super.dispose();
  }
}
