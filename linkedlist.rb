
class LinkedList
  attr_accessor :head_node

  def append(node)
    node = make_node(node)
    if @head_node
      @head_node.get_tail_node.next_node = node
    else
      @head_node = node
    end
  end

  def prepend(node)
    node = make_node(node)
    if @head_node
      node.next_node = @head_node
      @head_node = node
    else
      @head_node = node
    end
  end

  def size
    @head_node.count
  end

  def head
    @head_node
  end

  def tail
    @head_node ? @head_node.get_tail_node : nil
  end

  def at(index)
    @head_node ? @head_node.at(index) : nil
  end

  def pop
    unless @head_node then return nil end
    if @head_node.next_node
      @head_node.get_penultimate_node.remove_instance_variable(:@next_node)
    else
      remove_instance_variable(:@head_node)
    end

  end

  def contains?(value)
    find(value) != nil
  end

  def find(data)
    @head_node ? @head_node.find(data, 0) : nil
  end

  def to_s
    @head_node ? @head_node.to_s : "() -> nil"
  end

  def insert_at(object, index)
    node = make_node(object)
    if index <= 0
      node.next_node = @head_node
      @head_node = node
    else
      @head_node ? @head_node.insert_at(node,index) : nil
    end
  end

  def remove_at(index)
    if index <= 0
      if @head_node
        @head_node, return_value = @head_node.next_node, @head_node
        return_value.value
      else
        nil
      end
    else
      @head_node ? @head_node.remove_at(index) : nil
    end

  end

  private
  def make_node(object)
   node = (object.is_a? Node) ? object : Node.new(object)
   node.next_node = nil
   node
  end

end

class Node
  attr_accessor :value, :next_node
  def initialize(value=nil, next_node=nil)
    @value = value
    @next_node = next_node
  end

  def get_tail_node
    @next_node ? @next_node.get_tail_node : self
  end

  def count
    @next_node ? @next_node.count + 1 : 1
  end

  def get_penultimate_node
    @next_node.next_node ? @next_node.get_penultimate_node : self
  end


  def at(index)
    if index == 0
       self
    else
      @next_node ?  @next_node.at(index - 1) : nil
    end
  end

  def find(data,counter)
    if data == @value
      counter
    else
        @next_node ? @next_node.find(data, counter+1) : nil
    end

  end

  def to_s
    "(#{value}) -> " + (@next_node ? @next_node.to_s : "nil")
  end

  def insert_at(node,index)

    if index == 1
      node.next_node = @next_node
      @next_node = node
    elsif @next_node == nil
      return nil
    else
      @next_node.insert_at(node, index - 1)
    end
  end

  def remove_at(index)

    if @next_node == nil
      return nil
    elsif index == 1
      @next_node, return_value = @next_node.next_node, @next_node
      return_value.value
    else
      @next_node.remove_at( index - 1)
    end
  end

end
