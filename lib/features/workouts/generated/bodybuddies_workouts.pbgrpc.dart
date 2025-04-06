//
//  Generated code. Do not modify.
//  source: bodybuddies_workouts.proto
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

import 'bodybuddies_workouts.pb.dart' as $0;

export 'bodybuddies_workouts.pb.dart';

@$pb.GrpcServiceName('WorkoutsRpc')
class WorkoutsRpcClient extends $grpc.Client {
  static final _$fetchAllWorkouts = $grpc.ClientMethod<$0.RequestDto, $0.AllWorkoutsDto>(
      '/WorkoutsRpc/FetchAllWorkouts',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllWorkoutsDto.fromBuffer(value));
  static final _$addWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.ResponseDto>(
      '/WorkoutsRpc/AddWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.ResponseDto>(
      '/WorkoutsRpc/DeleteWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$updateWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.ResponseDto>(
      '/WorkoutsRpc/UpdateWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$fetchWorkout = $grpc.ClientMethod<$0.WorkoutDto, $0.WorkoutDto>(
      '/WorkoutsRpc/FetchWorkout',
      ($0.WorkoutDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value));
  static final _$addExercise = $grpc.ClientMethod<$0.ExerciseDto, $0.ResponseDto>(
      '/WorkoutsRpc/AddExercise',
      ($0.ExerciseDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$updateExercise = $grpc.ClientMethod<$0.ExerciseDto, $0.ResponseDto>(
      '/WorkoutsRpc/UpdateExercise',
      ($0.ExerciseDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteExercise = $grpc.ClientMethod<$0.ExerciseDto, $0.ResponseDto>(
      '/WorkoutsRpc/DeleteExercise',
      ($0.ExerciseDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$addExerciseToAllExercises = $grpc.ClientMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
      '/WorkoutsRpc/AddExerciseToAllExercises',
      ($0.ExerciseOnListDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$deleteExerciseToAllExercises = $grpc.ClientMethod<$0.ExerciseOnListDto, $0.ResponseDto>(
      '/WorkoutsRpc/DeleteExerciseToAllExercises',
      ($0.ExerciseOnListDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.ResponseDto.fromBuffer(value));
  static final _$fetchAllExercises = $grpc.ClientMethod<$0.RequestDto, $0.AllExercisesDto>(
      '/WorkoutsRpc/FetchAllExercises',
      ($0.RequestDto value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.AllExercisesDto.fromBuffer(value));

  WorkoutsRpcClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseFuture<$0.AllWorkoutsDto> fetchAllWorkouts($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllWorkouts, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> deleteWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$deleteWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> updateWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.WorkoutDto> fetchWorkout($0.WorkoutDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchWorkout, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> addExercise($0.ExerciseDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$addExercise, request, options: options);
  }

  $grpc.ResponseFuture<$0.ResponseDto> updateExercise($0.ExerciseDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$updateExercise, request, options: options);
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

  $grpc.ResponseFuture<$0.AllExercisesDto> fetchAllExercises($0.RequestDto request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$fetchAllExercises, request, options: options);
  }
}

@$pb.GrpcServiceName('WorkoutsRpc')
abstract class WorkoutsRpcServiceBase extends $grpc.Service {
  $core.String get $name => 'WorkoutsRpc';

  WorkoutsRpcServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.AllWorkoutsDto>(
        'FetchAllWorkouts',
        fetchAllWorkouts_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.AllWorkoutsDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.ResponseDto>(
        'AddWorkout',
        addWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.ResponseDto>(
        'DeleteWorkout',
        deleteWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.ResponseDto>(
        'UpdateWorkout',
        updateWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.WorkoutDto, $0.WorkoutDto>(
        'FetchWorkout',
        fetchWorkout_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.WorkoutDto.fromBuffer(value),
        ($0.WorkoutDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseDto, $0.ResponseDto>(
        'AddExercise',
        addExercise_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseDto.fromBuffer(value),
        ($0.ResponseDto value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.ExerciseDto, $0.ResponseDto>(
        'UpdateExercise',
        updateExercise_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.ExerciseDto.fromBuffer(value),
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
    $addMethod($grpc.ServiceMethod<$0.RequestDto, $0.AllExercisesDto>(
        'FetchAllExercises',
        fetchAllExercises_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.RequestDto.fromBuffer(value),
        ($0.AllExercisesDto value) => value.writeToBuffer()));
  }

  $async.Future<$0.AllWorkoutsDto> fetchAllWorkouts_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllWorkouts(call, await request);
  }

  $async.Future<$0.ResponseDto> addWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return addWorkout(call, await request);
  }

  $async.Future<$0.ResponseDto> deleteWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return deleteWorkout(call, await request);
  }

  $async.Future<$0.ResponseDto> updateWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return updateWorkout(call, await request);
  }

  $async.Future<$0.WorkoutDto> fetchWorkout_Pre($grpc.ServiceCall call, $async.Future<$0.WorkoutDto> request) async {
    return fetchWorkout(call, await request);
  }

  $async.Future<$0.ResponseDto> addExercise_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseDto> request) async {
    return addExercise(call, await request);
  }

  $async.Future<$0.ResponseDto> updateExercise_Pre($grpc.ServiceCall call, $async.Future<$0.ExerciseDto> request) async {
    return updateExercise(call, await request);
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

  $async.Future<$0.AllExercisesDto> fetchAllExercises_Pre($grpc.ServiceCall call, $async.Future<$0.RequestDto> request) async {
    return fetchAllExercises(call, await request);
  }

  $async.Future<$0.AllWorkoutsDto> fetchAllWorkouts($grpc.ServiceCall call, $0.RequestDto request);
  $async.Future<$0.ResponseDto> addWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.ResponseDto> deleteWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.ResponseDto> updateWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.WorkoutDto> fetchWorkout($grpc.ServiceCall call, $0.WorkoutDto request);
  $async.Future<$0.ResponseDto> addExercise($grpc.ServiceCall call, $0.ExerciseDto request);
  $async.Future<$0.ResponseDto> updateExercise($grpc.ServiceCall call, $0.ExerciseDto request);
  $async.Future<$0.ResponseDto> deleteExercise($grpc.ServiceCall call, $0.ExerciseDto request);
  $async.Future<$0.ResponseDto> addExerciseToAllExercises($grpc.ServiceCall call, $0.ExerciseOnListDto request);
  $async.Future<$0.ResponseDto> deleteExerciseToAllExercises($grpc.ServiceCall call, $0.ExerciseOnListDto request);
  $async.Future<$0.AllExercisesDto> fetchAllExercises($grpc.ServiceCall call, $0.RequestDto request);
}
