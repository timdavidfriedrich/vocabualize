// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'settings_state.dart';

class SettingsActionMapper extends EnumMapper<SettingsAction> {
  SettingsActionMapper._();

  static SettingsActionMapper? _instance;
  static SettingsActionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsActionMapper._());
    }
    return _instance!;
  }

  static SettingsAction fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  SettingsAction decode(dynamic value) {
    switch (value) {
      case r'signIn':
        return SettingsAction.signIn;
      case r'signOut':
        return SettingsAction.signOut;
      case r'deletion':
        return SettingsAction.deletion;
      case r'backupExport':
        return SettingsAction.backupExport;
      case r'backupImport':
        return SettingsAction.backupImport;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(SettingsAction self) {
    switch (self) {
      case SettingsAction.signIn:
        return r'signIn';
      case SettingsAction.signOut:
        return r'signOut';
      case SettingsAction.deletion:
        return r'deletion';
      case SettingsAction.backupExport:
        return r'backupExport';
      case SettingsAction.backupImport:
        return r'backupImport';
    }
  }
}

extension SettingsActionMapperExtension on SettingsAction {
  String toValue() {
    SettingsActionMapper.ensureInitialized();
    return MapperContainer.globals.toValue<SettingsAction>(this) as String;
  }
}

class SettingsStateMapper extends ClassMapperBase<SettingsState> {
  SettingsStateMapper._();

  static SettingsStateMapper? _instance;
  static SettingsStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsStateMapper._());
      SettingsLoadingMapper.ensureInitialized();
      SettingsLoadedMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsState';

  @override
  final MappableFields<SettingsState> fields = const {};

  static SettingsState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('SettingsState');
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsState>(map);
  }

  static SettingsState fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsState>(json);
  }
}

mixin SettingsStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  SettingsStateCopyWith<SettingsState, SettingsState, SettingsState>
  get copyWith;
}

abstract class SettingsStateCopyWith<$R, $In extends SettingsState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  SettingsStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class SettingsLoadingMapper extends ClassMapperBase<SettingsLoading> {
  SettingsLoadingMapper._();

  static SettingsLoadingMapper? _instance;
  static SettingsLoadingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsLoadingMapper._());
      SettingsStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsLoading';

  @override
  final MappableFields<SettingsLoading> fields = const {};

  static SettingsLoading _instantiate(DecodingData data) {
    return SettingsLoading();
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsLoading fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsLoading>(map);
  }

  static SettingsLoading fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsLoading>(json);
  }
}

mixin SettingsLoadingMappable {
  String toJson() {
    return SettingsLoadingMapper.ensureInitialized()
        .encodeJson<SettingsLoading>(this as SettingsLoading);
  }

  Map<String, dynamic> toMap() {
    return SettingsLoadingMapper.ensureInitialized().encodeMap<SettingsLoading>(
      this as SettingsLoading,
    );
  }

  SettingsLoadingCopyWith<SettingsLoading, SettingsLoading, SettingsLoading>
  get copyWith =>
      _SettingsLoadingCopyWithImpl<SettingsLoading, SettingsLoading>(
        this as SettingsLoading,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SettingsLoadingMapper.ensureInitialized().stringifyValue(
      this as SettingsLoading,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsLoadingMapper.ensureInitialized().equalsValue(
      this as SettingsLoading,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsLoadingMapper.ensureInitialized().hashValue(
      this as SettingsLoading,
    );
  }
}

extension SettingsLoadingValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsLoading, $Out> {
  SettingsLoadingCopyWith<$R, SettingsLoading, $Out> get $asSettingsLoading =>
      $base.as((v, t, t2) => _SettingsLoadingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsLoadingCopyWith<$R, $In extends SettingsLoading, $Out>
    implements SettingsStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  SettingsLoadingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SettingsLoadingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsLoading, $Out>
    implements SettingsLoadingCopyWith<$R, SettingsLoading, $Out> {
  _SettingsLoadingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsLoading> $mapper =
      SettingsLoadingMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  SettingsLoading $make(CopyWithData data) => SettingsLoading();

  @override
  SettingsLoadingCopyWith<$R2, SettingsLoading, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsLoadingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SettingsLoadedMapper extends ClassMapperBase<SettingsLoaded> {
  SettingsLoadedMapper._();

  static SettingsLoadedMapper? _instance;
  static SettingsLoadedMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SettingsLoadedMapper._());
      SettingsStateMapper.ensureInitialized();
      AccountMapper.ensureInitialized();
      SettingsActionMapper.ensureInitialized();
      BackupImportRunningMapper.ensureInitialized();
      AccountConflictMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SettingsLoaded';

  static Account _$account(SettingsLoaded v) => v.account;
  static const Field<SettingsLoaded, Account> _f$account = Field(
    'account',
    _$account,
  );
  static SettingsAction? _$runningAction(SettingsLoaded v) => v.runningAction;
  static const Field<SettingsLoaded, SettingsAction> _f$runningAction = Field(
    'runningAction',
    _$runningAction,
  );
  static bool _$isSignOutBlocked(SettingsLoaded v) => v.isSignOutBlocked;
  static const Field<SettingsLoaded, bool> _f$isSignOutBlocked = Field(
    'isSignOutBlocked',
    _$isSignOutBlocked,
  );
  static int? _$importedCount(SettingsLoaded v) => v.importedCount;
  static const Field<SettingsLoaded, int> _f$importedCount = Field(
    'importedCount',
    _$importedCount,
  );
  static BackupImportRunning? _$importProgress(SettingsLoaded v) =>
      v.importProgress;
  static const Field<SettingsLoaded, BackupImportRunning> _f$importProgress =
      Field('importProgress', _$importProgress);
  static AccountConflict? _$accountConflict(SettingsLoaded v) =>
      v.accountConflict;
  static const Field<SettingsLoaded, AccountConflict> _f$accountConflict =
      Field('accountConflict', _$accountConflict);
  static AppError? _$error(SettingsLoaded v) => v.error;
  static const Field<SettingsLoaded, AppError> _f$error = Field(
    'error',
    _$error,
  );

  @override
  final MappableFields<SettingsLoaded> fields = const {
    #account: _f$account,
    #runningAction: _f$runningAction,
    #isSignOutBlocked: _f$isSignOutBlocked,
    #importedCount: _f$importedCount,
    #importProgress: _f$importProgress,
    #accountConflict: _f$accountConflict,
    #error: _f$error,
  };

  static SettingsLoaded _instantiate(DecodingData data) {
    return SettingsLoaded(
      account: data.dec(_f$account),
      runningAction: data.dec(_f$runningAction),
      isSignOutBlocked: data.dec(_f$isSignOutBlocked),
      importedCount: data.dec(_f$importedCount),
      importProgress: data.dec(_f$importProgress),
      accountConflict: data.dec(_f$accountConflict),
      error: data.dec(_f$error),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SettingsLoaded fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SettingsLoaded>(map);
  }

  static SettingsLoaded fromJson(String json) {
    return ensureInitialized().decodeJson<SettingsLoaded>(json);
  }
}

mixin SettingsLoadedMappable {
  String toJson() {
    return SettingsLoadedMapper.ensureInitialized().encodeJson<SettingsLoaded>(
      this as SettingsLoaded,
    );
  }

  Map<String, dynamic> toMap() {
    return SettingsLoadedMapper.ensureInitialized().encodeMap<SettingsLoaded>(
      this as SettingsLoaded,
    );
  }

  SettingsLoadedCopyWith<SettingsLoaded, SettingsLoaded, SettingsLoaded>
  get copyWith => _SettingsLoadedCopyWithImpl<SettingsLoaded, SettingsLoaded>(
    this as SettingsLoaded,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return SettingsLoadedMapper.ensureInitialized().stringifyValue(
      this as SettingsLoaded,
    );
  }

  @override
  bool operator ==(Object other) {
    return SettingsLoadedMapper.ensureInitialized().equalsValue(
      this as SettingsLoaded,
      other,
    );
  }

  @override
  int get hashCode {
    return SettingsLoadedMapper.ensureInitialized().hashValue(
      this as SettingsLoaded,
    );
  }
}

extension SettingsLoadedValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SettingsLoaded, $Out> {
  SettingsLoadedCopyWith<$R, SettingsLoaded, $Out> get $asSettingsLoaded =>
      $base.as((v, t, t2) => _SettingsLoadedCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SettingsLoadedCopyWith<$R, $In extends SettingsLoaded, $Out>
    implements SettingsStateCopyWith<$R, $In, $Out> {
  AccountCopyWith<$R, Account, Account> get account;
  BackupImportRunningCopyWith<$R, BackupImportRunning, BackupImportRunning>?
  get importProgress;
  AccountConflictCopyWith<$R, AccountConflict, AccountConflict>?
  get accountConflict;
  @override
  $R call({
    Account? account,
    SettingsAction? runningAction,
    bool? isSignOutBlocked,
    int? importedCount,
    BackupImportRunning? importProgress,
    AccountConflict? accountConflict,
    AppError? error,
  });
  SettingsLoadedCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SettingsLoadedCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SettingsLoaded, $Out>
    implements SettingsLoadedCopyWith<$R, SettingsLoaded, $Out> {
  _SettingsLoadedCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SettingsLoaded> $mapper =
      SettingsLoadedMapper.ensureInitialized();
  @override
  AccountCopyWith<$R, Account, Account> get account =>
      $value.account.copyWith.$chain((v) => call(account: v));
  @override
  BackupImportRunningCopyWith<$R, BackupImportRunning, BackupImportRunning>?
  get importProgress =>
      $value.importProgress?.copyWith.$chain((v) => call(importProgress: v));
  @override
  AccountConflictCopyWith<$R, AccountConflict, AccountConflict>?
  get accountConflict =>
      $value.accountConflict?.copyWith.$chain((v) => call(accountConflict: v));
  @override
  $R call({
    Account? account,
    Object? runningAction = $none,
    bool? isSignOutBlocked,
    Object? importedCount = $none,
    Object? importProgress = $none,
    Object? accountConflict = $none,
    Object? error = $none,
  }) => $apply(
    FieldCopyWithData({
      if (account != null) #account: account,
      if (runningAction != $none) #runningAction: runningAction,
      if (isSignOutBlocked != null) #isSignOutBlocked: isSignOutBlocked,
      if (importedCount != $none) #importedCount: importedCount,
      if (importProgress != $none) #importProgress: importProgress,
      if (accountConflict != $none) #accountConflict: accountConflict,
      if (error != $none) #error: error,
    }),
  );
  @override
  SettingsLoaded $make(CopyWithData data) => SettingsLoaded(
    account: data.get(#account, or: $value.account),
    runningAction: data.get(#runningAction, or: $value.runningAction),
    isSignOutBlocked: data.get(#isSignOutBlocked, or: $value.isSignOutBlocked),
    importedCount: data.get(#importedCount, or: $value.importedCount),
    importProgress: data.get(#importProgress, or: $value.importProgress),
    accountConflict: data.get(#accountConflict, or: $value.accountConflict),
    error: data.get(#error, or: $value.error),
  );

  @override
  SettingsLoadedCopyWith<$R2, SettingsLoaded, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SettingsLoadedCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

