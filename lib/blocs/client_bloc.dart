import 'dart:async';

import 'package:flutter_bloc/blocs/client_events.dart';
import 'package:flutter_bloc/blocs/client_state.dart';
import 'package:flutter_bloc/models/client.dart';
import 'package:flutter_bloc/repository/clients_repository.dart';

class ClientBloc {
  final _clientRepo = ClientRepository();

  final StreamController<ClientEvent> _inputClientController =
      StreamController<ClientEvent>();

  final StreamController<ClientState> _outputClientController =
      StreamController<ClientState>();

  Sink<ClientEvent> get inputClient => _inputClientController.sink;
  Stream<ClientState> get stream => _outputClientController.stream;

  ClientBloc() {
    _inputClientController.stream.listen(_mapEventToState);
  }

  _mapEventToState(ClientEvent event) {
    List<Client> clients = [];

    if (event is LoadClientEvent) {
      clients = _clientRepo.loadClients();
    } else if (event is AddClientEvent) {
      clients = _clientRepo.addClient(event.client);
    } else if (event is RemoveClientEvent) {
      clients = _clientRepo.removeClient(event.client);
    }

    _outputClientController.add(ClientSuccesState(clients: clients));
  }
}
