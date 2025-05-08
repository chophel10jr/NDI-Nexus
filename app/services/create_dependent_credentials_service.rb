# frozen_string_literal: true

class CreateDependentCredentialsService < ApplicationService
  attr_accessor :vc_id, :params

  def run
    revealed_attrs = build_data(params.dig("requested_presentation", "revealed_attrs"))
    self_attested_attrs = build_data(params.dig("requested_presentation", "self_attested_attrs"))

    create_foundational_id(revealed_attrs)
    create_permanent_address(revealed_attrs)

    create_current_address(self_attested_attrs)
    create_email(self_attested_attrs)
    create_mobile_number(self_attested_attrs)
    create_passport_photo(self_attested_attrs)
  end

  private

  def build_data(raw)
    return {} unless raw

    raw.to_h.each_with_object({}) do |(key, value), data|
      snake_key = key.strip.gsub(/\s+/, "_").downcase
      data[snake_key] = value.first["value"]
    end
  end

  def create_foundational_id(data)
    return unless data.slice("full_name", "gender", "date_of_birth", "id_type", "id_number", "citizenship", "blood_type").any?

    FoundationalId.create(
      full_name: data["full_name"],
      gender: data["gender"],
      date_of_birth: parse_date(data["date_of_birth"]),
      id_type: data["id_type"],
      id_number: data["id_number"],
      citizenship: data["citizenship"],
      blood_type: data["blood_type"],
      verifiable_credential_id: vc_id
    )
  end

  def create_permanent_address(data)
    fields = %w[house_number thram_number village gewog dzongkhag]
    attributes = data.slice(*fields)
    return if attributes.empty?

    PermanentAddress.create(attributes.merge(verifiable_credential_id: vc_id))
  end

  def create_current_address(data)
    fields = %w[unit building street suburb city state country postal_code landmark]
    attributes = data.slice(*fields)
    return if attributes.empty?

    CurrentAddress.create(attributes.merge(verifiable_credential_id: vc_id))
  end

  def create_email(data)
    return unless data["email"]

    Email.create(email: data["email"], verifiable_credential_id: vc_id)
  end

  def create_mobile_number(data)
    return unless data["mobile_number"]

    MobileNumber.create(
      mobile_number: data["mobile_number"],
      mobile_number_type: data["type"],
      verifiable_credential_id: vc_id
    )
  end

  def create_passport_photo(data)
    return unless data["passport-size_photo"]

    PassportSizePhoto.create(
      passport_size_photo: data["passport-size_photo"],
      verifiable_credential_id: vc_id
    )
  end

  def parse_date(str)
    return unless str.present?

    Date.strptime(str, "%d/%m/%Y")
  rescue ArgumentError
    nil
  end
end
