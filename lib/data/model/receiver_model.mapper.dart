// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'receiver_model.dart';

class ReceiverModelMapper extends ClassMapperBase<ReceiverModel> {
  ReceiverModelMapper._();

  static ReceiverModelMapper? _instance;
  static ReceiverModelMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ReceiverModelMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ReceiverModel';

  static String _$ip(ReceiverModel v) => v.ip;
  static const Field<ReceiverModel, String> _f$ip = Field('ip', _$ip);
  static int _$port(ReceiverModel v) => v.port;
  static const Field<ReceiverModel, int> _f$port = Field('port', _$port);
  static String _$host(ReceiverModel v) => v.host;
  static const Field<ReceiverModel, String> _f$host = Field('host', _$host);
  static String _$os(ReceiverModel v) => v.os;
  static const Field<ReceiverModel, String> _f$os = Field('os', _$os);
  static String _$version(ReceiverModel v) => v.version;
  static const Field<ReceiverModel, String> _f$version =
      Field('version', _$version);

  @override
  final MappableFields<ReceiverModel> fields = const {
    #ip: _f$ip,
    #port: _f$port,
    #host: _f$host,
    #os: _f$os,
    #version: _f$version,
  };

  static ReceiverModel _instantiate(DecodingData data) {
    return ReceiverModel(
        ip: data.dec(_f$ip),
        port: data.dec(_f$port),
        host: data.dec(_f$host),
        os: data.dec(_f$os),
        version: data.dec(_f$version));
  }

  @override
  final Function instantiate = _instantiate;

  static ReceiverModel fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ReceiverModel>(map);
  }

  static ReceiverModel fromJson(String json) {
    return ensureInitialized().decodeJson<ReceiverModel>(json);
  }
}

mixin ReceiverModelMappable {
  String toJson() {
    return ReceiverModelMapper.ensureInitialized()
        .encodeJson<ReceiverModel>(this as ReceiverModel);
  }

  Map<String, dynamic> toMap() {
    return ReceiverModelMapper.ensureInitialized()
        .encodeMap<ReceiverModel>(this as ReceiverModel);
  }

  ReceiverModelCopyWith<ReceiverModel, ReceiverModel, ReceiverModel>
      get copyWith => _ReceiverModelCopyWithImpl(
          this as ReceiverModel, $identity, $identity);
  @override
  String toString() {
    return ReceiverModelMapper.ensureInitialized()
        .stringifyValue(this as ReceiverModel);
  }

  @override
  bool operator ==(Object other) {
    return ReceiverModelMapper.ensureInitialized()
        .equalsValue(this as ReceiverModel, other);
  }

  @override
  int get hashCode {
    return ReceiverModelMapper.ensureInitialized()
        .hashValue(this as ReceiverModel);
  }
}

extension ReceiverModelValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ReceiverModel, $Out> {
  ReceiverModelCopyWith<$R, ReceiverModel, $Out> get $asReceiverModel =>
      $base.as((v, t, t2) => _ReceiverModelCopyWithImpl(v, t, t2));
}

abstract class ReceiverModelCopyWith<$R, $In extends ReceiverModel, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? ip, int? port, String? host, String? os, String? version});
  ReceiverModelCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ReceiverModelCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ReceiverModel, $Out>
    implements ReceiverModelCopyWith<$R, ReceiverModel, $Out> {
  _ReceiverModelCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ReceiverModel> $mapper =
      ReceiverModelMapper.ensureInitialized();
  @override
  $R call({String? ip, int? port, String? host, String? os, String? version}) =>
      $apply(FieldCopyWithData({
        if (ip != null) #ip: ip,
        if (port != null) #port: port,
        if (host != null) #host: host,
        if (os != null) #os: os,
        if (version != null) #version: version
      }));
  @override
  ReceiverModel $make(CopyWithData data) => ReceiverModel(
      ip: data.get(#ip, or: $value.ip),
      port: data.get(#port, or: $value.port),
      host: data.get(#host, or: $value.host),
      os: data.get(#os, or: $value.os),
      version: data.get(#version, or: $value.version));

  @override
  ReceiverModelCopyWith<$R2, ReceiverModel, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ReceiverModelCopyWithImpl($value, $cast, t);
}
