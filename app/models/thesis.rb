class Thesis < ActiveRecord::Base
  belongs_to :user
  mount_uploader :book_list, BooklistUploader
  mount_uploader :slide, BooklistUploader

  validates_presence_of :title

  validates :final, :uniqueness => { :scope => :user_id }, :if => :final

  # validate :only_one_final_thesis
  # scope :the_final, -> { where(final: true)}

  # protected
  # def only_one_final_thesis
  #   return unless final?

  #   matches = Thesis.the_final
  #   if persisted?
  #     matches = matches.where('id != ?', id)
  #   end
  #   if matches.exists?
  #     errors.add(:final, '您已經選擇其他篇為最終論文題目。')
  #   end
  # end

end
