import 'package:dart_mappable/dart_mappable.dart';

part 'image_label.mapper.dart';

@MappableClass()
class const ImageLabel({
  required final String text,
  required final String context,
}) with ImageLabelMappable;
