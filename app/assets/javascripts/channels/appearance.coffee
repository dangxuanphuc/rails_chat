App.appearance = App.cable.subscriptions.create {
    channel: 'AppearanceChannel'
  },
  connected: ->

  disconnected: ->

  received: (data) ->
    user = JSON.parse(data['user'])
    $user_status = $("#user-#{user.id}-status")
    $chat_status = $("#chat-status-#{user.id}")

    if user.online is true
      $user_status.addClass('online').removeClass('offline').html('<span> online</span>')
      $chat_status.addClass('online').removeClass('offline').text('Active now')
    else
      $user_status.addClass('offline').removeClass('online').html('<span> offline</span>')
      $chat_status.addClass('offline').removeClass('online').text(data['time'])
