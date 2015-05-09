import 'dart:html';

void main() {
  var path = '/diceware.wordlist.asc';
  HttpRequest.getString(path)
    .then((String contents) {
      var lines = contents.split('\n');
      var wordList =
          lines.getRange(2, lines.length - 12).map((String line) {
            return line.substring(6);
          });
      print(wordList);
    })
    .catchError((Error error) {
      print(error.toString());
    });
}
