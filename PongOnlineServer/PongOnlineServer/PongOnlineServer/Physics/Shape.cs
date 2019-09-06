using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Numerics;

namespace PongOnlineServer.Physics {
    abstract class Shape {

        public abstract bool Collides(Shape otherShape, Vector2 myPosition, Vector2 otherPosition);
    }
}
