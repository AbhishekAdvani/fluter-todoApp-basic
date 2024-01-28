import 'dart:math'; // Import the 'dart:math' library for random color generation

import 'package:flutter/material.dart';
import 'package:flutter_crud_project/screens/add_screen.dart';
import 'package:flutter_crud_project/screens/edit_screen.dart';
import 'package:flutter_crud_project/screens/item_manager.dart';
import 'package:flutter_crud_project/screens/delete_button.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ItemManager itemManager = ItemManager();
  Random random = Random(); // Create an instance of the Random class

  @override
  void initState() {
    super.initState();
    _loadItems();
  }

  _loadItems() async {
    await itemManager.loadItems();
    setState(() {});
  }

  Color getRandomColor() {
    // Generate a random color using RGB values
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter CRUD'),
      ),
      body: itemManager.items.isEmpty
          ? _buildWelcomeCard()
          : _buildNotesGridView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Center(
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Welcome! Start taking notes.',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Widget _buildNotesGridView() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: itemManager.items.length,
      itemBuilder: (context, index) {
        Color cardColor = getRandomColor(); // Get a random color for each card
        return Card(
          elevation: 3.0,
          clipBehavior: Clip.none, // Allow content to overflow
          color: cardColor, // Set the background color of the card
          child: Stack(
            children: [
              ListTile(
                title: Text(
                  itemManager.items[index],
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white, // Set text color to white for contrast
                  ),
                ),
                onTap: () {
                  _navigateToEditScreen(context, index);
                },
              ),
              Positioned(
                bottom: -12.0, // Adjust the value to your preference
                right: -12.0, // Adjust the value to your preference
                child: DeleteButton(
                  onDelete: () {
                    _deleteItem(index);
                  },
                  buttonColor: Colors.transparent, // Set the color of the delete button
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _navigateToAddScreen(BuildContext context) async {
    final newItem = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddScreen()),
    );

    if (newItem != null) {
      itemManager.addItem(newItem);
      _loadItems();
    }
  }

  void _navigateToEditScreen(BuildContext context, int index) async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(item: itemManager.items[index]),
      ),
    );

    if (updatedItem != null) {
      itemManager.updateItem(index, updatedItem);
      _loadItems();
    }
  }

  void _deleteItem(int index) {
    itemManager.deleteItem(index);
    _loadItems();
  }
}
