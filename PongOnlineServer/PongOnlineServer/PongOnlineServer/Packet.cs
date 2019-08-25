using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PongOnlineServer {

    public enum Command { EnterGame, Disconnect, Move };

    class Packet {
        private Command _command;

        public Command Command {
            get { return this._command; }
        }

        public Packet(byte[] streamData) {

        }
    }
}
