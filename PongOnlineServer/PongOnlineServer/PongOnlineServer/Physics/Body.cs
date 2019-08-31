using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Numerics;

namespace PongOnlineServer.Physics {
    class Body {
        private Vector2 _position;
        public Vector2 Position { get => this._position; }

        private Vector2 _velocity;
        public Vector2 Velocity { get => this._velocity; }

        private Shape _shape;
        public Shape Shape { get => this._shape; }

        public void Update() {
            this._position += this._velocity;
        }

        public bool Collides(Body otherBody) {
            return 
        }
    }
}
