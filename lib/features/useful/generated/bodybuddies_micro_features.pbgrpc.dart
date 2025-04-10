//
//  Generated code. Do not modify.
//  source: bodybuddies_micro_features.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'bodybuddies_micro_features.pb.dart' as $0;

export 'bodybuddies_micro_features.pb.dart';

@$pb.GrpcServiceName('MicroFeaturesRpc')
class MicroFeaturesRpcClient extends $grpc.Client {
  static final _$fetchAllExercises = $grpc.ClientMethod<$0.RequestDto, $0.AllExercisesDto>(
      '/MicroFeaturesRpc/FetchAllExercises',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllExercisesDto.fromBuffer(value));
  static final _$fetchAllWorkouts = $grpc.ClientMethod<$0.RequestDto, $0.AllWorkoutsDto>(
      '/MicroFeaturesRpc/FetchAllWorkouts',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllWorkoutsDto.fromBuffer(value));
  static final _$fetchAllAdvices = $grpc.ClientMethod<$0.RequestDto, $0.AllAdvicesDto>(
      '/MicroFeaturesRpc/FetchAllAdvices',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllAdvicesDto.fromBuffer(value));
  static final _$addWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/AddWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$addExercise = $grpc.ClientMethod<$0.ExerciseDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/AddExercise',
      ($0.ExerciseDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/DeleteWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteExercise = $grpc.ClientMethod<$0.ExerciseDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/DeleteExercise',
      ($0.ExerciseDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$addExerciseToAllExercises = $grpc.ClientMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/AddExerciseToAllExercises',
      ($0.ExerciseOnListDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteExerciseToAllExercises = $grpc.ClientMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/DeleteExerciseToAllExercises',
      ($0.ExerciseOnListDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$addAdvice = $grpc.ClientMethod<$0.AdviceDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/AddAdvice',
      ($0.AdviceDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteAdvice = $grpc.ClientMethod<$0.AdviceDto, $0.ResponseDto>(
      '/MicroFeaturesRpc/DeleteAdvice',
      ($0.AdviceDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));

  MicroFeaturesRpcClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.AllExercisesDto> fetchAllExercises($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllExercises, request, options: options);
  }

  $grpc.ResponseFuture<$0.AllWorkoutsDto> fetchAllWorkouts($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllWorkouts, request, options: options);
  }

  $grpc.ResponseFuture<$0.AllAdvicesDto> fetchAllAdvices($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllAdvices, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addExercise($0.ExerciseDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addExercise, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteExercise($0.ExerciseDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExercise, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addExerciseToAllExercises($0.ExerciseOnListDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addExerciseToAllExercises, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteExerciseToAllExercises($0.ExerciseOnListDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteExerciseToAllExercises, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addAdvice($0.AdviceDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addAdvice, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteAdvice($0.AdviceDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteAdvice, request, options: options);
  }
}

@$pb.GrpcServiceName('MicroFeaturesRpc')
abstract class MicroFeaturesRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'MicroFeaturesRpc';

  MicroFeaturesRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.AllExercisesDto>(
        'FetchAllExercises',
        fetchAllExercises_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.AllExercisesDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.AllWorkoutsDto>(
        'FetchAllWorkouts',
        fetchAllWorkouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.AllWorkoutsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.AllAdvicesDto>(
        'FetchAllAdvices',
        fetchAllAdvices_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.AllAdvicesDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.ResponseDto>(
        'AddWorkout',
        addWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseDto, $0.ResponseDto>(
        'AddExercise',
        addExercise_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.ResponseDto>(
        'DeleteWorkout',
        deleteWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseDto, $0.ResponseDto>(
        'DeleteExercise',
        deleteExercise_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
        'AddExerciseToAllExercises',
        addExerciseToAllExercises_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseOnListDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
        'DeleteExerciseToAllExercises',
        deleteExerciseToAllExercises_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseOnListDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdviceDto, $0.ResponseDto>(
        'AddAdvice',
        addAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdviceDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.AdviceDto, $0.ResponseDto>(
        'DeleteAdvice',
        deleteAdvice_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.AdviceDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.AllExercisesDto> fetchAllExercises_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllExercises(call, await request);
  }

  $async.Future<$0.AllWorkoutsDto> fetchAllWorkouts_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllWorkouts(call, await request);
  }

  $async.Future<$0.AllAdvicesDto> fetchAllAdvices_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllAdvices(call, await request);
  }

  $async.Future<$0.ResponseDto> addWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return addWorkout(call, await request);
  }

  $async.Future<$0.ResponseDto> addExercise_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseDto> request) async {
    return addExercise(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return deleteWorkout(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteExercise_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseDto> request) async {
    return deleteExercise(call, await request);
  }

  $async.Future<$0.ResponseDto> addExerciseToAllExercises_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseOnListDto> request) async {
    return addExerciseToAllExercises(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteExerciseToAllExercises_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseOnListDto> request) async {
    return deleteExerciseToAllExercises(call, await request);
  }

  $async.Future<$0.ResponseDto> addAdvice_Pre($grpc.ServiceCall call, $async.Future<$0.AdviceDto> request) async {
    return addAdvice(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteAdvice_Pre($grpc.ServiceCall call, $async.Future<$0.AdviceDto> request) async {
    return deleteAdvice(call, await request);
  }

  $async.Future<$0.AllExercisesDto> fetchAllExercises($grpc.ServiceCall call, $0.RequestDto request);
  $async.Future<$0.AllWorkoutsDto> fetchAllWorkouts($grpc.ServiceCall call, $0.RequestDto request);
  $async.Future<$0.AllAdvicesDto> fetchAllAdvices($grpc.ServiceCall call, $0.RequestDto request);
  $async.Future<$0.ResponseDto> addWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.ResponseDto> addExercise($grpc.ServiceCall call, $0.ExerciseDto request);
  $async.Future<$0.ResponseDto> deleteWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.ResponseDto> deleteExercise($grpc.ServiceCall call, $0.ExerciseDto request);
  $async.Future<$0.ResponseDto> addExerciseToAllExercises($grpc.ServiceCall call, $0.ExerciseOnListDto request);
  $async.Future<$0.ResponseDto> deleteExerciseToAllExercises($grpc.ServiceCall call, $0.ExerciseOnListDto request);
  $async.Future<$0.ResponseDto> addAdvice($grpc.ServiceCall call, $0.AdviceDto request);
  $async.Future<$0.ResponseDto> deleteAdvice($grpc.ServiceCall call, $0.AdviceDto request);
}
