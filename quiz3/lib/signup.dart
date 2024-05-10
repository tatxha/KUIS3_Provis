import 'package:flutter/material.dart';
import 'package:quiz3/main.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    // var value = context.watch<ProductProvider>();

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Chart'),
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   automaticallyImplyLeading: false, // Tambahkan baris ini
      // ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.0,),
              Text(
                'Create your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 25.0,),
              TextField(
                // controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Username',
                  labelText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                // controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  labelText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Tambahkan logika autentikasi di sini
                  // String username = _usernameController.text;
                  // String password = _passwordController.text;
                  // Misalnya, Anda bisa memeriksa apakah username dan password sesuai
                },
                child: Text('Sign up', style: TextStyle(fontSize: 26),),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account? ',
                    style: TextStyle(fontSize: 18,),
                  ),
                  Text(
                    'Login',
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.w700),
                  ),
                ],
              )
            ],
          ),
        ),
      ),            
    );
  }

}
