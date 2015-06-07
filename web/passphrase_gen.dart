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
      ButtonElement button = querySelector('#btn_add_to_passphrase');
      NumberInputElement fieldRandomNumber =
          querySelector('#field_random_number');
      List<String> passphrase = [];
      TextInputElement fieldPassphrase = querySelector('#field_passphrase');
      int numSidesOfDie = 6;
      button.attributes.remove('disabled');
      button.onClick.forEach((MouseEvent e) {
        var value =
            numSidesOfDie == 6
                ? new String.fromCharCodes(
                    fieldRandomNumber.value.runes.map((int c) => c - 1))
                : fieldRandomNumber.value;
        int randonNumber = int.parse(value, radix: numSidesOfDie);
        passphrase.add(wordList[randonNumber % wordList.length]);
        fieldPassphrase.value = passphrase.join(' ');
        fieldRandomNumber.value = '';
        fieldRandomNumber.focus();
      });

      var liNumSides = querySelector("#li_num_sides");
      liNumSides.onChange.forEach((Event e) {
        RadioButtonInputElement target = e.target as RadioButtonInputElement;
        numSidesOfDie = int.parse(target.value);
      });
    });
}
