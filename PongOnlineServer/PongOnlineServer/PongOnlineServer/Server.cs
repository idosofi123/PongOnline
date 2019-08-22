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
            Console.WriteLine(String.Format("[ {0} ] - Server is running!", System.DateTime.UtcNow));
            Console.WriteLine(String.Format("[ {0} ] - Waiting for coming connections...", System.DateTime.UtcNow));
            while (this._isRunning) {
                if (this._listener.Pending()) {
                    Task newConnTask = this.HandleNewConnection();
                }
            }
        }

        private Task HandleNewConnection() {
            return Task.Run(() => {
                TcpClient newClient = this._listener.AcceptTcpClient();
                this._connectedClients.Add(newClient);
                Console.WriteLine(String.Format("[ {0} ] - New connection from: " + newClient.Client.RemoteEndPoint.ToString(), System.DateTime.UtcNow));
            });
        }

        static private Server instance;

        public static void InitializeServer() {
            ENet.Library.Initialize();
            instance = new Server();
            instance.Start();
        }
    }
}
