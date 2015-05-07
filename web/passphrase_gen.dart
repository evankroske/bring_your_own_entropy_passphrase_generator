import 'dart:html';

void main() {
  var path = '/diceware.wordlist.asc';
  print(path);
  HttpRequest.getString(path)
    .then((String contents) {
      print(contents);
    })
    .catchError((Error error) {
      print(error.toString());
    });
}
