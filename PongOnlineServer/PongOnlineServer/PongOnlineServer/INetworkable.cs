using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PongOnlineServer {
    interface INetworkable {

        byte[] Serialize();
        void Deserialize(byte[] data);
    }
}
