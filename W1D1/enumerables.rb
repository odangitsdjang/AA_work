class Array
  def my_each(&prc)
    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end
  end

  def my_select(&prc)
    res = []
    i = 0
    while i < self.length
      res << self[i] if prc.call(self[i])
      i += 1
    end
    res
  end

  def my_reject(&prc)
    res = []
    i = 0
    while i < self.length
      res << self[i] if !prc.call(self[i])
      i += 1
    end
    res
  end

  def my_any(&prc)
    self.my_each do |el|
      return true if prc.call(el)
    end
  end


  def my_flatten
    res = []
    self.each do |el|
      if el.is_a? Array
        res += el.my_flatten
      else
        res << el
      end
    end
    res
  end

  def my_zip(*params)
    res = []
    (0...self.length).each do |idx|
      res << [self[idx]]
      params.each do |arr|
        res[idx] << arr[idx]
      end
    end
    res
  end

  def my_rotate(num=1)
    rotations = num % self.length
    dup_arr = self.dup
    rotations.times do
      dup_arr << dup_arr.shift
    end
    dup_arr
  end

  def my_join(param='')
    res = ''
    self.each do |el|
      res += el
      res += param
    end
    res.chop! if res[-1] == param
    res
  end

  def my_reverse()
    res = []
    self.each do |el|
      res.unshift(el)
    end
    res
  end

  def bubble_sort!(&prc)
    prc ||= Proc.new { |num1, num2| num1 <=> num2 }
    swapped = false
    until swapped
      swapped = true
      self.length.times do |i|
        break if i == self.length - 1
        if prc.call(self[i], self[i + 1]) == 1
          self[i], self[i + 1] = self[i + 1], self[i]
          swapped = false
        end
      end
    end
    self
  end


  def bubble_sort(&prc)
    new_arr = self.dup
    new_arr.bubble_sort!
  end
end


def factors(num)
  res = []
  (1..num).to_a.each do |n|
    res << n if num % n == 0
  end
  res
end

def substrings(string)
  res = []
  i = 0
  while i < string.length
    j = i
    while j < string.length
      res << string[i..j]
      j += 1
    end
    i += 1
  end
  res
end

def subwords(word, dictionary)
  res = []
  subs = substrings(word)
  subs.each { |wrd| res << wrd if dictionary.include?(wrd) }
  res
end
