defmodule Twitter.Supervisor do
  alias Twitter.UserAccountStructure
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [], name: :chat_supervisor)
  end

  def signup_user(name,password) do
    #Generate hash here or inthe parameter itself, use bcrypt for maximum protection
    Supervisor.start_child(:chat_supervisor, [%UserAccountStructure{ user_name: name, password_hash: password}])
  end

  def init(_) do
    children = [
      worker(Project4.Server, [])
    ]

    supervise(children, strategy: :simple_one_for_one)
  end
end
