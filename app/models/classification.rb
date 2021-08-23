class Classification < ActiveRecord::Base
    has_many :producto
    validates :code, presence: true, uniqueness:true, length: {maximum:50}
    validates :name, presence: true, uniqueness:true, length: {maximum:250}
    def code_name
        "#{code} - #{name}"
    end
end
