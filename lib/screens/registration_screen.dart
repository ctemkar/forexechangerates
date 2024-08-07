import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
@override
_RegistrationFormState createState() => _RegistrationFormState();
} 

class _RegistrationFormState extends State<RegistrationForm> {
final _formKey = GlobalKey<FormState>();
final _nameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController(); 

@override
Widget build(BuildContext context) {
return Form(
key: _formKey,
child: Column(
children: [
TextFormField(
controller: _nameController,
decoration: InputDecoration(labelText: 'Name'),
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter your name';
}
return null;
},
),
TextFormField(
controller: _emailController,
decoration: InputDecoration(labelText: 'Email'),
validator: (value) {
if (value == null || !RegExp(r'\S+@\S+.\S+').hasMatch(value)) {
return 'Please enter a valid email address';
}
return null;
},
),
TextFormField(
controller: _passwordController,
decoration: InputDecoration(labelText: 'Password'),
obscureText: true,
validator: (value) {
if (value == null || value.isEmpty) {
return 'Please enter a password';
}
return null;
},
),
ElevatedButton(
onPressed: () {
if (_formKey.currentState!.validate()) {
// Perform registration logic here
// You can access user data using _nameController.text, etc.
print('Name: ${_nameController.text}');
print('Email: ${_emailController.text}');
print('Password: ${_passwordController.text}');
}
},
child: Text('Register'),
),
],
),
);
}
}
