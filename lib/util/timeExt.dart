extension TimeExt on int {
  int getSeconds() {
    return this % 60;
  }

  int getMinutes() {
     return (this % 3600) ~/ 60;
  }

  String twoDigits() {
    return this.toString().padLeft(2, '0');
  }
}