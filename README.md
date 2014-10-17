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
