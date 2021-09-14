class Answer
  include Mongoid::Document
  include Mongoid::Timestamps
  field :key, type: String
  field :save_data, type: Hash
end
