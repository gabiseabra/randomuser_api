module ScopeConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def like_any(fields, terms)
      fields = Array(fields)
      terms = Array(terms)
      fields.product(terms).inject do |query, (field, value)|
        condition = arel_table[field].matches("#{value}%")
        if query
          query.or(condition)
        else
          condition
        end
      end
    end
  end
end
