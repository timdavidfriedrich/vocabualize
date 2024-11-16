extension ObjectExtensions<ObjectType extends Object> on ObjectType {
  ReturnType let<ReturnType>(ReturnType Function(ObjectType) x) => x(this);
}
