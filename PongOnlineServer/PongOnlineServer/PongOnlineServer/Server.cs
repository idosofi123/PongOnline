using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Net;
using System.Net.Sockets;

namespace PongOnlineServer {

    class Server {

        private const int PORT = 17420;

        private List<TcpClient> _connectedClients;
        private List<Match> _liveMatches;
        private TcpListener _listener;
        private bool _isRunning;

        private Server() {
            this._connectedClients = new List<TcpClient>();
            this._liveMatches = new List<Match>();
            this._listener = new TcpListener(IPAddress.Any, PORT);
        }

        private void Start() {
            this._isRunning = true;
            this._listener.Start();
            while (this._isRunning) {
                if (this._listener.Pending()) {
                    this.HandleNewConnection();
                }
            }
        }

        private async void HandleNewConnection() {
            TcpClient newClient = this._listener.AcceptTcpClient();
            this._connectedClients.Add(newClient);
        }

        static private Server instance;

        public static void InitializeServer() {
            ENet.Library.Initialize();
            instance = new Server();
            instance.Start();
        }
    }
}
