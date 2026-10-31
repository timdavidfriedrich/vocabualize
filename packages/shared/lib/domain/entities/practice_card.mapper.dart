// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'practice_card.dart';

class PracticeCardMapper extends ClassMapperBase<PracticeCard> {
  PracticeCardMapper._();

  static PracticeCardMapper? _instance;
  static PracticeCardMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PracticeCardMapper._());
      PracticeItemMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PracticeCard';

  static PracticeItem _$item(PracticeCard v) => v.item;
  static const Field<PracticeCard, PracticeItem> _f$item = Field(
    'item',
    _$item,
  );
  static Language _$prompt(PracticeCard v) => v.prompt;
  static const Field<PracticeCard, Language> _f$prompt = Field(
    'prompt',
    _$prompt,
  );
  static bool _$isIntro(PracticeCard v) => v.isIntro;
  static const Field<PracticeCard, bool> _f$isIntro = Field(
    'isIntro',
    _$isIntro,
  );

  @override
  final MappableFields<PracticeCard> fields = const {
    #item: _f$item,
    #prompt: _f$prompt,
    #isIntro: _f$isIntro,
  };

  static PracticeCard _instantiate(DecodingData data) {
    return PracticeCard(
      item: data.dec(_f$item),
      prompt: data.dec(_f$prompt),
      isIntro: data.dec(_f$isIntro),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PracticeCard fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PracticeCard>(map);
  }

  static PracticeCard fromJson(String json) {
    return ensureInitialized().decodeJson<PracticeCard>(json);
  }
}

mixin PracticeCardMappable {
  String toJson() {
    return PracticeCardMapper.ensureInitialized().encodeJson<PracticeCard>(
      this as PracticeCard,
    );
  }

  Map<String, dynamic> toMap() {
    return PracticeCardMapper.ensureInitialized().encodeMap<PracticeCard>(
      this as PracticeCard,
    );
  }

  PracticeCardCopyWith<PracticeCard, PracticeCard, PracticeCard> get copyWith =>
      _PracticeCardCopyWithImpl<PracticeCard, PracticeCard>(
        this as PracticeCard,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PracticeCardMapper.ensureInitialized().stringifyValue(
      this as PracticeCard,
    );
  }

  @override
  bool operator ==(Object other) {
    return PracticeCardMapper.ensureInitialized().equalsValue(
      this as PracticeCard,
      other,
    );
  }

  @override
  int get hashCode {
    return PracticeCardMapper.ensureInitialized().hashValue(
      this as PracticeCard,
    );
  }
}

extension PracticeCardValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PracticeCard, $Out> {
  PracticeCardCopyWith<$R, PracticeCard, $Out> get $asPracticeCard =>
      $base.as((v, t, t2) => _PracticeCardCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PracticeCardCopyWith<$R, $In extends PracticeCard, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PracticeItemCopyWith<$R, PracticeItem, PracticeItem> get item;
  $R call({PracticeItem? item, Language? prompt, bool? isIntro});
  PracticeCardCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PracticeCardCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PracticeCard, $Out>
    implements PracticeCardCopyWith<$R, PracticeCard, $Out> {
  _PracticeCardCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PracticeCard> $mapper =
      PracticeCardMapper.ensureInitialized();
  @override
  PracticeItemCopyWith<$R, PracticeItem, PracticeItem> get item =>
      $value.item.copyWith.$chain((v) => call(item: v));
  @override
  $R call({PracticeItem? item, Language? prompt, bool? isIntro}) => $apply(
    FieldCopyWithData({
      if (item != null) #item: item,
      if (prompt != null) #prompt: prompt,
      if (isIntro != null) #isIntro: isIntro,
    }),
  );
  @override
  PracticeCard $make(CopyWithData data) => PracticeCard(
    item: data.get(#item, or: $value.item),
    prompt: data.get(#prompt, or: $value.prompt),
    isIntro: data.get(#isIntro, or: $value.isIntro),
  );

  @override
  PracticeCardCopyWith<$R2, PracticeCard, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PracticeCardCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

