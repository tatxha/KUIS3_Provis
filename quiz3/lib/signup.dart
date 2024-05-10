import 'package:flutter/material.dart';
import 'package:quiz3/auth/auth.dart';
import 'package:quiz3/home.dart';
import 'package:quiz3/login.dart';
import 'package:quiz3/main.dart';
import 'package:quiz3/model/user.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _selectedIndex = 0;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  AuthService _auth = AuthService();
  User user_global = User(username: "", password: ""); 

  Future<bool> _register() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    User user = User(username: username, password: password);
    user_global = user;

    bool isSucceed = await _auth.register(context, user);

    return isSucceed;
  }

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
                controller: _usernameController,
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
                controller: _passwordController,
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
                onPressed: () async {
                  bool isSucceed = await _register();
                  if(isSucceed){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration Success!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    // _auth.login(context, user_global);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => HomePage(),
                    //   ),
                    // );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Registration Failed!'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                  }
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
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginPage(),
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(fontSize: 18, color: Colors.deepPurple, fontWeight: FontWeight.w700),
                    ),
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
