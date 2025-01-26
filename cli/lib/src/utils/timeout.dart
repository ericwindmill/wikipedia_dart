extension Wait on int {
  Future<void> ms() async {
    await Future<void>.delayed(Duration(milliseconds: this));
  }
}
