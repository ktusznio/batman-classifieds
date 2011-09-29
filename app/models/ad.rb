class Ad < ActiveRecord::Base
  scope :active, where(:state => 'active')
  scope :closed, where(:state => 'closed')

  ALLOWED_TAGS = %w( em strong a )

  belongs_to :user
  has_many :images, :dependent => :destroy
  accepts_nested_attributes_for :images, :reject_if => lambda { |t| t['image'].blank? }

  state_machine :state, :initial => :draft do
    store_audit_trail

    event :activate do
      transition :draft => :active
    end

    event :close do
      transition :active => :closed
    end

    #after_transition :draft => :active, :do => :reindex
    #after_transition :active => :closed, :do => :deindex
  end

  def set_price?
    sale_type == 'fixed'
  end

  def free?
    sale_type == 'free' || price == 0
  end

  def reindex
    Delayed::Job.enqueue AddToAdIndexJob.new(id)
  end

  def deindex
    Delayed::Job.enqueue RemoveFromAdIndexJob.new(id)
  end

  def as_json(options={})
    super(options.merge(
      :include => {
        :images => {
          :methods => :urls, :except => :image
        },
        :user => {
          :methods => :name
        }
    }))
  end

  private
  before_save :nullify_price, :unless => :set_price?, :on => :create
  before_save :sanitize_description, :if => :description_changed?
  after_commit :reindex

  def nullify_price
    self.price = nil
  end

  def sanitize_description
    self.description = sanitizer.sanitize(description.to_s, :tags => ALLOWED_TAGS)
  end

  def sanitizer
    @sanitizer ||= HTML::WhiteListSanitizer.new
  end

  validates :description, :presence => true
  validates :title, :presence => true
  validates :price, :presence => true, :numericality => { :greater_than => 0 }, :if => :set_price?
  validates :sale_type, :presence => true, :inclusion => ['fixed', 'free', 'trade']
end
