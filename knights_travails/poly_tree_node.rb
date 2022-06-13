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

    def add_child(child_node)
        child_node.parent=self
    end
end