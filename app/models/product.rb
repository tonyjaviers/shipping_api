class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, type: String
  field :type, type: String
  field :length, type: Integer
  field :width, type: Integer
  field :height, type: Integer
  field :weight, type: Integer

  validates_presence_of :name, :type, :length, :width, :height, :weight
  validates_numericality_of :length, :width, :height, :weight, greater_than_or_equal_to: 0
end



