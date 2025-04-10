part of 'advices_bloc.dart';

sealed class AdvicesState extends Equatable {
  const AdvicesState();

  @override
  List<Object> get props => [];
}

final class AdvicesInitial extends AdvicesState {}

final class FetchAdvices extends AdvicesState {
  List<AdviceEntity> advices;
  FetchAdvices(this.advices);
}

final class LoadingState extends AdvicesState {}
