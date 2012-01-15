# Github Credentials allows you to map your user against your GitHub user.
# This is specifically in order to work with apps that have GitHub Oauth users.
#
# Megumi who do you know - List all the users with github logins tracked by Hubot
# Megumi i am githubusernamehere - map your user to the github login `githubusernamehere`
# Megumi who am i - reveal your mapped github login
# Megumi forget me - de-map your user to your github login

module.exports = (robot) ->

  robot.respond /who do you know/i, (msg) ->
    theReply = "Here is who I know:\n"

    for own key, user of robot.brain.data.users
      if(user.githubLogin)
        theReply += user.name + " is " + user.githubLogin + "\n"

    msg.send theReply

  robot.respond /i am (\w+)/i, (msg) ->
    githubLogin = msg.match[1]
    msg.message.user.githubLogin = githubLogin
    msg.send "Ok, you are " + githubLogin + " on GitHub"

  robot.respond /who am i/i, (msg) ->
    user = msg.message.user
    if user.githubLogin
      msg.reply "You are known as " + user.githubLogin + " on GitHub"
    else
      msg.reply "I don't know who you are. You should probably identify yourself with your GitHub login"

  robot.respond /forget me/i, (msg) ->
    user = msg.message.user
    user.githubLogin = null

    msg.reply("Ok, I have no idea who you are anymore.")

