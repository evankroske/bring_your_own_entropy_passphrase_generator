/*
Copyright 2014 Google Inc. All Rights Reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

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
  var futureDoc = HttpRequest.getString('diceware.wordlist.asc');
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
