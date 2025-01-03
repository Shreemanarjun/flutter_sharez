// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'file_download_state.dart';

class DownloadStateMapper extends ClassMapperBase<DownloadState> {
  DownloadStateMapper._();

  static DownloadStateMapper? _instance;
  static DownloadStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DownloadStateMapper._());
      InitialDownloadStateMapper.ensureInitialized();
      DownloadingStateMapper.ensureInitialized();
      CompletedDownloadStateMapper.ensureInitialized();
      ErrorDownloadStateMapper.ensureInitialized();
      MergeDoneStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DownloadState';

  @override
  final MappableFields<DownloadState> fields = const {};

  static DownloadState _instantiate(DecodingData data) {
    throw MapperException.missingConstructor('DownloadState');
  }

  @override
  final Function instantiate = _instantiate;

  static DownloadState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DownloadState>(map);
  }

  static DownloadState fromJson(String json) {
    return ensureInitialized().decodeJson<DownloadState>(json);
  }
}

mixin DownloadStateMappable {
  String toJson();
  Map<String, dynamic> toMap();
  DownloadStateCopyWith<DownloadState, DownloadState, DownloadState>
      get copyWith;
}

abstract class DownloadStateCopyWith<$R, $In extends DownloadState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call();
  DownloadStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class InitialDownloadStateMapper extends ClassMapperBase<InitialDownloadState> {
  InitialDownloadStateMapper._();

  static InitialDownloadStateMapper? _instance;
  static InitialDownloadStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = InitialDownloadStateMapper._());
      DownloadStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'InitialDownloadState';

  @override
  final MappableFields<InitialDownloadState> fields = const {};

  static InitialDownloadState _instantiate(DecodingData data) {
    return InitialDownloadState();
  }

  @override
  final Function instantiate = _instantiate;

  static InitialDownloadState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<InitialDownloadState>(map);
  }

  static InitialDownloadState fromJson(String json) {
    return ensureInitialized().decodeJson<InitialDownloadState>(json);
  }
}

mixin InitialDownloadStateMappable {
  String toJson() {
    return InitialDownloadStateMapper.ensureInitialized()
        .encodeJson<InitialDownloadState>(this as InitialDownloadState);
  }

  Map<String, dynamic> toMap() {
    return InitialDownloadStateMapper.ensureInitialized()
        .encodeMap<InitialDownloadState>(this as InitialDownloadState);
  }

  InitialDownloadStateCopyWith<InitialDownloadState, InitialDownloadState,
          InitialDownloadState>
      get copyWith => _InitialDownloadStateCopyWithImpl(
          this as InitialDownloadState, $identity, $identity);
  @override
  String toString() {
    return InitialDownloadStateMapper.ensureInitialized()
        .stringifyValue(this as InitialDownloadState);
  }

  @override
  bool operator ==(Object other) {
    return InitialDownloadStateMapper.ensureInitialized()
        .equalsValue(this as InitialDownloadState, other);
  }

  @override
  int get hashCode {
    return InitialDownloadStateMapper.ensureInitialized()
        .hashValue(this as InitialDownloadState);
  }
}

extension InitialDownloadStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, InitialDownloadState, $Out> {
  InitialDownloadStateCopyWith<$R, InitialDownloadState, $Out>
      get $asInitialDownloadState =>
          $base.as((v, t, t2) => _InitialDownloadStateCopyWithImpl(v, t, t2));
}

abstract class InitialDownloadStateCopyWith<
    $R,
    $In extends InitialDownloadState,
    $Out> implements DownloadStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  InitialDownloadStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _InitialDownloadStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, InitialDownloadState, $Out>
    implements InitialDownloadStateCopyWith<$R, InitialDownloadState, $Out> {
  _InitialDownloadStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<InitialDownloadState> $mapper =
      InitialDownloadStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  InitialDownloadState $make(CopyWithData data) => InitialDownloadState();

  @override
  InitialDownloadStateCopyWith<$R2, InitialDownloadState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _InitialDownloadStateCopyWithImpl($value, $cast, t);
}

class DownloadingStateMapper extends ClassMapperBase<DownloadingState> {
  DownloadingStateMapper._();

  static DownloadingStateMapper? _instance;
  static DownloadingStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DownloadingStateMapper._());
      DownloadStateMapper.ensureInitialized();
      ProgressMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DownloadingState';

  static Progress _$progress(DownloadingState v) => v.progress;
  static const Field<DownloadingState, Progress> _f$progress =
      Field('progress', _$progress);
  static bool _$isPaused(DownloadingState v) => v.isPaused;
  static const Field<DownloadingState, bool> _f$isPaused =
      Field('isPaused', _$isPaused);

  @override
  final MappableFields<DownloadingState> fields = const {
    #progress: _f$progress,
    #isPaused: _f$isPaused,
  };

  static DownloadingState _instantiate(DecodingData data) {
    return DownloadingState(
        progress: data.dec(_f$progress), isPaused: data.dec(_f$isPaused));
  }

  @override
  final Function instantiate = _instantiate;

  static DownloadingState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DownloadingState>(map);
  }

  static DownloadingState fromJson(String json) {
    return ensureInitialized().decodeJson<DownloadingState>(json);
  }
}

mixin DownloadingStateMappable {
  String toJson() {
    return DownloadingStateMapper.ensureInitialized()
        .encodeJson<DownloadingState>(this as DownloadingState);
  }

  Map<String, dynamic> toMap() {
    return DownloadingStateMapper.ensureInitialized()
        .encodeMap<DownloadingState>(this as DownloadingState);
  }

  DownloadingStateCopyWith<DownloadingState, DownloadingState, DownloadingState>
      get copyWith => _DownloadingStateCopyWithImpl(
          this as DownloadingState, $identity, $identity);
  @override
  String toString() {
    return DownloadingStateMapper.ensureInitialized()
        .stringifyValue(this as DownloadingState);
  }

  @override
  bool operator ==(Object other) {
    return DownloadingStateMapper.ensureInitialized()
        .equalsValue(this as DownloadingState, other);
  }

  @override
  int get hashCode {
    return DownloadingStateMapper.ensureInitialized()
        .hashValue(this as DownloadingState);
  }
}

extension DownloadingStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DownloadingState, $Out> {
  DownloadingStateCopyWith<$R, DownloadingState, $Out>
      get $asDownloadingState =>
          $base.as((v, t, t2) => _DownloadingStateCopyWithImpl(v, t, t2));
}

abstract class DownloadingStateCopyWith<$R, $In extends DownloadingState, $Out>
    implements DownloadStateCopyWith<$R, $In, $Out> {
  ProgressCopyWith<$R, Progress, Progress> get progress;
  @override
  $R call({Progress? progress, bool? isPaused});
  DownloadingStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DownloadingStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DownloadingState, $Out>
    implements DownloadingStateCopyWith<$R, DownloadingState, $Out> {
  _DownloadingStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DownloadingState> $mapper =
      DownloadingStateMapper.ensureInitialized();
  @override
  ProgressCopyWith<$R, Progress, Progress> get progress =>
      $value.progress.copyWith.$chain((v) => call(progress: v));
  @override
  $R call({Progress? progress, bool? isPaused}) => $apply(FieldCopyWithData({
        if (progress != null) #progress: progress,
        if (isPaused != null) #isPaused: isPaused
      }));
  @override
  DownloadingState $make(CopyWithData data) => DownloadingState(
      progress: data.get(#progress, or: $value.progress),
      isPaused: data.get(#isPaused, or: $value.isPaused));

  @override
  DownloadingStateCopyWith<$R2, DownloadingState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _DownloadingStateCopyWithImpl($value, $cast, t);
}

class ProgressMapper extends ClassMapperBase<Progress> {
  ProgressMapper._();

  static ProgressMapper? _instance;
  static ProgressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProgressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Progress';

  static double _$currentProgress(Progress v) => v.currentProgress;
  static const Field<Progress, double> _f$currentProgress =
      Field('currentProgress', _$currentProgress);
  static double _$speed(Progress v) => v.speed;
  static const Field<Progress, double> _f$speed = Field('speed', _$speed);
  static double _$remainTime(Progress v) => v.remainTime;
  static const Field<Progress, double> _f$remainTime =
      Field('remainTime', _$remainTime);

  @override
  final MappableFields<Progress> fields = const {
    #currentProgress: _f$currentProgress,
    #speed: _f$speed,
    #remainTime: _f$remainTime,
  };

  static Progress _instantiate(DecodingData data) {
    return Progress(
        currentProgress: data.dec(_f$currentProgress),
        speed: data.dec(_f$speed),
        remainTime: data.dec(_f$remainTime));
  }

  @override
  final Function instantiate = _instantiate;

  static Progress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Progress>(map);
  }

  static Progress fromJson(String json) {
    return ensureInitialized().decodeJson<Progress>(json);
  }
}

mixin ProgressMappable {
  String toJson() {
    return ProgressMapper.ensureInitialized()
        .encodeJson<Progress>(this as Progress);
  }

  Map<String, dynamic> toMap() {
    return ProgressMapper.ensureInitialized()
        .encodeMap<Progress>(this as Progress);
  }

  ProgressCopyWith<Progress, Progress, Progress> get copyWith =>
      _ProgressCopyWithImpl(this as Progress, $identity, $identity);
  @override
  String toString() {
    return ProgressMapper.ensureInitialized().stringifyValue(this as Progress);
  }

  @override
  bool operator ==(Object other) {
    return ProgressMapper.ensureInitialized()
        .equalsValue(this as Progress, other);
  }

  @override
  int get hashCode {
    return ProgressMapper.ensureInitialized().hashValue(this as Progress);
  }
}

extension ProgressValueCopy<$R, $Out> on ObjectCopyWith<$R, Progress, $Out> {
  ProgressCopyWith<$R, Progress, $Out> get $asProgress =>
      $base.as((v, t, t2) => _ProgressCopyWithImpl(v, t, t2));
}

abstract class ProgressCopyWith<$R, $In extends Progress, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({double? currentProgress, double? speed, double? remainTime});
  ProgressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProgressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Progress, $Out>
    implements ProgressCopyWith<$R, Progress, $Out> {
  _ProgressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Progress> $mapper =
      ProgressMapper.ensureInitialized();
  @override
  $R call({double? currentProgress, double? speed, double? remainTime}) =>
      $apply(FieldCopyWithData({
        if (currentProgress != null) #currentProgress: currentProgress,
        if (speed != null) #speed: speed,
        if (remainTime != null) #remainTime: remainTime
      }));
  @override
  Progress $make(CopyWithData data) => Progress(
      currentProgress: data.get(#currentProgress, or: $value.currentProgress),
      speed: data.get(#speed, or: $value.speed),
      remainTime: data.get(#remainTime, or: $value.remainTime));

  @override
  ProgressCopyWith<$R2, Progress, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProgressCopyWithImpl($value, $cast, t);
}

class CompletedDownloadStateMapper
    extends ClassMapperBase<CompletedDownloadState> {
  CompletedDownloadStateMapper._();

  static CompletedDownloadStateMapper? _instance;
  static CompletedDownloadStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CompletedDownloadStateMapper._());
      DownloadStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'CompletedDownloadState';

  @override
  final MappableFields<CompletedDownloadState> fields = const {};

  static CompletedDownloadState _instantiate(DecodingData data) {
    return CompletedDownloadState();
  }

  @override
  final Function instantiate = _instantiate;

  static CompletedDownloadState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CompletedDownloadState>(map);
  }

  static CompletedDownloadState fromJson(String json) {
    return ensureInitialized().decodeJson<CompletedDownloadState>(json);
  }
}

mixin CompletedDownloadStateMappable {
  String toJson() {
    return CompletedDownloadStateMapper.ensureInitialized()
        .encodeJson<CompletedDownloadState>(this as CompletedDownloadState);
  }

  Map<String, dynamic> toMap() {
    return CompletedDownloadStateMapper.ensureInitialized()
        .encodeMap<CompletedDownloadState>(this as CompletedDownloadState);
  }

  CompletedDownloadStateCopyWith<CompletedDownloadState, CompletedDownloadState,
          CompletedDownloadState>
      get copyWith => _CompletedDownloadStateCopyWithImpl(
          this as CompletedDownloadState, $identity, $identity);
  @override
  String toString() {
    return CompletedDownloadStateMapper.ensureInitialized()
        .stringifyValue(this as CompletedDownloadState);
  }

  @override
  bool operator ==(Object other) {
    return CompletedDownloadStateMapper.ensureInitialized()
        .equalsValue(this as CompletedDownloadState, other);
  }

  @override
  int get hashCode {
    return CompletedDownloadStateMapper.ensureInitialized()
        .hashValue(this as CompletedDownloadState);
  }
}

extension CompletedDownloadStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, CompletedDownloadState, $Out> {
  CompletedDownloadStateCopyWith<$R, CompletedDownloadState, $Out>
      get $asCompletedDownloadState =>
          $base.as((v, t, t2) => _CompletedDownloadStateCopyWithImpl(v, t, t2));
}

abstract class CompletedDownloadStateCopyWith<
    $R,
    $In extends CompletedDownloadState,
    $Out> implements DownloadStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  CompletedDownloadStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _CompletedDownloadStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CompletedDownloadState, $Out>
    implements
        CompletedDownloadStateCopyWith<$R, CompletedDownloadState, $Out> {
  _CompletedDownloadStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CompletedDownloadState> $mapper =
      CompletedDownloadStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  CompletedDownloadState $make(CopyWithData data) => CompletedDownloadState();

  @override
  CompletedDownloadStateCopyWith<$R2, CompletedDownloadState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _CompletedDownloadStateCopyWithImpl($value, $cast, t);
}

class ErrorDownloadStateMapper extends ClassMapperBase<ErrorDownloadState> {
  ErrorDownloadStateMapper._();

  static ErrorDownloadStateMapper? _instance;
  static ErrorDownloadStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ErrorDownloadStateMapper._());
      DownloadStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ErrorDownloadState';

  @override
  final MappableFields<ErrorDownloadState> fields = const {};

  static ErrorDownloadState _instantiate(DecodingData data) {
    return ErrorDownloadState();
  }

  @override
  final Function instantiate = _instantiate;

  static ErrorDownloadState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ErrorDownloadState>(map);
  }

  static ErrorDownloadState fromJson(String json) {
    return ensureInitialized().decodeJson<ErrorDownloadState>(json);
  }
}

mixin ErrorDownloadStateMappable {
  String toJson() {
    return ErrorDownloadStateMapper.ensureInitialized()
        .encodeJson<ErrorDownloadState>(this as ErrorDownloadState);
  }

  Map<String, dynamic> toMap() {
    return ErrorDownloadStateMapper.ensureInitialized()
        .encodeMap<ErrorDownloadState>(this as ErrorDownloadState);
  }

  ErrorDownloadStateCopyWith<ErrorDownloadState, ErrorDownloadState,
          ErrorDownloadState>
      get copyWith => _ErrorDownloadStateCopyWithImpl(
          this as ErrorDownloadState, $identity, $identity);
  @override
  String toString() {
    return ErrorDownloadStateMapper.ensureInitialized()
        .stringifyValue(this as ErrorDownloadState);
  }

  @override
  bool operator ==(Object other) {
    return ErrorDownloadStateMapper.ensureInitialized()
        .equalsValue(this as ErrorDownloadState, other);
  }

  @override
  int get hashCode {
    return ErrorDownloadStateMapper.ensureInitialized()
        .hashValue(this as ErrorDownloadState);
  }
}

extension ErrorDownloadStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ErrorDownloadState, $Out> {
  ErrorDownloadStateCopyWith<$R, ErrorDownloadState, $Out>
      get $asErrorDownloadState =>
          $base.as((v, t, t2) => _ErrorDownloadStateCopyWithImpl(v, t, t2));
}

abstract class ErrorDownloadStateCopyWith<$R, $In extends ErrorDownloadState,
    $Out> implements DownloadStateCopyWith<$R, $In, $Out> {
  @override
  $R call();
  ErrorDownloadStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ErrorDownloadStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ErrorDownloadState, $Out>
    implements ErrorDownloadStateCopyWith<$R, ErrorDownloadState, $Out> {
  _ErrorDownloadStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ErrorDownloadState> $mapper =
      ErrorDownloadStateMapper.ensureInitialized();
  @override
  $R call() => $apply(FieldCopyWithData({}));
  @override
  ErrorDownloadState $make(CopyWithData data) => ErrorDownloadState();

  @override
  ErrorDownloadStateCopyWith<$R2, ErrorDownloadState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ErrorDownloadStateCopyWithImpl($value, $cast, t);
}

class MergeDoneStateMapper extends ClassMapperBase<MergeDoneState> {
  MergeDoneStateMapper._();

  static MergeDoneStateMapper? _instance;
  static MergeDoneStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MergeDoneStateMapper._());
      DownloadStateMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MergeDoneState';

  static bool _$isCompleted(MergeDoneState v) => v.isCompleted;
  static const Field<MergeDoneState, bool> _f$isCompleted =
      Field('isCompleted', _$isCompleted);

  @override
  final MappableFields<MergeDoneState> fields = const {
    #isCompleted: _f$isCompleted,
  };

  static MergeDoneState _instantiate(DecodingData data) {
    return MergeDoneState(data.dec(_f$isCompleted));
  }

  @override
  final Function instantiate = _instantiate;

  static MergeDoneState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MergeDoneState>(map);
  }

  static MergeDoneState fromJson(String json) {
    return ensureInitialized().decodeJson<MergeDoneState>(json);
  }
}

mixin MergeDoneStateMappable {
  String toJson() {
    return MergeDoneStateMapper.ensureInitialized()
        .encodeJson<MergeDoneState>(this as MergeDoneState);
  }

  Map<String, dynamic> toMap() {
    return MergeDoneStateMapper.ensureInitialized()
        .encodeMap<MergeDoneState>(this as MergeDoneState);
  }

  MergeDoneStateCopyWith<MergeDoneState, MergeDoneState, MergeDoneState>
      get copyWith => _MergeDoneStateCopyWithImpl(
          this as MergeDoneState, $identity, $identity);
  @override
  String toString() {
    return MergeDoneStateMapper.ensureInitialized()
        .stringifyValue(this as MergeDoneState);
  }

  @override
  bool operator ==(Object other) {
    return MergeDoneStateMapper.ensureInitialized()
        .equalsValue(this as MergeDoneState, other);
  }

  @override
  int get hashCode {
    return MergeDoneStateMapper.ensureInitialized()
        .hashValue(this as MergeDoneState);
  }
}

extension MergeDoneStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MergeDoneState, $Out> {
  MergeDoneStateCopyWith<$R, MergeDoneState, $Out> get $asMergeDoneState =>
      $base.as((v, t, t2) => _MergeDoneStateCopyWithImpl(v, t, t2));
}

abstract class MergeDoneStateCopyWith<$R, $In extends MergeDoneState, $Out>
    implements DownloadStateCopyWith<$R, $In, $Out> {
  @override
  $R call({bool? isCompleted});
  MergeDoneStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _MergeDoneStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MergeDoneState, $Out>
    implements MergeDoneStateCopyWith<$R, MergeDoneState, $Out> {
  _MergeDoneStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MergeDoneState> $mapper =
      MergeDoneStateMapper.ensureInitialized();
  @override
  $R call({bool? isCompleted}) => $apply(
      FieldCopyWithData({if (isCompleted != null) #isCompleted: isCompleted}));
  @override
  MergeDoneState $make(CopyWithData data) =>
      MergeDoneState(data.get(#isCompleted, or: $value.isCompleted));

  @override
  MergeDoneStateCopyWith<$R2, MergeDoneState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _MergeDoneStateCopyWithImpl($value, $cast, t);
}
