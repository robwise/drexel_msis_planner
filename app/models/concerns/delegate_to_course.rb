# Delegates methods that are commonly delegated to a model's course association
module DelegateToCourse
  require "forwardable"
  extend Forwardable
  def_delegators :course, :full_id, :level, :department, :title, :description,
                 :prerequisite
end
