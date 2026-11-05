import 'package:dart_mappable/dart_mappable.dart';

part 'image_crop.mapper.dart';

@MappableClass()
class const ImageCrop({
  required final double left,
  required final double top,
  required final double width,
  required final double height,
}) with ImageCropMappable;
