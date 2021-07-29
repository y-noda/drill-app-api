class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: Integer
  field :answer, type: Hash
end
