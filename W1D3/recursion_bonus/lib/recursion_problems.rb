#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return 0 if array.length == 0
  array[0] + sum_recur(array[1..-1])
end

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return array[0] == target if array.size == 1
  array[0] ==  target || includes?(array[1..-1], target)
end

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  count = array[0] == target ? 1 : 0
  return count if array.size == 1
  count + num_occur(array[1..-1], target)
end

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.size == 1
  (array[0] + array[1] == 12) || add_to_twelve?(array[1..-1])
end

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.size <= 1
  (array[0] <= array[1]) && sorted?(array[1..-1])
end

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length <= 1
  string[-1] + reverse(string[0...-1])
end
