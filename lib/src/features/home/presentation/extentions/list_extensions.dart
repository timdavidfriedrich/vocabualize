extension ListExtensions<T> on List<T> {
  (List<T>, List<T>) splitListInHalf({required int threshold}) {
    if (length >= threshold) {
      int breakpoint = (length / 2).ceil();
      return (sublist(0, breakpoint), sublist(breakpoint));
    } else {
      return (this, []);
    }
  }
}
