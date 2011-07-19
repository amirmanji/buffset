class Fixnum
  # 1 => /
  # 4 => ////
  # 8 =>  ///
  # starting with 10, use Roman
  def tallyize
    ones = self % 5
    fives = self - ones
    "#{fives.romanize} #{'/' * ones}"
  end

  def romanize
    raise 'too big' if self > 9999
    str = []
    num = self
    s, num = fives(num, 1000, 'M', "\342\206\201", "\342\206\202")
    str << s
    s, num = fives(num, 100, 'C', 'D', 'M')
    str << s
    s, num = fives(num, 10, 'X', 'L', 'C')
    str << s
    s, num = fives(num, 1, 'I', 'V', 'X')
    str << s

    str.join(' ')
  end

private

  def fives(num, unit, one, five, ten)
    str = []
    c = num / unit
    if c == 9
      str << one << ten
      num -= 9 * unit
    elsif c >= 5
      str << five
      num -= 5 * unit
    elsif c == 4
      str << one << five
      num -= 4 * unit
    end
    c = num / unit
    c.times{ str << one }
    num -= c * unit
    [str.join(''), num]
  end
end
