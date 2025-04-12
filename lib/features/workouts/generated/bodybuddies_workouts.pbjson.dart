//
//  Generated code. Do not modify.
//  source: bodybuddies_workouts.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use requestDtoDescriptor instead')
const RequestDto$json = {
  '1': 'RequestDto',
};

/// Descriptor for `RequestDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List requestDtoDescriptor = $convert.base64Decode(
    'CgpSZXF1ZXN0RHRv');

@$core.Deprecated('Use responseDtoDescriptor instead')
const ResponseDto$json = {
  '1': 'ResponseDto',
  '2': [
    {'1': 'message', '3': 1, '4': 1, '5': 9, '10': 'message'},
  ],
};

/// Descriptor for `ResponseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List responseDtoDescriptor = $convert.base64Decode(
    'CgtSZXNwb25zZUR0bxIYCgdtZXNzYWdlGAEgASgJUgdtZXNzYWdl');

@$core.Deprecated('Use allWorkoutsDtoDescriptor instead')
const AllWorkoutsDto$json = {
  '1': 'AllWorkoutsDto',
  '2': [
    {'1': 'workouts', '3': 1, '4': 3, '5': 11, '6': '.WorkoutDto', '10': 'workouts'},
  ],
};

/// Descriptor for `AllWorkoutsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allWorkoutsDtoDescriptor = $convert.base64Decode(
    'Cg5BbGxXb3Jrb3V0c0R0bxInCgh3b3Jrb3V0cxgBIAMoCzILLldvcmtvdXREdG9SCHdvcmtvdX'
    'Rz');

@$core.Deprecated('Use allJournalWorkoutsDtoDescriptor instead')
const AllJournalWorkoutsDto$json = {
  '1': 'AllJournalWorkoutsDto',
  '2': [
    {'1': 'workouts', '3': 1, '4': 3, '5': 11, '6': '.JournalWorkoutDto', '10': 'workouts'},
  ],
};

/// Descriptor for `AllJournalWorkoutsDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allJournalWorkoutsDtoDescriptor = $convert.base64Decode(
    'ChVBbGxKb3VybmFsV29ya291dHNEdG8SLgoId29ya291dHMYASADKAsyEi5Kb3VybmFsV29ya2'
    '91dER0b1IId29ya291dHM=');

@$core.Deprecated('Use workoutDtoDescriptor instead')
const WorkoutDto$json = {
  '1': 'WorkoutDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'author_id', '3': 2, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'weekday', '3': 4, '4': 1, '5': 9, '10': 'weekday'},
    {'1': 'exercises', '3': 5, '4': 3, '5': 11, '6': '.ExerciseDto', '10': 'exercises'},
  ],
};

/// Descriptor for `WorkoutDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workoutDtoDescriptor = $convert.base64Decode(
    'CgpXb3Jrb3V0RHRvEg4KAmlkGAEgASgJUgJpZBIbCglhdXRob3JfaWQYAiABKAlSCGF1dGhvck'
    'lkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIYCgd3ZWVrZGF5GAQgASgJUgd3ZWVrZGF5EioKCWV4'
    'ZXJjaXNlcxgFIAMoCzIMLkV4ZXJjaXNlRHRvUglleGVyY2lzZXM=');

@$core.Deprecated('Use journalWorkoutDtoDescriptor instead')
const JournalWorkoutDto$json = {
  '1': 'JournalWorkoutDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'author_id', '3': 2, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'duration', '3': 4, '4': 1, '5': 9, '10': 'duration'},
    {'1': 'date', '3': 5, '4': 1, '5': 9, '10': 'date'},
    {'1': 'exercises', '3': 6, '4': 3, '5': 11, '6': '.ExerciseDto', '10': 'exercises'},
  ],
};

/// Descriptor for `JournalWorkoutDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List journalWorkoutDtoDescriptor = $convert.base64Decode(
    'ChFKb3VybmFsV29ya291dER0bxIOCgJpZBgBIAEoCVICaWQSGwoJYXV0aG9yX2lkGAIgASgJUg'
    'hhdXRob3JJZBIUCgV0aXRsZRgDIAEoCVIFdGl0bGUSGgoIZHVyYXRpb24YBCABKAlSCGR1cmF0'
    'aW9uEhIKBGRhdGUYBSABKAlSBGRhdGUSKgoJZXhlcmNpc2VzGAYgAygLMgwuRXhlcmNpc2VEdG'
    '9SCWV4ZXJjaXNlcw==');

@$core.Deprecated('Use exerciseDtoDescriptor instead')
const ExerciseDto$json = {
  '1': 'ExerciseDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'author_id', '3': 2, '4': 1, '5': 9, '10': 'authorId'},
    {'1': 'workout_id', '3': 3, '4': 1, '5': 9, '10': 'workoutId'},
    {'1': 'title', '3': 4, '4': 1, '5': 9, '10': 'title'},
    {'1': 'isExercise', '3': 5, '4': 1, '5': 8, '10': 'isExercise'},
    {'1': 'isTimerExercise', '3': 6, '4': 1, '5': 8, '10': 'isTimerExercise'},
    {'1': 'weight', '3': 7, '4': 1, '5': 9, '10': 'weight'},
    {'1': 'reps', '3': 8, '4': 1, '5': 9, '10': 'reps'},
    {'1': 'sets', '3': 9, '4': 1, '5': 9, '10': 'sets'},
    {'1': 'exerciseTimeMinutes', '3': 10, '4': 1, '5': 9, '10': 'exerciseTimeMinutes'},
    {'1': 'exerciseTimeSeconds', '3': 11, '4': 1, '5': 9, '10': 'exerciseTimeSeconds'},
    {'1': 'restTimeMinutes', '3': 12, '4': 1, '5': 9, '10': 'restTimeMinutes'},
    {'1': 'restTimeSeconds', '3': 13, '4': 1, '5': 9, '10': 'restTimeSeconds'},
  ],
};

/// Descriptor for `ExerciseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exerciseDtoDescriptor = $convert.base64Decode(
    'CgtFeGVyY2lzZUR0bxIOCgJpZBgBIAEoCVICaWQSGwoJYXV0aG9yX2lkGAIgASgJUghhdXRob3'
    'JJZBIdCgp3b3Jrb3V0X2lkGAMgASgJUgl3b3Jrb3V0SWQSFAoFdGl0bGUYBCABKAlSBXRpdGxl'
    'Eh4KCmlzRXhlcmNpc2UYBSABKAhSCmlzRXhlcmNpc2USKAoPaXNUaW1lckV4ZXJjaXNlGAYgAS'
    'gIUg9pc1RpbWVyRXhlcmNpc2USFgoGd2VpZ2h0GAcgASgJUgZ3ZWlnaHQSEgoEcmVwcxgIIAEo'
    'CVIEcmVwcxISCgRzZXRzGAkgASgJUgRzZXRzEjAKE2V4ZXJjaXNlVGltZU1pbnV0ZXMYCiABKA'
    'lSE2V4ZXJjaXNlVGltZU1pbnV0ZXMSMAoTZXhlcmNpc2VUaW1lU2Vjb25kcxgLIAEoCVITZXhl'
    'cmNpc2VUaW1lU2Vjb25kcxIoCg9yZXN0VGltZU1pbnV0ZXMYDCABKAlSD3Jlc3RUaW1lTWludX'
    'RlcxIoCg9yZXN0VGltZVNlY29uZHMYDSABKAlSD3Jlc3RUaW1lU2Vjb25kcw==');

