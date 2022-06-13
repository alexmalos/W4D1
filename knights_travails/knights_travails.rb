require_relative 'poly_tree_node'

class KnightPathFinder
    OPS = [[1,2], [1,-2], [-1,2], [-1,-2], [2,1], [2,-1], [-2,1], [-2,-1]]

    def self.valid_moves(pos)
        moves = OPS.map { |op| [pos[0] + op[0], pos[1] + op[1]] }
        moves.select { |move| move.all? { |i| i >= 0 && i < 8 } }
    end

    def initialize(pos)
        @root_node = PolyTreeNode.new(pos)
        @considered_positions = [pos]
    end

    def new_move_positions(pos)
        moves = KnightPathFinder.valid_moves(pos).reject do |move|
            @considered_positions.include?(move)
        end
        @considered_positions += moves
        moves
    end

    def build_move_tree
        queue= [@root_node]

        until queue.empty?
            start_node=queue.shift
            nodes = new_move_positions(start_node.value).map do |ele|
                PolyTreeNode.new(ele)
            end
            nodes.each do |node|
                node.parent = start_node
                start_node.add_child(node)
            end
            queue += nodes
        end
    end

    def find_path(end_pos)
        queue= [@root_node]

        until queue.empty?
            return end_pos if end_pos== @root_node.value
            start_node=queue.shift
            
            start_node.children.each do |child|
                if child.value == end_pos
                    return trace_path_back(child)
                else
                    queue << child
                end
            end
        end
    end

    def trace_path_back(node)
        family_tree=[]

        until node.parent==nil
            family_tree << node.value 
            node = node.parent
        end
        
        [@root_node.value] + family_tree.reverse
    end
end
