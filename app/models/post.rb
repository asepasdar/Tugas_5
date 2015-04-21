class Post < ActiveRecord::Base
	acts_as_taggable # Alias for acts_as_taggable_on :tags
	acts_as_taggable_on :tag_list
	has_many :comments, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: { minimum: 5 }
	validates :body, presence: true, length: { minimum: 10 }
	validates :status, presence: true
	scope :status_active, -> {where(status: 'active')}

	self.per_page = 10
	

	def self.to_csv(post)
		CSV.generate do |csv|
			csv << column_names
			all.each do |post|
				csv << post.attributes.values_at(*column_names)
			end
		end
	end

	def self.import(file)
		spreadsheet = open_spreadsheet(file)
		header = spreadsheet.row(1)
		(2..spreadsheet.last_row).each do |i|
			row = Hash[[header, spreadsheet.row(i)].transpose]
			post = find_by_id(row["id"]) || new
			post.attributes = row.to_hash.slice(*Post.attribute_names())
			post.save!
		end
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
			when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
	  		when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
	  		when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
	  		else raise "Unknown file type: #{file.original_filename}"
  		end
	end
end