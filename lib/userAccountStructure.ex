defmodule Project4.UserAccountStructure do
    #Can expand this to whatever we need for the user to follow
    defstruct user_name: nil,
              password_hash: nil,
              tweets: nil,
              followers: nil,
              public: true,
              mentions: nil
  end
