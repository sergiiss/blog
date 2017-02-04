require 'sinatra'
require_relative 'lib/comment'
require_relative 'lib/comment_store'

store = CommentStore.new('comments.yml')
store2 = CommentStore.new('comments2.yml')

get('/blog') do
  erb :index
end

get('/first_recording') do
  @comments = store.all
  erb :first_recording
end

get('/second_recording') do
  @comments2 = store2.all
  erb :second_recording
end

post('/first_recording/create') do
  @comm = Comment.new
  @comm.name = params['name']
  @comm.comment = params['comment']
  @comm.time = Time.now
  @comm.time = (@comm.time).to_s
  @comm.time = (@comm.time)[0..10] + "  в  " + (@comm.time)[11..-7]
  store.save(@comm)
  redirect '/first_recording'
end

get('/first_recording/:id') do
  id = params['id'].to_i
  @comm = store.find(id)
  erb :show
end

post('/second_recording/create') do
  @comm = Comment.new
  @comm.name = params['name']
  @comm.comment = params['comment']
  @comm.time = Time.now
  @comm.time = (@comm.time).to_s
  @comm.time = (@comm.time)[0..10] + '  в  ' + (@comm.time)[11..-7]
  store2.save(@comm)
  redirect '/second_recording'
end

get('/second_recording/:id') do
  id = params['id'].to_i
  @comm = store2.find(id)
  erb :show
end
