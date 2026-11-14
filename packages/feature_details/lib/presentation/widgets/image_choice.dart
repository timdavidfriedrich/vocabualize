import 'package:feature_details/presentation/details_state.dart';
import 'package:shared/domain/entities/vocabulary_image.dart';

typedef ImageChoice = ({
  DetailsImage selected,
  DetailsImage? ownPhoto,
  List<StockImage> stockImages,
  int stockPage,
  bool isWaitingForConnection,
  bool isSearchingPhotos,
  bool isBusy,
  bool isLoadingImage,
});
