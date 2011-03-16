require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-migrations'
require 'dm-validations'
require 'dm-timestamps'

DataMapper.setup(:default, "mysql://localhost/textos")

class Texto
	include DataMapper::Resource

	property :id,					Serial
	property :conteudo, 	Text, 	 :required => false
	property :created_at, DateTime
	property :updated_at, DateTime

	validates_length_of :conteudo, :minimum => 3
end

DataMapper.auto_upgrade!

# new
get '/' do
	erb :new
end

# create
post '/' do
	@texto = Texto.new(:conteudo => params[:texto_conteudo])
	if @texto.save
		redirect "/#{@texto.id}"
	else
		redirect '/'
	end
end

# show
get '/:id' do
	@texto = Texto.get(params[:id])
	if @texto
		erb :show
	else
		redirect '/'
	end
end
