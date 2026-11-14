sealed class CollectionEdit {
  const CollectionEdit();
}

class const CollectionSaved({
  required final String name,
  required final String? emoji,
}) extends CollectionEdit;

class const CollectionDeleteChosen() extends CollectionEdit;
