import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';

class PeerConnection extends StatelessWidget {
  const PeerConnection({super.key});

  Widget _buildConnectionState(BuildContext context, bool isConnected) {
    Color bgColor = isConnected ? Colors.green : Colors.grey;
    Color txtColor = Colors.white;
    String txt = isConnected ? "Connected" : "Standby";
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      margin: const EdgeInsets.only(bottom: 16),
      child: Text(
        txt,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: txtColor),
      ),
    );
  }

  Widget _buildPeerId(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Your Peer ID:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Consumer<PeerConnectionViewModel>(
          builder: (context, vm, child) {
            return SelectableText(
              vm.peerId ?? "Loading...",
              style: const TextStyle(fontSize: 18, color: Colors.blue),
            );
          },
        ),
      ],
    );
  }

  Widget _buildRemotePeerIdField(BuildContext context, PeerConnectionViewModel peerConnectionVM) {
    return TextField(
      controller: peerConnectionVM.remotePeerIdController,
      decoration: InputDecoration(
        labelText: 'Friend\'s Peer ID',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }

  Widget _buildConnectButton(PeerConnectionViewModel peerConnectionVM) {
    return ElevatedButton(
      onPressed: () {
        peerConnectionVM.connect();
      },
      child: const Text("Connect"),
    );
  }

  Widget _buildCloseConnectionButton(PeerConnectionViewModel peerConnectionVM) {
    return ElevatedButton(
      onPressed: peerConnectionVM.isConnected ? peerConnectionVM.closeConnection : null,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      child: const Text("Close connection"),
    );
  }

  Widget _buildMessagesList(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: const EdgeInsets.all(12.0),
      height: 200,
      child: Consumer<PeerConnectionViewModel>(
        builder: (context, vm, child) {
          return ListView.builder(
            itemCount: vm.messages.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(vm.messages[index]),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final peerConnectionVM = context.watch<PeerConnectionViewModel>();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Consumer<PeerConnectionViewModel>(
              builder: (context, vm, child) {
                return _buildConnectionState(context, vm.isConnected);
              },
            ),
            _buildPeerId(context),
            const SizedBox(height: 8),
            _buildRemotePeerIdField(context, peerConnectionVM),
            const SizedBox(height: 12),
            _buildConnectButton(peerConnectionVM),
            const SizedBox(height: 8),
            _buildCloseConnectionButton(peerConnectionVM),
            const SizedBox(height: 12),
            _buildMessagesList(context),
            const SizedBox(height: 12),
          ],
        ),
      )
    );
  }
}