import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:body_buddies/features/useful/domain/entity/advice_entity.dart';
import 'package:body_buddies/features/useful/domain/useful_repository.dart';
import 'package:body_buddies/services/secure_storage/i_secure_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

part 'advices_event.dart';
part 'advices_state.dart';

class AdvicesBloc extends Bloc<AdvicesEvent, AdvicesState> {
  final UsefulRepository usefulRepository;
  final SecureStorage storage;

  AdvicesBloc(this.usefulRepository, this.storage) : super(AdvicesInitial()) {
    on<FetchAdvicesEvent>(_fetchAdvices);
  }

  Future<void> _fetchAdvices(
      FetchAdvicesEvent event, Emitter<AdvicesState> emit) async {
    emit(LoadingState());
    try {
      print("TRy to fetch");
      final jsonToken = await storage.read(dotenv.env['TOKEN_KEY']!);
      print("json token is $jsonToken");
      final mapToken = jsonDecode(jsonToken);
      final token = mapToken['access_token'];

      final advices = await usefulRepository.fetchAdvices(token);
      print(advices);
      emit(FetchAdvices(advices));
    } on Object catch (error, stack) {
      throw Exception("Error: $error, StackTrace: $stack");
    }
  }
}
