import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'card_details_event.dart';
part 'card_details_state.dart';

@injectable
class CardDetailsBloc extends Bloc<CardDetailsEvent, CardDetailsState> {
  CardDetailsBloc() : super(CardDetailsInitial()) {
    on<CardDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
