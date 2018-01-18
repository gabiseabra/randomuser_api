module App::Scopes
  extend ActiveSupport::Concern

  module ClassMethods
    def like_any(fields, terms)
      fields = Array(fields)
      terms = Array(terms)
      result = fields.product(terms).map do |(field, value)|
        arel_table[field].matches("%#{value}%")
      end
      where(result.inject(:or))
    end
  end
end
