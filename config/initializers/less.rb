class CustomLessTemplate < Tilt::LessTemplate
  def prepare
    parser  = ::Less::Parser.new(:filename => eval_file, :line => line, :paths => Rails.application.assets.paths)
    @engine = parser.parse(data)
  end
end
Rails.application.assets.register_engine '.less', CustomLessTemplate
