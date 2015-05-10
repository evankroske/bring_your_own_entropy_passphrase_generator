import 'dart:async';
import 'dart:html';

Future<List<String>> futureWordListFromFutureDoc(Future<String> futureDoc) {
  return futureDoc
    .then((String doc) {
      var lines = doc.split('\n');
      return new List.from(
          lines
            .getRange(2, lines.length - 12)
            .map((String line) => line.substring(6)));
    });
}

void main() {
  var futureDoc = HttpRequest.getString('/diceware.wordlist.asc');
  futureWordListFromFutureDoc(futureDoc)
    .then((List<String> wordList) {
      var button = querySelector('#btn_add_to_passphrase');
      var fieldRandomNumber = querySelector('#field_random_number');
      var passphrase = [];
      var fieldPassphrase = querySelector('#field_passphrase');
      button.attributes.remove('disabled');
      button.onClick.forEach((MouseEvent e) {
        var randonNumber = int.parse(fieldRandomNumber.value);
        passphrase.add(wordList[randonNumber % wordList.length]);
        fieldPassphrase.value = passphrase.join(' ');
        fieldRandomNumber.value = '';
        fieldRandomNumber.focus();
      });
    });
}
