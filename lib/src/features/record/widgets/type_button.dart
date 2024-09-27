import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vocabualize/constants/common_imports.dart';
import 'package:provider/provider.dart' as provider;
import 'package:vocabualize/src/common/presentation/widgets/connection_checker.dart';
import 'package:vocabualize/src/features/record/providers/active_provider.dart';
import 'package:vocabualize/src/features/record/services/record_service.dart';

// TODO ARCHITECTURE: Remvoe Provider package from TypeButton

class TypeButton extends ConsumerStatefulWidget {
  const TypeButton({super.key});

  @override
  ConsumerState<TypeButton> createState() => _TypeButtonState();
}

class _TypeButtonState extends ConsumerState<TypeButton> {
  TextEditingController controller = TextEditingController();
  FocusNode focusNode = FocusNode();
  String currentSource = "";

  _focus() {
    provider.Provider.of<ActiveProvider>(context, listen: false).typeIsActive = true;
  }

  _cancel() {
    FocusManager.instance.primaryFocus?.unfocus();
    controller.clear();
    currentSource = "";
    provider.Provider.of<ActiveProvider>(context, listen: false).typeIsActive = false;
  }

  _submit() async {
    if (!await HelperWidgets.isOnline()) return _cancel();
    if (!mounted) return;
    RecordService().validateAndSave(unwantedRef: ref, source: currentSource);
    currentSource = "";
    controller.clear();
    focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextFormField(
          style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          toolbarOptions: const ToolbarOptions(copy: false, cut: false, paste: false, selectAll: false),
          autofocus: false,
          focusNode: focusNode,
          controller: controller,
          textInputAction: TextInputAction.done,
          maxLength: 20,
          maxLines: 1,
          onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
          decoration: InputDecoration(
            enabled: !provider.Provider.of<ActiveProvider>(context).micIsActive,
            hintText: AppLocalizations.of(context)?.record_type,
            counterText: "",
            contentPadding: const EdgeInsets.fromLTRB(18, 18, 18, 18),
            hintStyle: TextStyle(color: Theme.of(context).hintColor),
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).hintColor, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.onPrimary, width: 4),
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          onTap: provider.Provider.of<ActiveProvider>(context).micIsActive ? () {} : () => _focus(),
          onChanged: (text) {
            setState(() => currentSource = text);
            _focus(); // long pressing on field ignores onTap, that's why this workaround
          },
          onFieldSubmitted: (text) async => _submit,
        ),
        currentSource.isEmpty && !provider.Provider.of<ActiveProvider>(context).typeIsActive ? Container() : const SizedBox(height: 16),
        currentSource.isEmpty && !provider.Provider.of<ActiveProvider>(context).typeIsActive
            ? Container()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onPrimary,
                      side: BorderSide(width: 3, color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    onPressed: () => _cancel(),
                    child: Text(AppLocalizations.of(context)?.record_closeButton ?? ""),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(context).colorScheme.onPrimary,
                      ),
                      onPressed: () => _submit(),
                      child: Text(AppLocalizations.of(context)?.record_addButton ?? ""),
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
