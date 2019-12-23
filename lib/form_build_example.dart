import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class FormBuildExample extends StatefulWidget {
  @override
  _FormBuildExampleState createState() => _FormBuildExampleState();
}

class _FormBuildExampleState extends State<FormBuildExample> {
  final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Uploader Example'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FormBuilder(
                key: _fbKey,
                initialValue: {
                  'date': DateTime.now(),
                  'accept_terms': false,
                },
                autovalidate: true,
                child: Column(
                  children: <Widget>[
                    FormBuilderDropdown(
                      attribute: "gender",
                      decoration: InputDecoration(labelText: "Gender"),
                      // initialValue: 'Male',
                      hint: Text('Select Gender'),
                      validators: [FormBuilderValidators.required()],
                      items: ['Male', 'Female', 'Other']
                          .map((gender) => DropdownMenuItem(
                          value: gender,
                          child: Text("$gender")
                      )).toList(),
                    ),
                    FormBuilderTextField(
                      attribute: "age",
                      decoration: InputDecoration(labelText: "Age"),
                      validators: [
                        FormBuilderValidators.numeric(),
                        FormBuilderValidators.max(120),
                      ],
                    ),
                    FormBuilderRate(
                      decoration: InputDecoration(labelText: "Rate this form"),
                      attribute: "rate",
                      iconSize: 32.0,
                      initialValue: 1,
                      max: 5,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  child: Text("Submit"),
                  onPressed: () {
                    if (_fbKey.currentState.saveAndValidate()) {
                      print(_fbKey.currentState.value.runtimeType);
                    }
                  },
                ),
                MaterialButton(
                  child: Text("Reset"),
                  onPressed: () {
                    _fbKey.currentState.reset();
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


