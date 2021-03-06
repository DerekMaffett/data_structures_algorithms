# Description

This is a repository for various sorting algorithms and data structures - it
has a fair amount of overlap with my Projects Euler repo as it supplies the
same practice

# Usage

Clone the repo and go to work improving the algorithms! This is heavily meant
for practice, so feel free to use it for that purpose.

# Insertion Sort

My solution iterates through the array and for each item, it holds it separately
and compares the held value backwards through the array until it finds a
place where it is no longer equal to or greater than the previous item. Note
that this is just a slight modification of using a swapping method where two
elements are swapped until it's in order - in this case, elements are only moved
forwards, and the element being placed is simply removed from the flow and
compared with other elements until it's placed correctly in one move, as
opposed to a swap which moves the element being placed each time.

# Merge Sort

This sorting algorithm recursively calls the merge_sort method on its own
subarrays (split to equal half each of the array merge_sort is called on) until
the arrays reach a size of one. Once that boundary condition is reached,
merge_sort can start returning up the call chain and reach the merge method
which unites the left and right arrays at each level by calling shift on the
array with the lowest initial element and adding that shifted value to a
new array. Thus, it takes advantage of the individually sorted subarrays to
quickly merge them together, still sorted. Finally, when one subarray is empty,
it simply adds the other array on.

# Quicksort

This sorting algorithm is also recursive. The recursive quicksort method
returns itself immediately if the array is of size 0 or 1 (both of these
scenarios are possible when picking a random pivot), and in all other
situations runs the pivot_split method. This method selects a random element,
deletes it out of the array while holding its value, and then compares each
element of the array with itself, sending low values to populate the left of the
array while leaving greater values in place. After n-1 comparisons, all the
numbers have been split between values higher and lower than the pivot, and the
store_index value marks the appropriate location for the pivot to be reinserted.
The method then reinserts the pivot at the correct place and returns itself.
After this, the subarrays below and ahead of the pivot (but not including the
pivot!) are quicksorted, until everything is broken down to arrays of size 1 or
0.

# Radix sort

For my first implementation, I used an MSD recursive radix sort. The first step
was to designate the algorithm as a proc which would be called within a
sandwich code framework initially and recursively outside of the sandwich code.
The sandwich code simply turns the array initially into reversed strings, and
afterwards returns it to its original format. The algorithm itself simply sorts
each of the reversed numbers into buckets based on initially the MSD, then
decrementing for each subsequent recursion. Radix sort is called on each
bucket that contains more than a single number, until it finally sorts
by the ones place. Then all the buckets are collapsed back together up the call
chain in sorted order.

It's worth noting that the code for this algorithm is considerably more complex
than the more basic LSD implementation - the sort can be run either way, though
MSD is required for recursion.

# Data Structures

# Singly linked list

I declared the Node class as being a Struct with parameters :value and :nexxt.
Thus, each node has its own value as well as a reference to the next node in the
list.

To implement the actual list, I made a list class which tracks both the head of
the list and the size of it. It is set up so that you can quickly construct a
new list by passing in a list of values. For example:

```
SinglyLinkedList.new(1, 2, 'string', my_object)
```

This would add each item as a node in the arguments' order.

Since searching and removing share many concerns, I implemented these functions
to share the same basic search functionality. This is the node_before method,
which searches for a particular node by always looking ahead of itself. While
this would be simpler to implement in a search by simply looking at each item
as the pointer comes to it, it would then be unusable for the remove function,
which needs to find the item *before* the pointer reaches it. Using the
node_before search for each one allowed leaving the search and remove functions
to only deal with the edge cases.

In order to make a good to_s conversion, I had to declare both an each function
for singly linked lists and an adapter function for Nodes which can be easily
added to for changing string formats.

# Stack

A stack, as pointed out by Philip Nguyen, can be easily implemented off of a
singly linked list by simply adding and removing from the head of the list. I
implemented this by inheriting Stack from SinglyLinkedList and making
convenience methods which removed reference to nodes and gave an interface
friendly for interfacing with a stack. However, the search and remove methods
still exist in case they are desired.

```
stack = Structures::Stack.new('John')
stack.first           =># John
stack.push('Sally')   =># <Stack>
stack.pop             =># Sally
```

# Queue

Originally, I tried to implement a queue by inheriting from a Singly Linked
List, but it proved to be more trouble than it was worth. Since queues require
interacting with both sides of a list (unlike a stack), they are better suited
to a doubly linked list. This is the structure I used for making a queue, though
very much in a pared down form. More advanced queues may require search, remove,
priority-setting, etc, but a basic queue is simple enough that it can be
implemented on its own without much overhead.

This queue structure uses nodes internally (structures with values and
references to surrounding nodes) and the external calls return only the values.
This is helpful to keep the interior logic very much that of a linked list while
adapter methods give more helpful information to the users of the class. This
separation of internal vs external architecture was very helpful to the design.

Examples of use:

```
queue = Structures::Queue.new('John', 'Sally')
queue.first              =># John
queue.last               =># Sally
queue.enqueue('Jeffery') =># <Queue>
queue.last               =># Jeffery
queue.dequeue            =># John
queue.dequeue            =># Sally
queue.first              =># Jeffery
queue.size               =># 1
```
# Hash Table

A light reproduction of the Ruby hash table. This is implemented via
two basic functions:

```
# The number of bins should be predefined, else it defaults to 1024
hash = HashTable.new(NUMBER)
hash.set(key, value) => value
hash.get(key) => value
```

Behind the scenes, this uses a #hash function to render each word into a hash
value which is modded by the bin allocation and added to the array. For current
purposes, this is a simple additive hashing function and should not be used
for any real loads. Collisions are frequent, which aids in testing worst case
scenarios, but slows down search functions considerably. For real usage, please
make sure to replace the #hash function with a better hashing algorithm.

Once the bin has been selected, both the key and value are stored in a node of
a singly linked list. When searching, the #get method hashes the key to find
the correct bin, and then searches only that bin's nodes to find the correct
key/value pair.

In order to save memory, setting a key's value to nil will remove the node
entirely since a nonexistent key will return nil just as would a key/value pair
with value == nil.

To prevent excessive collisions, a hash's bin allocation is automatically
doubled when the number of k/v pairs reaches the number of bins. Since this
requires the recalculation of which bin each key should belong to, this O(n)
procedure should be avoided if at all possible. Make sure to allocate bins
on the expected scale of your data, or the #set method will occasionally take
far longer than expected.

Additionally, in order to replicate the convenience of the Ruby #each method
on hashes, I've written one to iterate through each bucket and each node,
passing in the key and value to the block. Therefore, you can use this class
to write familiar code such as:

```
some_hash.each do |k, v|
  puts "Key: #{k}, Value: #{v}"
end
```

The size of a hash table can also be queried at any time as an O(1) function.

```
hash_with_13_elements.size =># 13
```

# Binary Tree

Still a work in progress at the moment, this structure demonstrates how
to do pre, in, and post-order traversal of a binary tree. Each of the traversal
methods accepts a block with a value parameter for each node's value.

# Doubly Linked List

A better version of the doubly linked list implemented for the queue. The main
feature here is a minor algorithm for deduplicating values. It iterates through
the list of items and calls remove for each node that contains a value already
seen (tracked through a hash). I have also implemented a constant space version
that is up to O(n^2) time complexity which compares the nodes from an inner
loop with those on an outer loop. This is considerably worse than the default
method, and is presented only as an example of an alternative algorithm.

This also contains some important coding concepts, particularly DRY code.
The methods available here make use of other methods in order to accomplish
their own duties. For example, #deduplicate is simply #deduplicate! called on
a duplicate of the original item. #deduplicate! uses a #remove method
which takes care of List-level deletion logic which in turn relies on the
DoublyLinkedNode#remove method which attends to Node-level deletion logic.
Another example is the #to_s method which uses the #each iterator, which in
turn is just a narrowing of the more powerful #each_node, which is kept as
a private method to avoid exposing excessive data-manipulation control to
the end user. With each bit of logic checked into its own method, it's easy
to change the algorithm as needed.

