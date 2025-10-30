import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/invitations/invitations_bloc.dart';
import '../widgets/invitation_item.dart';

class InvitationsPage extends StatelessWidget {
  const InvitationsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => InvitationsBloc()..add(LoadInvitations()),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Invitation",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).primaryColor, // App color
                    foregroundColor: Colors.white, // text/icon color
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 0, // keep flat like appbar
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("New Invitation tapped")),
                    );
                  },
                  child: const Text(
                    "Neharew Invitation",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: BlocBuilder<InvitationsBloc, InvitationsState>(
            builder: (context, state) {
              if (state is InvitationsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is InvitationsLoaded) {
                if (state.invitations.isEmpty) {
                  return const Center(child: Text("No invitations found"));
                }
                return ListView.builder(
                  itemCount: state.invitations.length,
                  itemBuilder: (context, index) =>
                      InvitationItem(invitation: state.invitations[index]),
                );
              } else if (state is InvitationsError) {
                return Center(child: Text(state.message));
              }
              return const SizedBox();
            },
          ),
        ),
      );
}
