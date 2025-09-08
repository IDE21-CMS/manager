import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> items = ['Item 1', 'Item 2', 'Item 3'];

  void _addItem() async {
    final newItem = await showDialog<String>(
      context: context,
      builder: (context) {
        TextEditingController controller = TextEditingController();
        return AlertDialog(
          title: Text('Add New Item'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(hintText: 'Item name'),
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Add'),
              onPressed: () => Navigator.pop(context, controller.text),
            ),
          ],
        );
      },
    );
    if (newItem != null && newItem.isNotEmpty) {
      setState(() {
        items.add(newItem);
      });
    }
  }

  void _showLoginDialog(String item) {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController usernameController = TextEditingController();
        TextEditingController passwordController = TextEditingController();
        return AlertDialog(
          title: Text('Login for $item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: usernameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.pop(context),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                // Handle login logic here
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _removeItem(int index) {
    setState(() {
      items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('List of Items')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: GestureDetector(
              onTap: () => _showLoginDialog(items[index]),
              child: Text(items[index]),
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle, color: Colors.red),
              onPressed: () => _removeItem(index),
              tooltip: 'Remove',
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 120,
        height: 56,
        child: ElevatedButton.icon(
          icon: Icon(Icons.add),
          label: Text('Add'),
          onPressed: _addItem,
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 20),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
