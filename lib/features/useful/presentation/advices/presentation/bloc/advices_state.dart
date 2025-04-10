part of 'advices_bloc.dart';

sealed class AdvicesState extends Equatable {
  const AdvicesState();
  
  @override
  List<Object> get props => [];
}

final class AdvicesInitial extends AdvicesState {}
