import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  print("Welcome to the Cat Facts App!");
  List<String> favoriteFacts = [];

  while (true) {
    print("\nChoose a language for the cat fact:");
    print("1. English");
    print("2. Spanish");
    print("3. French");
    print("4. Exit");

    String? choice = stdin.readLineSync();
    String languageCode = "";

    switch (choice) {
      case "1":
        languageCode = "en";
        break;
      case "2":
        languageCode = "es";
        break;
      case "3":
        languageCode = "fr";
        break;
      case "4":
        print("Exiting the application. Goodbye!");
        return;
      default:
        print("Invalid choice. Please try again.");
        continue;
    }

    // Fetch a random cat fact in the selected language
    String url = "https://catfact.ninja/fact?language=$languageCode";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        String fact = data['fact'];
        print("\nHere's your cat fact: $fact");

        // Options after displaying the fact
        print("\nWhat would you like to do?");
        print("1. Add this fact to favorites and show the next fact");
        print("2. Show the next random fact");
        print("3. View your list of favorite facts");
        print("4. Clear your list of favorite facts");
        print("5. Exit");

        String? action = stdin.readLineSync();
        switch (action) {
          case "1":
            favoriteFacts.add(fact);
            print("Fact added to favorites!");
            break;
          case "2":
            print("Showing the next fact...");
            break;
          case "3":
            if (favoriteFacts.isEmpty) {
              print("Your list of favorite facts is empty.");
            } else {
              print("\nYour favorite facts:");
              for (int i = 0; i < favoriteFacts.length; i++) {
                print("${i + 1}. ${favoriteFacts[i]}");
              }
            }
            break;
          case "4":
            favoriteFacts.clear();
            print("Your list of favorite facts has been cleared.");
            break;
          case "5":
            print("Exiting the application. Goodbye!");
            return;
          default:
            print("Invalid choice. Please try again.");
            continue;
        }
      } else {
        print("Failed to fetch a cat fact. Please try again later.");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }
}
