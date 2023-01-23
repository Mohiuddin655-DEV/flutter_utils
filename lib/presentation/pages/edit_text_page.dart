import 'package:flutter/material.dart';
import 'package:flutter_utils/core/sources/icons.dart';
import 'package:flutter_utils/core/utils/regex/regs.dart';

class EditTextPage extends StatefulWidget {
  const EditTextPage({Key? key}) : super(key: key);

  @override
  State<EditTextPage> createState() => _EditTextPageState();
}

class _EditTextPageState extends State<EditTextPage> {
  final formKey = GlobalKey<FormState>(); //key for form
  String name = "";

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: const Color(0xFFffffff),
        body: Container(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Form(
            key: formKey, //key for form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(AppIcons.home),
                SizedBox(height: height * 0.04),
                const Text(
                  "Here to Get",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                const Text(
                  "Welcomed !",
                  style: TextStyle(fontSize: 30, color: Color(0xFF363f93)),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter your name",
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty ||
                        !Regs.letter.hasMatch(value ?? '')) {
                      return "Enter correct name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                      labelText: "Enter your number",
                      isCollapsed: false,
                      isDense: false,
                      contentPadding: EdgeInsets.zero),
                  validator: (value) {
                    if ((value ?? '').isEmpty ||
                        !Regs.letter.hasMatch(value ?? '')) {
                      return "Enter correct phone number";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Enter your email",
                  ),
                  validator: (value) {
                    if ((value ?? '').isEmpty ||
                        !Regs.phone.hasMatch(value ?? '')) {
                      return "Enter correct email";
                    } else {
                      return null;
                    }
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
