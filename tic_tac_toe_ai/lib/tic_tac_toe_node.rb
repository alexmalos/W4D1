require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board=board
    @next_mover_mark=next_mover_mark
    @prev_move_pos=prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      @board.winner == evaluator || @board.winner == nil ? false : true
    else
      if @next_mover_mark == evaluator
        children.all? { |child| child.losing_node?(evaluator) }
      else
        children.any? { |child| child.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      @board.winner == evaluator ? true : false
    else
      if @next_mover_mark == evaluator
        children.any? { |child| child.winning_node?(evaluator) }
      else
        children.all? { |child| child.winning_node?(evaluator) }
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    children = []

    (0...3).each do |i|
      (0...3).each do |j|
        pos = [i, j]
        if @board.empty?(pos)
          next_board = @board.dup
          next_board[pos] = @next_mover_mark
          next_mark = nil

          if @next_mover_mark == :x
            next_mark = :o
          else
            next_mark = :x
          end

          children << self.class.new(next_board, next_mark, pos)
        end
      end
    end

    children
  end
end
