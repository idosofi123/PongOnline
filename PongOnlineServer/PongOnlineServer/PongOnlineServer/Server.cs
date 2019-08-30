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

        private const int PORT              = 17420;
        private const int SERVER_LOOP_DELAY = 10;

        private Dictionary<EndPoint, TcpClient> _connectedClients;
        private List<TcpClient>                 _newClients;
        private Queue<EndPoint>                 _matchmakingQueue;
        private List<Match>                     _liveMatches;
        private TcpListener                     _listener;
        private bool                            _isRunning;

        private Server() {
            this._connectedClients = new Dictionary<EndPoint, TcpClient>();
            this._newClients = new List<TcpClient>();
            this._matchmakingQueue = new Queue<EndPoint>();
            this._liveMatches = new List<Match>();
            this._listener = new TcpListener(IPAddress.Any, PORT);
        }

        private void Start() {
            this._isRunning = true;
            this._listener.Start();
            PrintTimestampMessage("Server is running!");
            PrintTimestampMessage("Waiting for coming connections...");
            List<Task> tasks = new List<Task>();
            tasks.Add(this.HandleNewConnections());
            tasks.Add(this.MatchMaking());
            tasks.Add(this.HandleOngoingConnections());
            Task.WaitAll(tasks.ToArray());
        }

        private Task HandleOngoingConnections() {
            return Task.Run(() => {
                while (this._isRunning) {
                    this.IncludeNewClients();
                    if (this._connectedClients.Count > 0) {
                        foreach (TcpClient client in this._connectedClients.Values) {
                            this.ReceiveAndHandlePacket(client);
                        }
                    }
                    Thread.Sleep(SERVER_LOOP_DELAY);
                }
            });
        }

        private Task HandleNewConnections() {
            return Task.Run(() => {
                while (this._isRunning) {
                    TcpClient newClient = this._listener.AcceptTcpClient();
                    this._newClients.Add(newClient);
                    PrintTimestampMessage("New connection from: " + newClient.Client.RemoteEndPoint.ToString());
                    Thread.Sleep(SERVER_LOOP_DELAY);
                }
            });
        }

        private void IncludeNewClients() {
            if (this._newClients.Count == 0) {
                return;
            }
            foreach (TcpClient client in this._newClients) {
                this._connectedClients.Add(client.Client.RemoteEndPoint, client);
            }
            this._newClients.Clear();
        }

        private async Task ReceiveAndHandlePacket(TcpClient client) {
            if (client.Available > 0) {
                NetworkStream stream = client.GetStream();
                byte[] receivedData = new byte[1];
                await stream.ReadAsync(receivedData, 0, 1);
                Packet receivedPacket = new Packet(receivedData);
                switch (receivedPacket.Command) {
                    case Command.EnterGame:
                        this.addToMatchMaking(client);
                        break;
                    case Command.Disconnect:
                        break;
                    default:
                        break;
                }
            }
        }

        private void addToMatchMaking(TcpClient client) {
            if (!this._matchmakingQueue.Contains(client.Client.RemoteEndPoint)) {
                this._matchmakingQueue.Enqueue(client.Client.RemoteEndPoint);
                PrintTimestampMessage(client.Client.RemoteEndPoint.ToString() + " has entered matchmaking.");
            }
        }

        private Task MatchMaking() {
            return Task.Run(() => {
                while (this._isRunning) {
                    if (this._matchmakingQueue.Count >=  Match.NUMBER_OF_PLAYERS) {
                        List<TcpClient> clientsOfNewGame = new List<TcpClient>();
                        byte[] packetData = { Packet.GeneratePacketByteData(new Packet(Command.EnterGame, Props.Success)) };
                        for (int i = 0; i < Match.NUMBER_OF_PLAYERS; i++) {
                            EndPoint endPoint = this._matchmakingQueue.Dequeue();
                            NetworkStream streamOfClient = this._connectedClients[endPoint].GetStream();
                            streamOfClient.Write(packetData, 0, 1);
                            clientsOfNewGame.Add(this._connectedClients[endPoint]);
                        }

                        // TODO: Make a new eNet match out of these clients.

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

            // Handle the CTRL+C event - deinitialize the server and end the process.
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
