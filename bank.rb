# frozen_string_literal: true

class Bank
  attr_accessor :bank

  def initialize
    @bank = 0
  end

  def put_exp
    self.bank += 10
  end

  def get_exp
    self.bank -= 10
  end
end
