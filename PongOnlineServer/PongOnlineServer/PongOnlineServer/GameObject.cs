using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using PongOnlineServer.Physics;

namespace PongOnlineServer
{
    abstract class GameObject : INetworkable {

        private Body _body;
        protected Body Body { get => this._body; }

        public void Update() {
            this._body.Update();
        }

        public abstract void Deserialize(byte[] data);

        public abstract byte[] Serialize();

    }
}
