  import 'package:shared_preferences/shared_preferences.dart';

  class ItemManager {
    static const String _key = 'items';

    List<String> _items = [];

    List<String> get items => _items;

    Future<void> loadItems() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      _items = prefs.getStringList(_key) ?? [];
    }

    Future<void> saveItems() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setStringList(_key, _items);
    }

    void addItem(String newItem) {
      _items.add(newItem);
      saveItems();
    }

    void updateItem(int index, String updatedItem) {
      _items[index] = updatedItem;
      saveItems();
    }

    void deleteItem(int index) {
      _items.removeAt(index);
      saveItems(); // Save changes to local storage
    }
  }
