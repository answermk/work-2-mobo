import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Tab and Drawer Navigation',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const SignInScreen(),
    const SignUpScreen(),
    const CalculatorScreen(),
  ];
  final List<String> _titles = [
    'Sign In',
    'Sign Up',
    'Calculator',
  ];

  void _onDrawerItemTapped(int index) {
    Navigator.pop(context); // Close the drawer
    navigateToScreen(index);
  }

  void navigateToScreen(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToCalculatorScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const CalculatorScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.login),
              title: const Text('Sign In'),
              onTap: () => _onDrawerItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.app_registration),
              title: const Text('Sign Up'),
              onTap: () => _onDrawerItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.calculate),
              title: const Text('Calculator'),
              onTap: () => _onDrawerItemTapped(2),
            ),
          ],
        ),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          navigateToScreen(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Sign In',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'Sign Up',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Calculator',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _signIn() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    // You can add authentication logic here
    if (username.isNotEmpty && password.isNotEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Sign In"),
            content: const Text("Sign In Done"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to Calculator screen without changing the background color
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _signIn,
            child: const Text('Sign In'),
          ),
        ],
      ),
    );
  }
}

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  String _gender = 'Male';
  final _dobController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _signUp() {
    String name = _nameController.text;
    String gender = _gender;
    String dob = _dobController.text;
    String phone = _phoneController.text;
    String address = _addressController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    // You can add signup logic here
    if (name.isNotEmpty &&
        gender.isNotEmpty &&
        dob.isNotEmpty &&
        phone.isNotEmpty &&
        address.isNotEmpty &&
        password.isNotEmpty &&
        password == confirmPassword) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Sign Up"),
            content: const Text("Sign Up Successful"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const SignInScreen()),
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            DropdownButtonFormField<String>(
              value: _gender,
              items: ['Male', 'Female', 'Other']
                  .map((label) => DropdownMenuItem(
                child: Text(label),
                value: label,
              ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _gender = value!;
                });
              },
              decoration: const InputDecoration(labelText: 'Gender'),
            ),
            TextField(
              controller: _dobController,
              decoration: const InputDecoration(labelText: 'Date of Birth'),
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    _dobController.text = pickedDate.toString().split(' ')[0];
                  });
                }
              },
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              keyboardType: TextInputType.phone,
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Address'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: const InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            const SizedBox(height: 21),
            ElevatedButton(
              onPressed: _signUp,
              child: const Text('Sign Up'),
            ),
          ],
        ),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  String _result = "0";
  String _operand = "";
  double num1 = 0;
  double num2 = 0;

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      _result = "0";
      _operand = "";
      num1 = 0;
      num2 = 0;
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      num1 = double.parse(_output);
      _operand = buttonText;
      _result = "0";
    } else if (buttonText == "log" || buttonText == "sin" || buttonText == "cos" || buttonText == "^" || buttonText=="exp") {
      num1 = double.parse(_output);
      _operand = buttonText;
      _result = "0";
    } else if (buttonText == ".") {
      if (!_result.contains(".")) {
        _result += buttonText;
      }
    } else if (buttonText == "=") {
      num2 = double.parse(_output);

      switch (_operand) {
        case "+":
          _result = (num1 + num2).toString();
          break;
        case "-":
          _result = (num1 - num2).toString();
          break;
        case "*":
          _result = (num1 * num2).toString();
          break;
        case "/":
          _result = (num1 / num2).toString();
          break;
        case "^":
          _result = (pow(num1, num2)).toString();
          break;
        case "log":
          _result = (log(num1) / log(num2)).toString();
          break;
        case "sin":
          _result = sin(num1).toString();
          break;
        case "cos":
          _result = cos(num1).toString();
          break;
        case "exp":
          _result = exp(num1).toString();
          break;
        default:
          break;
      }

      num1 = 0;
      num2 = 0;
      _operand = "";
    } else {
      _result += buttonText;
    }

    setState(() {
      _output = double.parse(_result).toString();
    });
  }

  Widget _buildButton(String buttonText, Color buttonColor, Color textColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: textColor, backgroundColor: buttonColor, padding: const EdgeInsets.all(20.0),
            textStyle: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _buttonPressed(buttonText),
          child: Text(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
          child: Text(
            _output,
            style: const TextStyle(
              fontSize: 48.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Expanded(child: Divider()),
        Column(children: [
          Row(children: [
            _buildButton("7", Colors.black12, Colors.black),
            _buildButton("8", Colors.black12, Colors.black),
            _buildButton("9", Colors.black12, Colors.black),
            _buildButton("/", Colors.blue, Colors.white),
          ]),
          Row(children: [
            _buildButton("4", Colors.black12, Colors.black),
            _buildButton("5", Colors.black12, Colors.black),
            _buildButton("6", Colors.black12, Colors.black),
            _buildButton("*", Colors.blue, Colors.white),
          ]),
          Row(children: [
            _buildButton("1", Colors.black12, Colors.black),
            _buildButton("2", Colors.black12, Colors.black),
            _buildButton("3", Colors.black12, Colors.black),
            _buildButton("-", Colors.blue, Colors.white),
          ]),
          Row(children: [
            _buildButton(".", Colors.black12, Colors.black),
            _buildButton("0", Colors.black12, Colors.black),
            _buildButton("00", Colors.black12, Colors.black),
            _buildButton("+", Colors.blue, Colors.white),
          ]),
          Row(children: [
            _buildButton("log", Colors.orange, Colors.black),
            _buildButton("sin", Colors.orange, Colors.black),
            _buildButton("cos", Colors.orange, Colors.black),
            _buildButton("^", Colors.orange, Colors.black),
          ]),
          Row(children: [
            _buildButton("exp", Colors.orange, Colors.black),
            _buildButton("C", Colors.red, Colors.white),
            _buildButton("=", Colors.green, Colors.white),
          ]),
        ])
      ],
    );
  }
}
