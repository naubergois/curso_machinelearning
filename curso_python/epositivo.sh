import numpy as np


class TwentyFourtyEightGame(object):
    ACTION_UP = 0
    ACTION_RIGHT = 1
    ACTION_DOWN = 2
    ACTION_LEFT = 4

    def __init__(self, size=(4, 4), nb_initial_tiles=2, initial_tile_value=2):
        self.size = size  # size = (rows, columns)
        self.nb_initial_tiles = nb_initial_tiles
        self.initial_tile_value = initial_tile_value
        self.reset()

    def reset(self):
        self.board = np.zeros(self.size, dtype='int32')
        for _ in xrange(self.nb_initial_tiles):
            self.insert_tile(value=self.initial_tile_value)

    def insert_tile(self, value=2):
        if self.full_board:
            return False

        while True:
            i, j = np.random.randint(0, self.size[0]), np.random.randint(0, self.size[1])
            if self.board[i, j] == 0:
                break
        self.board[i, j] = value
        return True

    def act(self, action):
        # Rotate board. This makes handling the move and merge operation much easier since
        # it only needs to be implemented in one direction.
        if action == TwentyFourtyEightGame.ACTION_UP:
            k = 0
        elif action == TwentyFourtyEightGame.ACTION_RIGHT:
            k = 1
        elif action == TwentyFourtyEightGame.ACTION_DOWN:
            k = 2
        elif action == TwentyFourtyEightGame.ACTION_LEFT:
            k = 3
        else:
            raise ValueError()

        # Rotate board accordingly and perform move and merge actions until the state is stable.
        # After, the board is rotated back and a new tile is inserted.
        board = np.rot90(self.board, k=k)
        while True:
            self.move(board)
            if not self.merge(board):
                break
        self.board = np.rot90(board, k=-k)
        self.insert_tile()

    def move(self, board):
        did_move = False
        nb_rows, nb_columns = self.size
        for j in xrange(nb_columns):
            for i in xrange(nb_rows):
                if board[i, j] != 0:
                    # The board position is not empty, move on.
                    continue

                # Find index of next occupied row.
                partial_board = board[i:, j]
                occupied_idxs = np.where(partial_board != 0)[0]
                if len(occupied_idxs) == 0:
                    # We're done with this column, move on to the next.
                    break

                # Roll the relevant part of the board such that the first occupied tile
                # moves to index i.
                did_move = True
                board[i:, j] = np.roll(partial_board, -occupied_idxs[0])
                assert board[i, j] != 0
        return did_move

    def merge(self, board):
        did_merge = False
        nb_rows, nb_columns = self.size
        for j in xrange(nb_columns):
            for i in xrange(1, nb_rows):
                if board[i - 1, j] != 0 and board[i - 1, j] == board[i, j]:
                    board[i - 1, j] *= 2
                    board[i, j] = 0
                    did_merge = True
        return did_merge

    @property
    def game_over(self):
        return self.full_board

    @property
    def full_board(self):
        return 0 not in self.board
    
    def __str__(self):
        return str(self.board)


# import timeit
# import random
# game = TwentyFourtyEightGame(size=(4, 4))
# actions = [TwentyFourtyEightGame.ACTION_UP, TwentyFourtyEightGame.ACTION_LEFT, TwentyFourtyEightGame.ACTION_RIGHT, TwentyFourtyEightGame.ACTION_DOWN]
# start = timeit.default_timer()
# for _ in xrange(10000):
#   if game.game_over:
#       game.reset()
#   game.act(random.choice(actions))
# duration = timeit.default_timer() - start
# print('took {}s, {}fps'.format(duration, float(10000) / duration))
# exit()

if __name__ == '__main__':
    cmd_to_action = {
        'w': TwentyFourtyEightGame.ACTION_UP,
        'd': TwentyFourtyEightGame.ACTION_RIGHT,
        'a': TwentyFourtyEightGame.ACTION_LEFT,
        's': TwentyFourtyEightGame.ACTION_DOWN,
    }
    game = TwentyFourtyEightGame(size=(4, 4))
    while not game.game_over:
        print game
        cmd = raw_input()
        if cmd not in cmd_to_action:
            print('invalid command, use w = UP, d = RIGHT, s = DOWN or a = LEFT')
            continue
        game.act(cmd_to_action[cmd])
