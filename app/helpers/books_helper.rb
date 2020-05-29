module BooksHelper
  def default(value)
    if value == '0'
    	'未入力'
    else
    	value
    end
  end
end
