import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:peerdart/peerdart.dart';

class PeerConnectionViewModel extends ChangeNotifier with WidgetsBindingObserver {
  Peer? _peer; // Made nullable to handle dispose/reconnect
  DataConnection? _connection; // Made nullable

  String? _peerId;
  String? get peerId => _peerId;

  bool _isConnected = false;
  bool get isConnected => _isConnected;

  final TextEditingController remotePeerIdController = TextEditingController();
  final List<String> _messages = []; // To display messages in the UI
  List<String> get messages => _messages;
  String? userImageUrl;
  String? peerImageUrl;

  PeerConnectionViewModel() {
    _initializePeer();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    
    if(_isConnected && _connection != null) {
      if(state == AppLifecycleState.paused) {
        _connection!.send("offline");
      } else if (state == AppLifecycleState.resumed) {
        _connection!.send("online");
      }
    }
  }

  // Initializes the PeerJS client
  void _initializePeer() {
    // Ensure previous peer is disposed if re-initializing
    _peer?.dispose();
    _peer = Peer(options: PeerOptions(debug: LogLevel.All));

    _peer!.on("open").listen((id) {
      _peerId = id;
      developer.log('My Peer ID: $_peerId');
      notifyListeners(); // Update UI with new Peer ID
    });

    _peer!.on("close").listen((_) {
      _isConnected = false;
      _peerId = null; // Clear peer ID on close
      _connection = null;
      peerImageUrl = null;
      _addMessage("Peer closed.");
      notifyListeners(); // Update UI on disconnection
    });

    _peer!.on("error").listen((err) {
      developer.log('Peer Error: ${err.message}', error: err);
      _addMessage('Peer Error: ${err.message}');
      notifyListeners(); // Update UI with error message
    });

    _peer!.on("connection").listen((event) {
      developer.log('Incoming connection from: ${event.peer}');
      _connection = event as DataConnection;
      _setupDataConnectionListeners(_connection!);
      _isConnected = true;
      _addMessage("Connected to: ${event.peer}");
      notifyListeners(); // Update UI on new connection
    });
  }

    // Sets up listeners for a DataConnection
  void _setupDataConnectionListeners(DataConnection conn) {
    conn.on("open").listen((_) {
      developer.log('DataConnection opened with ${conn.peer}');
      _isConnected = true;
      _addMessage("Data connection opened with ${conn.peer}");

      // send image url to the peer
      conn.send(userImageUrl ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/11.gif");

      notifyListeners();
    });

    conn.on("data").listen((data) {
      developer.log('Received data: $data from ${conn.peer}');
      // make sure data is string
      if(data is String) {
        if(data.toString().compareTo("offline") == 0) {
          peerImageUrl = getBackImageUrl(peerImageUrl!);
        } else if(data.toString().compareTo("online") == 0){
          peerImageUrl = peerImageUrl?.replaceAll("/back", "");
        } else {
          peerImageUrl = data;
        }
      }
      _addMessage("Friend: $data");
      notifyListeners();
    });

    conn.on("close").listen((_) {
      developer.log('DataConnection closed with ${conn.peer}');
      _isConnected = false;
      _connection = null;
      _addMessage("Data connection closed with ${conn.peer}");
      peerImageUrl = null;
      notifyListeners();
    });

    conn.on("error").listen((err) {
      developer.log('DataConnection Error: $err', error: err);
      _addMessage('Connection Error with ${conn.peer}: ${err.message}');
      _isConnected = false;
      _connection = null;
      notifyListeners();
    });
  }

  // Connects to a remote peer
  void connect() {
    final remotePeerId = remotePeerIdController.text.trim();
    if (remotePeerId.isEmpty || _peer == null || _peerId == null) {
      _addMessage('Please enter a valid remote Peer ID and ensure your Peer is initialized.');
      return;
    }
    if (_isConnected) {
      _addMessage('Already connected to a peer.');
      return;
    }

    developer.log('Attempting to connect to: $remotePeerId');
    _addMessage('Attempting to connect to: $remotePeerId');
    _connection = _peer!.connect(remotePeerId);
    _setupDataConnectionListeners(_connection!);
  }

  // Closes the current peer connection
  void closeConnection() {
    if (_peer != null) {
      _peer!.dispose();
      _peer = null; // Set to null after disposing
      _isConnected = false;
      _connection = null;
      _peerId = null; // Clear peer ID
      peerImageUrl = null;
      reconnect();
      _addMessage("Connection closed and Peer disposed.");
      notifyListeners();
    } else {
      _addMessage("No active peer to close.");
    }
  }

  // Reconnects by initializing a new Peer
  void reconnect() {
    _addMessage("Attempting to re-initialize Peer...");
    _initializePeer(); // This will create a new Peer and get a new ID
    notifyListeners();
  }

  // Helper to add messages to the list and notify listeners
  void _addMessage(String message) {
    _messages.add(message);
    // Limit messages to avoid excessive memory usage for long sessions
    if (_messages.length > 50) {
      _messages.removeAt(0);
    }
    notifyListeners();
  }

  @override
  void dispose() {
    _peer?.dispose();
    remotePeerIdController.dispose();
    super.dispose();
  }

  String? getBackImageUrl(String imageUrl) {
    List<String> splittedImageUrl = imageUrl.split("/");
    int imageUrlArraySize = splittedImageUrl.length;

    // add /back to the imageUrl to get the back sprite
    splittedImageUrl.insert(imageUrlArraySize - 1, "back");

    return splittedImageUrl.join("/");
  }
}