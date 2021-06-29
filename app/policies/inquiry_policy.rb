class InquiryPolicy < ApplicationPolicy
  def update?
    @record.broker == @user
  end
end
