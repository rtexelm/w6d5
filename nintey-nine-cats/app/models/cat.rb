require "action_view"

# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = ['black', 'orange', 'calico', 'sherbert', 'grey', 'speckled']

  validates :birth_date, :color, :sex, :name, presence: true
  validates :color, inclusion: { in: CAT_COLORS }
  validates :sex, inclusion: { in: ['M','F'] }

  validate :birth_date_cannot_be_future

  def birth_date_cannot_be_future
    if birth_date > Date.today
      errors.add(:future_date, "Birth date must be prior to today's date")
    end
  end

  def age
    time_ago_in_words(birth_date)
  end
end
