defmodule Project4.Server do
  alias Project4.UserAccountStructure
  use GenServer

  # API

  def start_link(%UserAccountStructure{ user_name: name, password_hash: password} = user_data) do
    GenServer.start_link(__MODULE__, user_data, name: via_tuple(name))
  end

  defp via_tuple(user_name) do
    {:via, :gproc, {:n, :g, {:client_list, user_name}}}
  end

  def send_tweet(user_name, message) do
    GenServer.call(via_tuple(user_name), {:send_tweet, message})
  end

  def add_followers(user_name,follower_user_name) do
    GenServer.call(via_tuple(user_name), {:add_follower, follower_user_name})
  end


  #not actually implemented correctly.
  def get_messages(user_name) do
    GenServer.call(via_tuple(user_name), :get_messages)
  end

  # SERVER

  def init(user_data) do
    {:ok, user_data}
  end

  def handle_call({:send_tweet, newMessage},_from,  %UserAccountStructure{tweets: oldTweets} = user_data) do
   # newTweet = oldTweets|newMessage
    #IO.puts(" #{newTweet}")
    #Map.replace(user_data, tweets, newTweet)
    {:reply, "#{newMessage} tweeted", user_data}
  end
  

  def handle_call({:add_follower, newFollower},_from,  %UserAccountStructure{followers: oldFollowers} = user_data) do
     newFollowerList = oldFollowers|newFollower
     #IO.puts(" #{newTweet}")
     Map.replace(user_data, followers, newFollowerList)
     {:reply, "#{newMessage} tweeted", user_data}
  end

  def handle_call(:get_messages, _from, messages) do
    {:reply, messages, messages}
  end
end
