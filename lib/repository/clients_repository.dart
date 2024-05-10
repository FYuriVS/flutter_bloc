import 'package:flutter_bloc/models/client.dart';

class ClientRepository {
  final List<Client> _clients = [];

  List<Client> loadClients() {
    _clients.addAll([
      Client(name: "Yuri"),
      Client(name: "Yago"),
      Client(name: "SASUUUUUKEEEE"),
      Client(name: "NARUTO-KUUUN"),
      Client(name: "KAKASHI-SENSEI")
    ]);

    return _clients;
  }

  List<Client> addClient(Client client) {
    _clients.add(client);
    return _clients;
  }

  List<Client> removeClient(Client client) {
    _clients.remove(client);
    return _clients;
  }
}
