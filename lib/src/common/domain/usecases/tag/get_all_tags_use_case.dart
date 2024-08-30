import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/tag.dart';
import 'package:vocabualize/src/common/domain/repositories/tag_repository.dart';

class GetAllTagsUseCase {
  final _tagRepository = sl.get<TagRepository>();

  Future<List<Tag>> call() {
    return _tagRepository.getAllTags();
  }
}
