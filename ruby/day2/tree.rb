# Implement a Tree class where the initializer accepts
# a nested structure of hash. You should be able to
# specify a tree like this:
# {
#   'grandpa' => {
#     'dad' => {
#       'child 1' => {},
#       'child 2' => {},
#     },
#     'uncle' => {
#       'child 3' => {},
#       'child 4' => {},
#     }
#   }
# }

class Tree < Struct.new :name, :children
  # Create a list of Tree instances from a Hash,
  # where the key is the name and the value is a Hash.
  def self.from_hash(hash)
    hash.each_pair.map do |name, children|
      new_with_hash(name, children)
    end
  end

  # Create a single Tree instance with a given name
  # whose children are built from the given Hash instance.
  def self.new_with_hash(name, children)
    new(name, from_hash(children))
  end

  def visit(&block)
    visit_node(&block)
    visit_children(&block)
  end

  def visit_node(&block)
    block.call(self)
  end

  def visit_children(&block)
    children.each do |child|
      child.visit(&block)
    end
  end
end

require 'test/unit'
class TreeTest < Test::Unit::TestCase
  def setup
    @items = items = []
    @block = proc { |n| items.push(n.name) }
    @hash = {
      'one' => {
        '1a' => {'1a-I' => {}, '1a-II' => {}},
        '1b' => {},
      },
      'two' => {
        '2a' => {},
      }
    }
  end

  def test_tree_visits_self
    Tree.new_with_hash('tree', @hash).visit(&@block)
    assert_equal %W{tree one 1a 1a-I 1a-II 1b two 2a}, @items
  end
end
