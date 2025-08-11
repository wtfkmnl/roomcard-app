extension ExIndexedMap<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>({required T Function(int index, E element) mappedIterable}) {
    var i = 0;
    return map((e) => mappedIterable(i++, e));
  }
}
