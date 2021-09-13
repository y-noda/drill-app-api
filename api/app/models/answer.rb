class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: Integer
  field :save_data, type: Hash
end
