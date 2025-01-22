extension Wait on int {
  Future<void> ms() async {
    await Future.delayed(Duration(milliseconds: this));
  }
}
