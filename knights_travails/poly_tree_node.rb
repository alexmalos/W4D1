class PolyTreeNode
    def initialize(value)
        @value = value
        @children = []
        @parent = nil
    end

    attr_reader :value, :parent, :children

    def parent=(parent_instance)
        if @parent != nil
            @parent.children.delete(self) 
        end
        @parent = parent_instance
        @parent.children << self  unless @parent==nil
    end

    # def inspect
    #     @children
    # end

    def add_child(child_node)
        child_node.parent=self
    end

    def remove_child(child_node)
        raise "this is a parent" if child_node.parent == nil
        child_node.parent = nil
    end

    def dfs(target_value)
        return self if @value == target_value
        @children.each do |child|
            child_dfs = child.dfs(target_value)
            return child_dfs unless child_dfs == nil
        end
        nil
    end

    def bfs(target_value)
        arr=[self]
        while arr.length !=0
            if arr[0].value == target_value
                return arr[0]
            else
                arr+=arr[0].children
                arr.shift         
            end
        end
    end
end