//
//  Generated code. Do not modify.
//  source: bodybuddies_micro_features.proto
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

@$core.Deprecated('Use allExercisesDtoDescriptor instead')
const AllExercisesDto$json = {
  '1': 'AllExercisesDto',
  '2': [
    {'1': 'exercises', '3': 1, '4': 3, '5': 11, '6': '.ExerciseOnListDto', '10': 'exercises'},
  ],
};

/// Descriptor for `AllExercisesDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allExercisesDtoDescriptor = $convert.base64Decode(
    'Cg9BbGxFeGVyY2lzZXNEdG8SMAoJZXhlcmNpc2VzGAEgAygLMhIuRXhlcmNpc2VPbkxpc3REdG'
    '9SCWV4ZXJjaXNlcw==');

@$core.Deprecated('Use exerciseOnListDtoDescriptor instead')
const ExerciseOnListDto$json = {
  '1': 'ExerciseOnListDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'isExercise', '3': 3, '4': 1, '5': 8, '10': 'isExercise'},
  ],
};

/// Descriptor for `ExerciseOnListDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exerciseOnListDtoDescriptor = $convert.base64Decode(
    'ChFFeGVyY2lzZU9uTGlzdER0bxIOCgJpZBgBIAEoCVICaWQSFAoFdGl0bGUYAiABKAlSBXRpdG'
    'xlEh4KCmlzRXhlcmNpc2UYAyABKAhSCmlzRXhlcmNpc2U=');

@$core.Deprecated('Use allAdvicesDtoDescriptor instead')
const AllAdvicesDto$json = {
  '1': 'AllAdvicesDto',
  '2': [
    {'1': 'advices', '3': 1, '4': 3, '5': 11, '6': '.AdviceDto', '10': 'advices'},
  ],
};

/// Descriptor for `AllAdvicesDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List allAdvicesDtoDescriptor = $convert.base64Decode(
    'Cg1BbGxBZHZpY2VzRHRvEiQKB2FkdmljZXMYASADKAsyCi5BZHZpY2VEdG9SB2FkdmljZXM=');

@$core.Deprecated('Use adviceDtoDescriptor instead')
const AdviceDto$json = {
  '1': 'AdviceDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'body', '3': 3, '4': 1, '5': 9, '10': 'body'},
  ],
};

/// Descriptor for `AdviceDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List adviceDtoDescriptor = $convert.base64Decode(
    'CglBZHZpY2VEdG8SDgoCaWQYASABKAlSAmlkEhQKBXRpdGxlGAIgASgJUgV0aXRsZRISCgRib2'
    'R5GAMgASgJUgRib2R5');

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

@$core.Deprecated('Use workoutDtoDescriptor instead')
const WorkoutDto$json = {
  '1': 'WorkoutDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'title', '3': 2, '4': 1, '5': 9, '10': 'title'},
    {'1': 'exercises', '3': 4, '4': 3, '5': 11, '6': '.ExerciseDto', '10': 'exercises'},
  ],
};

/// Descriptor for `WorkoutDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List workoutDtoDescriptor = $convert.base64Decode(
    'CgpXb3Jrb3V0RHRvEg4KAmlkGAEgASgJUgJpZBIUCgV0aXRsZRgCIAEoCVIFdGl0bGUSKgoJZX'
    'hlcmNpc2VzGAQgAygLMgwuRXhlcmNpc2VEdG9SCWV4ZXJjaXNlcw==');

@$core.Deprecated('Use exerciseDtoDescriptor instead')
const ExerciseDto$json = {
  '1': 'ExerciseDto',
  '2': [
    {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    {'1': 'workout_id', '3': 2, '4': 1, '5': 9, '10': 'workoutId'},
    {'1': 'title', '3': 3, '4': 1, '5': 9, '10': 'title'},
    {'1': 'isExercise', '3': 4, '4': 1, '5': 8, '10': 'isExercise'},
    {'1': 'isTimerExercise', '3': 5, '4': 1, '5': 8, '10': 'isTimerExercise'},
    {'1': 'weight', '3': 6, '4': 1, '5': 9, '10': 'weight'},
    {'1': 'reps', '3': 7, '4': 1, '5': 9, '10': 'reps'},
    {'1': 'sets', '3': 8, '4': 1, '5': 9, '10': 'sets'},
    {'1': 'exerciseTimeMinutes', '3': 9, '4': 1, '5': 9, '10': 'exerciseTimeMinutes'},
    {'1': 'exerciseTimeSeconds', '3': 10, '4': 1, '5': 9, '10': 'exerciseTimeSeconds'},
    {'1': 'restTimeMinutes', '3': 11, '4': 1, '5': 9, '10': 'restTimeMinutes'},
    {'1': 'restTimeSeconds', '3': 12, '4': 1, '5': 9, '10': 'restTimeSeconds'},
  ],
};

/// Descriptor for `ExerciseDto`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List exerciseDtoDescriptor = $convert.base64Decode(
    'CgtFeGVyY2lzZUR0bxIOCgJpZBgBIAEoCVICaWQSHQoKd29ya291dF9pZBgCIAEoCVIJd29ya2'
    '91dElkEhQKBXRpdGxlGAMgASgJUgV0aXRsZRIeCgppc0V4ZXJjaXNlGAQgASgIUgppc0V4ZXJj'
    'aXNlEigKD2lzVGltZXJFeGVyY2lzZRgFIAEoCFIPaXNUaW1lckV4ZXJjaXNlEhYKBndlaWdodB'
    'gGIAEoCVIGd2VpZ2h0EhIKBHJlcHMYByABKAlSBHJlcHMSEgoEc2V0cxgIIAEoCVIEc2V0cxIw'
    'ChNleGVyY2lzZVRpbWVNaW51dGVzGAkgASgJUhNleGVyY2lzZVRpbWVNaW51dGVzEjAKE2V4ZX'
    'JjaXNlVGltZVNlY29uZHMYCiABKAlSE2V4ZXJjaXNlVGltZVNlY29uZHMSKAoPcmVzdFRpbWVN'
    'aW51dGVzGAsgASgJUg9yZXN0VGltZU1pbnV0ZXMSKAoPcmVzdFRpbWVTZWNvbmRzGAwgASgJUg'
    '9yZXN0VGltZVNlY29uZHM=');

