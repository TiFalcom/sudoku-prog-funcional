import random

def generate_sudoku():
    base = 3
    side = base * base

    # Pattern for a baseline valid solution
    def pattern(r, c): 
        return (base * (r % base) + r // base + c) % side

    # Randomize rows, columns and numbers (of valid base pattern)
    def shuffle(s): 
        return random.sample(s, len(s)) 

    r_base = range(base)

    rows  = [[g * base + r, [g, r]] for g in shuffle(r_base) for r in shuffle(r_base)] 
    cols  = [[g * base + c, [g, c]] for g in shuffle(r_base) for c in shuffle(r_base)]

    print(rows)
    #print(shuffle(r_base))
    nums  = shuffle(range(1, base * base + 1))
    print(nums)
    #rows = [7,6,8,3,4,2,0,1,5]
    # Produce board using randomized baseline pattern
    board = [[nums[pattern(r, c)] for c in cols] for r in rows]
    board2 = [[pattern(r, c) for c in rows] for r in rows]

    # Remove numbers to make it a proper Sudoku puzzle
    #squares = side * side
    #empties = squares * 3 // 4
    #for p in random.sample(range(squares), empties):
    #    board[p // side][p % side] = 0

    return board

def print_sudoku(board):
    for row in board:
        print(" ".join(f"{num or '.':2}" for num in row))

def is_valid_sudoku(board):
    def is_valid_block(block):
        block = [num for num in block if num != 0]
        return len(block) == len(set(block))

    def get_block(board, start_row, start_col):
        return [board[r][c] for r in range(start_row, start_row + 3) for c in range(start_col, start_col + 3)]

    for i in range(9):
        row = board[i]
        column = [board[r][i] for r in range(9)]
        if not is_valid_block(row) or not is_valid_block(column):
            return False

    for i in range(0, 9, 3):
        for j in range(0, 9, 3):
            block = get_block(board, i, j)
            if not is_valid_block(block):
                return False

    return True


print_sudoku(generate_sudoku())
#for i in range(100000):
#    sudoku_board = generate_sudoku()
#    #print_sudoku(sudoku_board)
#    if not is_valid_sudoku(sudoku_board):
#        print('deu merda')
