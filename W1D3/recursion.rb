require 'byebug'

def range_recursive(start, finish)
  return [] if finish < start
  range(start, finish - 1) << (finish-1)
end

def range_iterative(start, finish)
  arr = []
  start.upto(finish - 1) { |i| arr << i }
  arr
end

def exp_rec1(b, exp)
  return 1 if exp == 0
  b * exp_rec1(b, exp - 1)
end

def exp_rec2(b, exp)
  return 1 if exp == 0
  return b if exp == 1

  if exp.even?
    even_val = exp_rec2(b, exp/2)
    even_val * even_val
  else
    odd_val = exp_rec2(b, (exp - 1) / 2)
    b * odd_val * odd_val
  end

end

def deep_dup(arr)
  return arr unless arr.is_a? Array
  arr.map { |el| deep_dup(el) }
end

def fib_rec(n)
  return [1] if n == 1
  return [1,1] if n == 2
  prev_fibs = fib_rec(n-1)
  prev_fibs << prev_fibs[-1] + prev_fibs[-2]
end

def fib_iter(n)
  arr = [1, 1]
  while arr.length < n
    arr.push(arr[-1] + arr[-2])
  end
  arr
end

def subsets(arr)
  return [[]] if arr.length == 0
  prev_subsets = subsets(arr[0..-2])
  next_subsets = []
  prev_subsets.each { |sub_arr| next_subsets << sub_arr.dup.push(arr[-1]) }
  prev_subsets + next_subsets
end

def permutations(arr)
  return [arr] if arr.length == 1
  prev_perm = permutations(arr[0..-2])
  res = []
  prev_perm.each do |perm_arr|
    (0..perm_arr.length).each do |i|
      res << perm_arr[0...i] + [arr[-1]] + perm_arr[i..-1]
    end
  end
  res
end

def bsearch(array, target)
  if array.length == 1
    return array[0] == target ? 0 : nil
  end
  midpoint = array.length / 2
  if array[midpoint] > target
    bsearch(array[0...midpoint], target)
  elsif array[midpoint] < target
    midpoint + bsearch(array[midpoint+1..-1], target) + 1
  else
    return midpoint
  end
end

def merge_sort(arr)
  return arr if arr.length <= 1
  arr1 = merge_sort(arr[0...arr.length/2])
  arr2 = merge_sort(arr[arr.length/2..-1])
  merge_helper(arr1, arr2)
end

def merge_helper(arr1, arr2)
  res = []
  until arr1.length == 0 && arr2.length == 0
    if arr1.length == 0
      return res + arr2
    end
    if arr2.length == 0
      return res + arr1
    end
    if arr1.first > arr2.first
      res << arr2.shift
    else
      res << arr1.shift
    end
  end
  res
end

def greedy_make_change(amount, coins = [25, 10, 5, 1])
  return [] if amount == 0
  return [1] if amount == 1
  largest_coin = coins.select { |coin| coin <= amount }.max
  new_amount = amount - largest_coin
  [largest_coin] + greedy_make_change(new_amount, coins)
end

def make_better_change(amount, coins = [25, 10, 5, 1])
  # byebug
  return [] if amount == 0
  return [1] if amount == 1
  res_hash = {}
  coins.each do |coin|
    next if coin > amount
    new_coins = coins.select { |c| c <= coin }
    new_amount = amount - coin
    res = [coin] + make_better_change(new_amount, new_coins)
    res_hash[res.length] = res
  end
  min_key = res_hash.keys.min
  res_hash[min_key]
end

if __FILE__ == $PROGRAM_NAME
  # make_better_change(24, [10,7,1])

  make_better_change(18,[10,9,1])
end
