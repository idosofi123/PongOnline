using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace PongOnlineServer
{
    class Match {

        public const int NUMBER_OF_PLAYERS = 2;

        private Task _gameTask;
        public Task GameTask { get => this._gameTask; }

        private Player _playerA, _playerB;

        public Match(List) {

        }

        public void StartGame() {
            this._gameTask = Game();
        }

        private Task Game() {
            return Task.Run(() => {

            });
        }
    }
}
