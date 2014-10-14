# Description

This is a repository for various sorting algorithms and data structures - it
has a fair amount of overlap with my Projects Euler repo as it supplies the
same practice

# Usage

Clone the repo and go to work improving the algorithms! This is heavily meant
for practice, so feel free to use it for that purpose.

# Insertion Sort

My current solution for an insertion sort runs a comparison between one element
and the last and swaps the numbers until it hits the beginning of the array or
the pointer element is larger than the previous element. However, this solution
is less than ideal because it has to run a swap each time. A better solution,
though my current implementation fails, would be to run comparisons and shift
all the values at once - that way the number being placed only has to move once
rather than 1 to n times.
