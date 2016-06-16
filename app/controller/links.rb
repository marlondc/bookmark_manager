class BookmarkManager < Sinatra::Base
  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    params[:tags].split(",").each do |tag|
			tag.strip!
      link.tags << Tag.first_or_create(name: tag)
    end
    link.save
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new_link'
  end
end
