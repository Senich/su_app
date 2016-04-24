module ApplicationHelper
	def get_company_address_section(company, address)
    Section.where(company_id: company.id, address_id: address.id).first.location
  end
end
