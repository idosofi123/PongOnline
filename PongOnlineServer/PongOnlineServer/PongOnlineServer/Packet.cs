using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PongOnlineServer {

    public enum Command { EnterGame, Disconnect, Move };
    public enum Props { Null, Up, Down };

    class Packet {
        private Command _command;

        public Command Command {
            get { return this._command; }
        }

        private Props _props;
        public Props Props {
            get { return this._props; }
        }

        public Packet(byte[] streamData) {
            // (Lua-socket treats the hexadecimal value that is being sent as a char value, so we re-convert it to the numeric value).
            byte packetData = (byte)(streamData[0] - '0');

            int commandIndex = packetData >> 4;
            this._command = (Command)Enum.GetValues(Command.GetType()).GetValue(commandIndex);
            int propsIndex = packetData & 0x0F;
            this._props = (Props)Enum.GetValues(Props.GetType()).GetValue(propsIndex);
        }
    }
}
