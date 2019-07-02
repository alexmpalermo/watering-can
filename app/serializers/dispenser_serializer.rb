class DispenserSerializer < ActiveModel::Serializer
  attributes :id, :name, :capacity, :product_number, :date_refilled, :current_amount, :vacation_days, :start_vacation, :end_vacation
  belongs_to :user
  has_many :plants

end
