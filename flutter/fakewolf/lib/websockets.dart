import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/html.dart';

///
/// Application-level global variable to access the WebSockets
///
WebSocketsNotifications sockets = new WebSocketsNotifications();

///
/// Put your WebSockets server IP address and port number
///
const String _SERVER_ADDRESS = "ws://78.47.150.51:6789";//"ws://192.168.1.45:34263"; //TODO: Add real IP and port

class WebSocketsNotifications {
	static final WebSocketsNotifications _sockets = new WebSocketsNotifications._internal();

	factory WebSocketsNotifications(){
		return _sockets;
	}

	WebSocketsNotifications._internal();

	///
	/// The WebSocket "open" channel
	///
	HtmlWebSocketChannel _channel;

	///
	/// Is the connection established?
	///
	bool _isOn = false;

	///
	/// Listeners
	/// List of methods to be called when a new message
	/// comes in.
	///
	ObserverList<Function> _listeners = new ObserverList<Function>();

	/// ----------------------------------------------------------
	/// Initializing the WebSockets connection with the server
	/// ----------------------------------------------------------
	initCommunication() async {
		///
		/// Just in case, close any previous communication
		///
		reset();

		///
		/// Open a new WebSocket communication
		///
		try {
			_channel = HtmlWebSocketChannel.connect(_SERVER_ADDRESS);

			///
			/// Start listening to new notifications / messages
			///
			_channel.stream.listen(_onReceptionOfMessageFromServer);
			_isOn = true;
			print("Successfully initialized channel");
		} catch(e){
			///
			/// General error handling
			/// TODO
			///
			print("Error while initialising socket!");
		}
	}

	/// ----------------------------------------------------------
	/// Closes the WebSocket communication
	/// ----------------------------------------------------------
	reset(){
		if (_channel != null){
			if (_channel.sink != null){
				_channel.sink.close();
				_channel = null;
				_isOn = false;
			}
		}
		print("Reset channel");
	}

	/// ---------------------------------------------------------
	/// Sends a message to the server
	/// ---------------------------------------------------------
	send(String message){
		if (_channel != null){
			if (_channel.sink != null && _isOn){
				_channel.sink.add(message);
				print("Sent message:   " + message);
			}
		}
	}

	/// ---------------------------------------------------------
	/// Adds a callback to be invoked in case of incoming
	/// notification
	/// ---------------------------------------------------------
	addListener(Function callback){
		_listeners.add(callback);
	}
	removeListener(Function callback){
		_listeners.remove(callback);
	}

	/// ----------------------------------------------------------
	/// Callback which is invoked each time that we are receiving
	/// a message from the server
	/// ----------------------------------------------------------
	_onReceptionOfMessageFromServer(message){
		_listeners.forEach((Function callback){
			callback(message);
		});
	}
}