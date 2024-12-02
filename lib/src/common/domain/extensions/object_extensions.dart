extension ObjectExtensions<ObjectType extends Object> on ObjectType {
  ReturnType let<ReturnType>(ReturnType Function(ObjectType) x) {
    return x(this);
  }

  ObjectType apply(void Function(ObjectType) x) {
    x(this);
    return this;
  }

  ObjectType run(void Function() x) {
    x();
    return this;
  }

  ObjectType also(void Function(ObjectType) x) {
    x(this);
    return this;
  }

  ObjectType? takeIf(bool Function(ObjectType) x) {
    return x(this) ? this : null;
  }

  ObjectType? takeUnless(bool Function(ObjectType) x) {
    return x(this) ? null : this;
  }

  bool isTypeOfAny(List<Type> types) {
    return types.any((type) => runtimeType == type);
  }
}
