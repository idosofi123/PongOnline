using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PongOnlineServer
{
    public class Program
    {
        public static void Main(string[] args)
        {
            System.Console.WriteLine("PROJECT M.T.O.I - Pong Online Server v0.1");
            ENet.Library.Initialize();
            ENet.Library.Deinitialize();
        }
    }
}
