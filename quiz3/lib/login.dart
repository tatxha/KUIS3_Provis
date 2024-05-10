import 'package:flutter/material.dart';
import 'package:quiz3/main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                'Welcome Back',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 15.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'to ',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    'Barayafood',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
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
                child: Text('Login', style: TextStyle(fontSize: 26),),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Dont have an account? ',
                    style: TextStyle(fontSize: 18,),
                  ),
                  Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 18, color: Colors.deepPurple),
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
