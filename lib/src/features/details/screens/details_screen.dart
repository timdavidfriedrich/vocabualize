import 'package:flutter/scheduler.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vocabualize/constants/image_constants.dart';
import 'package:vocabualize/service_locator.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary_image.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_draft_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/get_stock_images_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/image/upload_image_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/translator/translate_to_english_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/delete_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/usecases/vocabulary/update_vocabulary_use_case.dart';
import 'package:vocabualize/src/common/domain/utils/formatter.dart';
import 'package:vocabualize/src/common/domain/entities/vocabulary.dart';
import 'package:vocabualize/src/common/presentation/extensions/vocabulary_image_extentions.dart';
import 'package:vocabualize/src/features/details/screens/details_disabled_images_screen.dart';
import 'package:vocabualize/src/features/details/widgets/source_to_target.dart';
import 'package:vocabualize/src/features/details/widgets/tag_wrap.dart';
import 'package:vocabualize/src/features/home/screens/home_screen.dart';
import 'package:vocabualize/src/features/details/utils/details_arguments.dart';
import 'package:vocabualize/src/features/settings/providers/settings_provider.dart';
import 'package:vocabualize/src/features/settings/screens/settings_screen.dart';

class DetailsScreen extends StatefulWidget {
  static const String routeName = "${HomeScreen.routeName}/AddDetails";

  const DetailsScreen({super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final getDraftImage = sl.get<GetDraftImageUseCase>();
  final updateVocabulary = sl.get<UpdateVocabularyUseCase>();
  final deleteVocabulary = sl.get<DeleteVocabularyUseCase>();
  final getStockImages = sl.get<GetStockImagesUseCase>();
  final uploadImage = sl.get<UploadImageUseCase>();
  final translateToEnglish = sl.get<TranslateToEnglishUseCase>();

  Vocabulary vocabulary = Vocabulary();

  List<StockImage> _stockImages = [];
  VocabularyImage? _selected;

  final int itemCount = 7;
  final int maxItems = 70;

  int firstIndex = 0;
  int lastIndex = 6;

  void _initArguments() {
    DetailsScreenArguments arguments = ModalRoute.of(context)!.settings.arguments as DetailsScreenArguments;
    setState(() => vocabulary = arguments.vocabulary);
  }

  void _initImage() {
    final image = vocabulary.image;
    if (image is FallbackImage) {
      return;
    }
    _selected = vocabulary.image;
  }

  void _getDraftImage() async {
    final image = await getDraftImage();
    if (image != null) {
      setState(() => _selected = image);
    }
  }

  void _loadStockImages() async {
    final searchTerm = Formatter.filterOutArticles(
      await translateToEnglish(vocabulary.source),
    );
    List<StockImage> stockImages = await getStockImages(searchTerm);
    if (mounted) setState(() => _stockImages = stockImages);
  }

  void _browseNext() {
    if (lastIndex + itemCount < maxItems) {
      setState(() {
        firstIndex += itemCount;
        lastIndex += itemCount;
      });
    } else {
      setState(() {
        firstIndex = 0;
        lastIndex = 6;
      });
    }
  }

  void _openPhotographerLink() async {
    final imageUrl = _selected?.url;
    if (imageUrl == null) return;
    await launchUrl(Uri.parse(imageUrl), mode: LaunchMode.externalApplication);
  }

  void _selectImage(VocabularyImage? image) {
    if (image == null) return;
    setState(() => _selected = image);
  }

  void _save() async {
    final image = _selected;
    if (image != null) {
      uploadImage(image);
    }
    final updatedVocabulary = vocabulary.copyWith(image: _selected);
    updateVocabulary(updatedVocabulary);
    Navigator.pop(Global.context);
  }

  void _navigateToSettings() async {
    Navigator.pushNamed(context, SettingsScreen.routeName);
  }

  void _delete() {
    deleteVocabulary(vocabulary);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      _initArguments();
      _initImage();
      _loadStockImages();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<SettingsProvider>(context).areImagesDisabled
        ? const DetailsDisabledImagesScreen()
        : SafeArea(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(32), topRight: Radius.circular(32)),
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                body: vocabulary.source.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(48, 0, 48, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  const SizedBox(height: 24),
                                  SourceToTarget(vocabulary: vocabulary),
                                  const SizedBox(height: 12),
                                  AspectRatio(
                                    aspectRatio: 4 / 3,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                        color: Theme.of(context).colorScheme.surface,
                                        image: _selected == null
                                            ? null
                                            : DecorationImage(
                                                fit: BoxFit.cover,
                                                image: _selected!.getImageProvider(),
                                              ),
                                      ),
                                      child: _selected == null
                                          ? Center(
                                              child: Text(
                                                AppLocalizations.of(context)?.record_addDetails_noImage ?? "",
                                                textAlign: TextAlign.center,
                                              ),
                                            )
                                          : _selected is StockImage
                                              ? Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(14),
                                                      backgroundBlendMode: BlendMode.darken,
                                                      gradient: LinearGradient(
                                                          begin: Alignment.bottomCenter,
                                                          end: Alignment.topCenter / 12,
                                                          colors: [Colors.black.withOpacity(0.5), Colors.transparent])),
                                                  child: Align(
                                                    alignment: Alignment.bottomCenter,
                                                    child: TextButton(
                                                      onPressed: () => _openPhotographerLink(),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          const SizedBox(width: 8),
                                                          Flexible(
                                                            child: Text(
                                                              // TODO: Replace with arb
                                                              "Photo by ${(_selected as StockImage).photographer}",
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .bodySmall!
                                                                  .copyWith(color: Theme.of(context).colorScheme.onPrimary),
                                                            ),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Icon(
                                                            Icons.launch_rounded,
                                                            size: 18,
                                                            color: Theme.of(context).colorScheme.onPrimary,
                                                          ),
                                                          const SizedBox(width: 8),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox(),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(AppLocalizations.of(context)?.record_addDetails_providedBy ?? "",
                                          style: Theme.of(context).textTheme.bodySmall),
                                      IconButton(onPressed: () => _browseNext(), icon: const Icon(Icons.find_replace_rounded)),
                                    ],
                                  ),
                                  GridView.builder(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 4,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                    ),
                                    itemCount: itemCount + 1,
                                    itemBuilder: (context, index) => index == 0
                                        ? MaterialButton(
                                            padding: EdgeInsets.zero,
                                            elevation: 0,
                                            onPressed: _getDraftImage,
                                            color: Theme.of(context).colorScheme.surface,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                            child: _selected is DraftImage
                                                ? Ink(
                                                    padding: EdgeInsets.zero,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      border: Border.all(
                                                        width: 2,
                                                        color: Theme.of(context).colorScheme.primary,
                                                      ),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: _selected!.getImageProvider(),
                                                      ),
                                                    ),
                                                    child: Center(
                                                      child: Icon(
                                                        Icons.done_rounded,
                                                        color: Theme.of(context).colorScheme.onSurface,
                                                      ),
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.camera_alt_rounded,
                                                    color: Theme.of(context).colorScheme.primary,
                                                    size: 28,
                                                  ),
                                          )
                                        : InkWell(
                                            onTap: () =>
                                                _stockImages.isEmpty ? null : _selectImage(_stockImages.elementAt(index + firstIndex - 1)),
                                            borderRadius: BorderRadius.circular(16),
                                            child: firstIndex + index >= _stockImages.length + 1
                                                ? const Padding(
                                                    padding: EdgeInsets.all(24), child: CircularProgressIndicator(strokeWidth: 2))
                                                : Ink(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(16),
                                                      border: _stockImages.elementAt(index + firstIndex - 1) != _selected
                                                          ? null
                                                          : Border.all(width: 2, color: Theme.of(context).colorScheme.primary),
                                                      image: DecorationImage(
                                                        fit: BoxFit.cover,
                                                        image: NetworkImage(
                                                          _stockImages.elementAt(index + firstIndex - 1).sizeVariants?["small"] ??
                                                              ImageConstants.fallbackImageUrl,
                                                        ),
                                                      ),
                                                    ),
                                                    child: _stockImages.elementAt(index + firstIndex - 1) != _selected
                                                        ? null
                                                        : Center(
                                                            child: Icon(Icons.done_rounded, color: Theme.of(context).colorScheme.onSurface),
                                                          ),
                                                  ),
                                          ),
                                  ),
                                  const SizedBox(height: 16),
                                  TagWrap(vocabulary: vocabulary),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(12),
                                    backgroundColor: Theme.of(context).colorScheme.error.withOpacity(0.2),
                                    foregroundColor: Theme.of(context).colorScheme.error,
                                  ),
                                  onPressed: () => _delete(),
                                  child: const Icon(Icons.delete_rounded),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () => _save(),
                                    child: Text(
                                      _selected == null
                                          ? AppLocalizations.of(context)?.record_addDetails_saveWithoutButton ?? ""
                                          : AppLocalizations.of(context)?.record_addDetails_saveButton ?? "",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            TextButton(
                              onPressed: () => _navigateToSettings(),
                              child: Text(
                                AppLocalizations.of(context)?.record_addDetails_neverAskForImageButton ?? "",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodySmall!.copyWith(color: Theme.of(context).hintColor),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
            ),
          );
  }
}
