﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Threading;
using System.Net;
using System.Net.Sockets;

namespace PongOnlineServer {

    class Server {

        private const int PORT              = 17420;
        private const int SERVER_LOOP_DELAY = 10;

        private Dictionary<EndPoint, TcpClient> _connectedClients;
        private Queue<EndPoint>                 _matchmakingQueue;
        private List<Match>                     _liveMatches;
        private TcpListener                     _listener;
        private bool                            _isRunning;

        private Server() {
            this._connectedClients = new Dictionary<EndPoint, TcpClient>();
            this._matchmakingQueue = new Queue<EndPoint>();
            this._liveMatches = new List<Match>();
            this._listener = new TcpListener(IPAddress.Any, PORT);
        }

        private void Start() {
            this._isRunning = true;
            this._listener.Start();
            List<Task> clientHandlingTasks = new List<Task>();
            PrintTimestampMessage("Server is running!");
            PrintTimestampMessage("Waiting for coming connections...");
            this.MatchMaking();
            while (this._isRunning) {
                if (this._listener.Pending()) {
                    Task newConnTask = this.HandleNewConnection();
                }
                
                // Handle ongoing connections
                foreach (TcpClient client in this._connectedClients.Values) {
                    clientHandlingTasks.Add(this.ReceiveAndHandlePacket(client));
                }

                // Prevent CPU killing
                Thread.Sleep(SERVER_LOOP_DELAY);
            }
        }

        private Task HandleNewConnection() {
            return Task.Run(() => {
                TcpClient newClient = this._listener.AcceptTcpClient();
                this._connectedClients.Add(newClient.Client.RemoteEndPoint, newClient);
                PrintTimestampMessage("New connection from: " + newClient.Client.RemoteEndPoint.ToString());
            });
        }

        private async Task ReceiveAndHandlePacket(TcpClient client) {
            if (client.Available > 0) {
                NetworkStream stream = client.GetStream();
                byte[] receivedData = new byte[1];
                await stream.ReadAsync(receivedData, 0, 1);
                Packet receivedPacket = new Packet(receivedData);
                switch (receivedPacket.Command) {
                    case Command.EnterGame:
                        this._matchmakingQueue.Enqueue(client.Client.RemoteEndPoint);
                        break;
                    case Command.Move:
                        break;
                    case Command.Disconnect:
                        break;
                    default:
                        break;
                }
            }
        }

        private Task MatchMaking() {
            return Task.Run(() => {
                while (this._isRunning) {
                    if (this._matchmakingQueue.Count >=  Match.NUMBER_OF_PLAYERS) {
                        List<TcpClient> clientsOfNewGame = new List<TcpClient>();
                        for (int i = 0; i < Match.NUMBER_OF_PLAYERS; i++) {
                            EndPoint endPoint = this._matchmakingQueue.Dequeue();
                            clientsOfNewGame.Add(this._connectedClients[endPoint]);
                        }
                        // TODO: Make a new match out of these clients.
                        PrintTimestampMessage("A game started!");
                    }
                    
                    Thread.Sleep(SERVER_LOOP_DELAY);
                }
            });
        }

        public void DeinitializeServer() {
            ENet.Library.Deinitialize();
            PrintTimestampMessage("Bye!");
        }

        static private Server instance;

        public static void InitializeServer() {
            ENet.Library.Initialize();
            instance = new Server();

            // Handle the CTRL+C event
            Console.CancelKeyPress += delegate {
                instance.DeinitializeServer();
            };

            instance.Start();
        }

        private static void PrintTimestampMessage(string msg) {
            Console.WriteLine(String.Format("[ {0} ] - {1}", System.DateTime.UtcNow, msg));
        }
    }
}
