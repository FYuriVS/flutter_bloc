import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/blocs/client_bloc.dart';
import 'package:flutter_bloc/blocs/client_events.dart';
import 'package:flutter_bloc/blocs/client_state.dart';
import 'package:flutter_bloc/models/client.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPagStateState();
}

class _ClientsPagStateState extends State<ClientsPage> {
  // final clientList = [];

  late final ClientBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = ClientBloc();
    bloc.inputClient.add(LoadClientEvent());
  }

  @override
  void dispose() {
    bloc.inputClient.close();
    super.dispose();
  }

  String randomName() {
    final rand = Random();
    return ['Maria Almeida', 'Vinicius Silva', 'Luiz Williams', 'Bianca Alves']
        .elementAt(rand.nextInt(4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clients"),
        actions: [
          IconButton(
            onPressed: () {
              bloc.inputClient
                  .add(AddClientEvent(client: Client(name: randomName())));
            },
            icon: const Icon(Icons.person_add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: StreamBuilder<ClientState>(
            stream: bloc.stream,
            builder: (context, AsyncSnapshot<ClientState> snapshot) {
              final clientsList = snapshot.data?.clients ?? [];
              return ListView.separated(
                itemBuilder: (context, index) => ListTile(
                  leading: CircleAvatar(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Text(clientsList[index].name.substring(0, 1)),
                    ),
                  ),
                  title: Text(clientsList[index].name),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      bloc.inputClient
                          .add(RemoveClientEvent(client: clientsList[index]));
                    },
                  ),
                ),
                separatorBuilder: (_, __) => const Divider(),
                itemCount: clientsList.length,
              );
            }),
      ),
    );
  }
}
