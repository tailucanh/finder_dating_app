extension ListIntExtension on List<int> {
  bool containsNumber(int number) {
    return contains(number);
  }
}

extension ListIntNullExtension on List<int>? {
  bool containsNumber(int number) {
    return this?.contains(number) ?? false;
  }

  bool isSameAs(List<int>? otherList) {
    if (this == otherList) {
      return true;
    }

    if (this == null || otherList == null) {
      return false;
    }

    if (this?.length != otherList.length) {
      return false;
    }

    for (var i = 0; i < this!.length; i++) {
      if (this?[i] != otherList[i]) {
        return false;
      }
    }

    return true;
  }

  bool areAllElementsEqual(List<int>? otherList) {
    if (this == null && otherList == null) {
      return true;
    }

    if (this == null || otherList == null || this?.length != otherList.length) {
      return false;
    }

    for (var i = 0; i < this!.length; i++) {
      if (this?[i] != otherList[i]) {
        return false;
      }
    }

    return true;
  }
}
