//
//  Generated code. Do not modify.
//  source: bodybuddies_workouts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class RequestDto extends $pb.GeneratedMessage {
  factory RequestDto() => create();
  RequestDto._() : super();
  factory RequestDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RequestDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'RequestDto', createEmptyInstance: create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RequestDto clone() => RequestDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RequestDto copyWith(void Function(RequestDto) updates) => super.copyWith((message) => updates(message as RequestDto)) as RequestDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static RequestDto create() => RequestDto._();
  RequestDto createEmptyInstance() => create();
  static $pb.PbList<RequestDto> createRepeated() => $pb.PbList<RequestDto>();
  @$core.pragma('dart2js:noInline')
  static RequestDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RequestDto>(create);
  static RequestDto? _defaultInstance;
}

class ResponseDto extends $pb.GeneratedMessage {
  factory ResponseDto({
    $core.String? message,
  }) {
    final $result = create();
    if (message != null) {
      $result.message = message;
    }
    return $result;
  }
  ResponseDto._() : super();
  factory ResponseDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ResponseDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ResponseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'message')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ResponseDto clone() => ResponseDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ResponseDto copyWith(void Function(ResponseDto) updates) => super.copyWith((message) => updates(message as ResponseDto)) as ResponseDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ResponseDto create() => ResponseDto._();
  ResponseDto createEmptyInstance() => create();
  static $pb.PbList<ResponseDto> createRepeated() => $pb.PbList<ResponseDto>();
  @$core.pragma('dart2js:noInline')
  static ResponseDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ResponseDto>(create);
  static ResponseDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get message => $_getSZ(0);
  @$pb.TagNumber(1)
  set message($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMessage() => $_has(0);
  @$pb.TagNumber(1)
  void clearMessage() => clearField(1);
}

class AllExercisesDto extends $pb.GeneratedMessage {
  factory AllExercisesDto({
    $core.Iterable<ExerciseOnListDto>? exercises,
  }) {
    final $result = create();
    if (exercises != null) {
      $result.exercises.addAll(exercises);
    }
    return $result;
  }
  AllExercisesDto._() : super();
  factory AllExercisesDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllExercisesDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AllExercisesDto', createEmptyInstance: create)
    ..pc<ExerciseOnListDto>(1, _omitFieldNames ? '' : 'exercises', $pb.PbFieldType.PM, subBuilder: ExerciseOnListDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllExercisesDto clone() => AllExercisesDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllExercisesDto copyWith(void Function(AllExercisesDto) updates) => super.copyWith((message) => updates(message as AllExercisesDto)) as AllExercisesDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllExercisesDto create() => AllExercisesDto._();
  AllExercisesDto createEmptyInstance() => create();
  static $pb.PbList<AllExercisesDto> createRepeated() => $pb.PbList<AllExercisesDto>();
  @$core.pragma('dart2js:noInline')
  static AllExercisesDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllExercisesDto>(create);
  static AllExercisesDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<ExerciseOnListDto> get exercises => $_getList(0);
}

class AllWorkoutsDto extends $pb.GeneratedMessage {
  factory AllWorkoutsDto({
    $core.Iterable<WorkoutDto>? workouts,
  }) {
    final $result = create();
    if (workouts != null) {
      $result.workouts.addAll(workouts);
    }
    return $result;
  }
  AllWorkoutsDto._() : super();
  factory AllWorkoutsDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory AllWorkoutsDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'AllWorkoutsDto', createEmptyInstance: create)
    ..pc<WorkoutDto>(1, _omitFieldNames ? '' : 'workouts', $pb.PbFieldType.PM, subBuilder: WorkoutDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  AllWorkoutsDto clone() => AllWorkoutsDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  AllWorkoutsDto copyWith(void Function(AllWorkoutsDto) updates) => super.copyWith((message) => updates(message as AllWorkoutsDto)) as AllWorkoutsDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static AllWorkoutsDto create() => AllWorkoutsDto._();
  AllWorkoutsDto createEmptyInstance() => create();
  static $pb.PbList<AllWorkoutsDto> createRepeated() => $pb.PbList<AllWorkoutsDto>();
  @$core.pragma('dart2js:noInline')
  static AllWorkoutsDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<AllWorkoutsDto>(create);
  static AllWorkoutsDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<WorkoutDto> get workouts => $_getList(0);
}

class WorkoutDto extends $pb.GeneratedMessage {
  factory WorkoutDto({
    $core.String? id,
    $core.String? authorId,
    $core.String? title,
    $core.String? weekday,
    $core.Iterable<ExerciseDto>? exercises,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (authorId != null) {
      $result.authorId = authorId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (weekday != null) {
      $result.weekday = weekday;
    }
    if (exercises != null) {
      $result.exercises.addAll(exercises);
    }
    return $result;
  }
  WorkoutDto._() : super();
  factory WorkoutDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory WorkoutDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'WorkoutDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'authorId')
    ..aOS(3, _omitFieldNames ? '' : 'title')
    ..aOS(4, _omitFieldNames ? '' : 'weekday')
    ..pc<ExerciseDto>(5, _omitFieldNames ? '' : 'exercises', $pb.PbFieldType.PM, subBuilder: ExerciseDto.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  WorkoutDto clone() => WorkoutDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  WorkoutDto copyWith(void Function(WorkoutDto) updates) => super.copyWith((message) => updates(message as WorkoutDto)) as WorkoutDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static WorkoutDto create() => WorkoutDto._();
  WorkoutDto createEmptyInstance() => create();
  static $pb.PbList<WorkoutDto> createRepeated() => $pb.PbList<WorkoutDto>();
  @$core.pragma('dart2js:noInline')
  static WorkoutDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<WorkoutDto>(create);
  static WorkoutDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get authorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set authorId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthorId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get title => $_getSZ(2);
  @$pb.TagNumber(3)
  set title($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasTitle() => $_has(2);
  @$pb.TagNumber(3)
  void clearTitle() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get weekday => $_getSZ(3);
  @$pb.TagNumber(4)
  set weekday($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasWeekday() => $_has(3);
  @$pb.TagNumber(4)
  void clearWeekday() => clearField(4);

  @$pb.TagNumber(5)
  $core.List<ExerciseDto> get exercises => $_getList(4);
}

class ExerciseOnListDto extends $pb.GeneratedMessage {
  factory ExerciseOnListDto({
    $core.String? id,
    $core.String? title,
    $core.bool? isExercise,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (title != null) {
      $result.title = title;
    }
    if (isExercise != null) {
      $result.isExercise = isExercise;
    }
    return $result;
  }
  ExerciseOnListDto._() : super();
  factory ExerciseOnListDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExerciseOnListDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExerciseOnListDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'title')
    ..aOB(3, _omitFieldNames ? '' : 'isExercise', protoName: 'isExercise')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExerciseOnListDto clone() => ExerciseOnListDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExerciseOnListDto copyWith(void Function(ExerciseOnListDto) updates) => super.copyWith((message) => updates(message as ExerciseOnListDto)) as ExerciseOnListDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExerciseOnListDto create() => ExerciseOnListDto._();
  ExerciseOnListDto createEmptyInstance() => create();
  static $pb.PbList<ExerciseOnListDto> createRepeated() => $pb.PbList<ExerciseOnListDto>();
  @$core.pragma('dart2js:noInline')
  static ExerciseOnListDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExerciseOnListDto>(create);
  static ExerciseOnListDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get title => $_getSZ(1);
  @$pb.TagNumber(2)
  set title($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasTitle() => $_has(1);
  @$pb.TagNumber(2)
  void clearTitle() => clearField(2);

  @$pb.TagNumber(3)
  $core.bool get isExercise => $_getBF(2);
  @$pb.TagNumber(3)
  set isExercise($core.bool v) { $_setBool(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasIsExercise() => $_has(2);
  @$pb.TagNumber(3)
  void clearIsExercise() => clearField(3);
}

class ExerciseDto extends $pb.GeneratedMessage {
  factory ExerciseDto({
    $core.String? id,
    $core.String? authorId,
    $core.String? workoutId,
    $core.String? title,
    $core.bool? isExercise,
    $core.bool? isTimerExercise,
    $core.String? weight,
    $core.String? reps,
    $core.String? sets,
    $core.String? exerciseTimeMinutes,
    $core.String? exerciseTimeSeconds,
    $core.String? restTimeMinutes,
    $core.String? restTimeSeconds,
  }) {
    final $result = create();
    if (id != null) {
      $result.id = id;
    }
    if (authorId != null) {
      $result.authorId = authorId;
    }
    if (workoutId != null) {
      $result.workoutId = workoutId;
    }
    if (title != null) {
      $result.title = title;
    }
    if (isExercise != null) {
      $result.isExercise = isExercise;
    }
    if (isTimerExercise != null) {
      $result.isTimerExercise = isTimerExercise;
    }
    if (weight != null) {
      $result.weight = weight;
    }
    if (reps != null) {
      $result.reps = reps;
    }
    if (sets != null) {
      $result.sets = sets;
    }
    if (exerciseTimeMinutes != null) {
      $result.exerciseTimeMinutes = exerciseTimeMinutes;
    }
    if (exerciseTimeSeconds != null) {
      $result.exerciseTimeSeconds = exerciseTimeSeconds;
    }
    if (restTimeMinutes != null) {
      $result.restTimeMinutes = restTimeMinutes;
    }
    if (restTimeSeconds != null) {
      $result.restTimeSeconds = restTimeSeconds;
    }
    return $result;
  }
  ExerciseDto._() : super();
  factory ExerciseDto.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory ExerciseDto.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'ExerciseDto', createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'id')
    ..aOS(2, _omitFieldNames ? '' : 'authorId')
    ..aOS(3, _omitFieldNames ? '' : 'workoutId')
    ..aOS(4, _omitFieldNames ? '' : 'title')
    ..aOB(5, _omitFieldNames ? '' : 'isExercise', protoName: 'isExercise')
    ..aOB(6, _omitFieldNames ? '' : 'isTimerExercise', protoName: 'isTimerExercise')
    ..aOS(7, _omitFieldNames ? '' : 'weight')
    ..aOS(8, _omitFieldNames ? '' : 'reps')
    ..aOS(9, _omitFieldNames ? '' : 'sets')
    ..aOS(10, _omitFieldNames ? '' : 'exerciseTimeMinutes', protoName: 'exerciseTimeMinutes')
    ..aOS(11, _omitFieldNames ? '' : 'exerciseTimeSeconds', protoName: 'exerciseTimeSeconds')
    ..aOS(12, _omitFieldNames ? '' : 'restTimeMinutes', protoName: 'restTimeMinutes')
    ..aOS(13, _omitFieldNames ? '' : 'restTimeSeconds', protoName: 'restTimeSeconds')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  ExerciseDto clone() => ExerciseDto()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  ExerciseDto copyWith(void Function(ExerciseDto) updates) => super.copyWith((message) => updates(message as ExerciseDto)) as ExerciseDto;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static ExerciseDto create() => ExerciseDto._();
  ExerciseDto createEmptyInstance() => create();
  static $pb.PbList<ExerciseDto> createRepeated() => $pb.PbList<ExerciseDto>();
  @$core.pragma('dart2js:noInline')
  static ExerciseDto getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<ExerciseDto>(create);
  static ExerciseDto? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get authorId => $_getSZ(1);
  @$pb.TagNumber(2)
  set authorId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasAuthorId() => $_has(1);
  @$pb.TagNumber(2)
  void clearAuthorId() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get workoutId => $_getSZ(2);
  @$pb.TagNumber(3)
  set workoutId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasWorkoutId() => $_has(2);
  @$pb.TagNumber(3)
  void clearWorkoutId() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get title => $_getSZ(3);
  @$pb.TagNumber(4)
  set title($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasTitle() => $_has(3);
  @$pb.TagNumber(4)
  void clearTitle() => clearField(4);

  @$pb.TagNumber(5)
  $core.bool get isExercise => $_getBF(4);
  @$pb.TagNumber(5)
  set isExercise($core.bool v) { $_setBool(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasIsExercise() => $_has(4);
  @$pb.TagNumber(5)
  void clearIsExercise() => clearField(5);

  @$pb.TagNumber(6)
  $core.bool get isTimerExercise => $_getBF(5);
  @$pb.TagNumber(6)
  set isTimerExercise($core.bool v) { $_setBool(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasIsTimerExercise() => $_has(5);
  @$pb.TagNumber(6)
  void clearIsTimerExercise() => clearField(6);

  @$pb.TagNumber(7)
  $core.String get weight => $_getSZ(6);
  @$pb.TagNumber(7)
  set weight($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasWeight() => $_has(6);
  @$pb.TagNumber(7)
  void clearWeight() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get reps => $_getSZ(7);
  @$pb.TagNumber(8)
  set reps($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasReps() => $_has(7);
  @$pb.TagNumber(8)
  void clearReps() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get sets => $_getSZ(8);
  @$pb.TagNumber(9)
  set sets($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(9)
  $core.bool hasSets() => $_has(8);
  @$pb.TagNumber(9)
  void clearSets() => clearField(9);

  @$pb.TagNumber(10)
  $core.String get exerciseTimeMinutes => $_getSZ(9);
  @$pb.TagNumber(10)
  set exerciseTimeMinutes($core.String v) { $_setString(9, v); }
  @$pb.TagNumber(10)
  $core.bool hasExerciseTimeMinutes() => $_has(9);
  @$pb.TagNumber(10)
  void clearExerciseTimeMinutes() => clearField(10);

  @$pb.TagNumber(11)
  $core.String get exerciseTimeSeconds => $_getSZ(10);
  @$pb.TagNumber(11)
  set exerciseTimeSeconds($core.String v) { $_setString(10, v); }
  @$pb.TagNumber(11)
  $core.bool hasExerciseTimeSeconds() => $_has(10);
  @$pb.TagNumber(11)
  void clearExerciseTimeSeconds() => clearField(11);

  @$pb.TagNumber(12)
  $core.String get restTimeMinutes => $_getSZ(11);
  @$pb.TagNumber(12)
  set restTimeMinutes($core.String v) { $_setString(11, v); }
  @$pb.TagNumber(12)
  $core.bool hasRestTimeMinutes() => $_has(11);
  @$pb.TagNumber(12)
  void clearRestTimeMinutes() => clearField(12);

  @$pb.TagNumber(13)
  $core.String get restTimeSeconds => $_getSZ(12);
  @$pb.TagNumber(13)
  set restTimeSeconds($core.String v) { $_setString(12, v); }
  @$pb.TagNumber(13)
  $core.bool hasRestTimeSeconds() => $_has(12);
  @$pb.TagNumber(13)
  void clearRestTimeSeconds() => clearField(13);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
