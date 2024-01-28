import 'package:flutter/material.dart';

class DeleteButton extends StatelessWidget {
  final VoidCallback onDelete;
  final Color buttonColor;

  DeleteButton({required this.onDelete, this.buttonColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showDeleteConfirmationDialog(context);
      },
      child: Container(
        width: 30.0,
        height: 30.0,
        margin: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black87, // Background color for the outer circle
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: buttonColor, // Background color for the delete button
          ),
          child: Icon(
            Icons.delete,
            color: Colors.red,
          ),
        ),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Item?'),
          content: Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                onDelete(); // Call the onDelete callback
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
