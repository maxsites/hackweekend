require 'sinatra'

set :public_folder, Proc.new { File.join(root, "_site") }

configure do
  `jekyll build`
end

before do
  response.headers['Cache-Control'] = 'public, max-age=31557600' # 1 year
end

get '/*' do
  file_name = "_site#{request.path_info}/index.html".gsub(%r{\/+},'/')
  if File.exists?(file_name)
    File.read(file_name)
  else
    raise Sinatra::NotFound
  end
end
