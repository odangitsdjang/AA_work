# Similar to factorial but addition
def sum_to(num)
  return 0 if num == 0
  return nil if num < 0
  num + sum_to(num-1)
end

def add_numbers(arr)
  return arr[0] if arr.length == 1
  return nil if arr.length == 0
  arr[0] + add_numbers(arr[1..-1])
end

def gamma_fnc(num)
  return 1 if num == 1
  return nil if num == 0
  (num-1) * gamma_fnc(num - 1)
end

def ice_cream_shop(flavors, favorite)
  return false if flavors.length == 0
  return flavors == favorite if flavors.is_a?(String)
  (flavors[0] == favorite) || ice_cream_shop(flavors[1..-1], favorite)
end

def reverse(string)
  return "" if string.length == 0
  return string if string.length == 1
  string[-1] + reverse(string[0..-2])
end
