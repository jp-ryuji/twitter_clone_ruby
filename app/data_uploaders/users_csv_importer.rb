# frozen_string_literal: true

class UsersCsvImporter < CsvImporterBase
  def import
    import_base do |row|
      importer = UsersImporter.new(row)
      if destroy_row? row
        importer.destroy_record
      else
        importer.create_or_update_record
      end
    end
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
  end

  private

  def destroy_row?(row)
    row[:delete]&.casecmp?('TRUE') && row[:email]&.present?
  end

  class UsersImporter
    def initialize(attrs)
      @attrs = attrs
    end

    # @raise [ActiveRecord::RecordInvalid]
    def create_or_update_record
      ActiveRecord::Base.transaction do
        if @attrs[:email].present?
          user = User.find_or_initialize_by(@attrs.slice(:email))
          user.attributes = updatable_attributes
        else
          user = User.new(updatable_attributes)
        end
        user.save!
        # TODO: Calculate how many records have been added/updated.
      end
    end

    def destroy_record
      User.find_by(@attrs.slice(:email))&.destroy
    end

    private

    def updatable_attributes
      @attrs.slice(:email, :password, :screen_name)
    end
  end
end
