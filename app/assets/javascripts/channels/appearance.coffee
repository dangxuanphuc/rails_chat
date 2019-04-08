App.appearance = App.cable.subscriptions.create { 
    channel: "AppearanceChannel"
  },
  connected: ->

  disconnected: ->

  received: (data) ->
    user = JSON.parse(data)
    $user_status = $("#user-" + user.id + "-status")
    if user.online is true
      $user_status.addClass('active').removeClass('inactive')
    else
      $user_status.addClass('inactive').removeClass('active')
