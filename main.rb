require_relative "tree"
require_relative "node"

test_array = Array.new(15) { rand(1..100) }

tree = Tree.new(test_array)

tree.pretty_print

puts "Balanced?"
puts tree.balanced?

puts "\nBreadth-first-search\n> Level order:"
print "#{tree.level_order}\n> Level order recursive: #{tree.level_order_rec}\n"

print "Depth-first-search\n> Preorder:\n#{tree.preorder}\n> Inorder:\n#{tree.inorder}\n> Postorder:\n #{tree.postorder}\n"

puts "~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~ ~\n L e t 's   u n b a l a n c e  t h e  t r e e  i n s e r t i n g  n e w  v a l u e s."
Array.new(15) { rand(100..1250) }.each{ |number| tree.insert(number) }
tree.pretty_print

puts "Balanced?"
puts tree.balanced?

puts "Now apply magic rebalance spells :D"
puts "Balanced?"
tree.rebalance
puts tree.balanced?

tree.pretty_print

puts "\nBreadth-first-search\n> Level order:"
print "#{tree.level_order}\n> Level order recursive: #{tree.level_order_rec}\n"

print "Depth-first-search\n> Preorder:\n#{tree.preorder}\n> Inorder:\n#{tree.inorder}\n> Postorder:\n #{tree.postorder}\n"

puts tree.height(tree.root)