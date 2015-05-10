import 'dart:async';
import 'dart:html';

Future<List<String>> futureWordListFromFutureDoc(Future<String> futureDoc) {
  return futureDoc
    .then((String doc) {
      var lines = doc.split('\n');
      var wordList =
          lines
            .getRange(2, lines.length - 12)
            .map((String line) => line.substring(6));
      return wordList;
    });
}

void main() {
  var futureDoc = HttpRequest.getString('/diceware.wordlist.asc');
  futureWordListFromFutureDoc(futureDoc)
    .then((List<String> wordList) {
      print(wordList);
    });
}
