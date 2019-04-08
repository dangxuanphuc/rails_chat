conversation_function = (current_user_id, user_id) ->
  App.conversation = App.cable.subscriptions.create {
      channel: 'ConversationChannel'
      current_user_id: current_user_id
      user_id: user_id
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      conversation = $('#conversation').find("[data-user-id='" + user_id + "']")
      conversation.find('#messages-list').find('ul').append(data['message'])
      message_id = data['message_id']
      if data['sender_id'] == parseInt(current_user_id)
        $("#message-#{message_id}").addClass('message-sent')
      else
        $("#message-#{message_id}").addClass('message-received')

      messages_list = conversation.find('#messages-list')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop(height)

    speak: (message, user_id) ->
      @perform 'speak', message: message, user_id: user_id

$(document).on 'keypress', '.new_message', (e) ->
  if e.keyCode == 13 and App.conversation
    e.preventDefault()
    user_id = $(this).find("input").val()
    message = $(this).find("textarea").val()
    App.conversation.speak(message, user_id)
    $(this).trigger('reset')

$(document).on 'click', 'a[id^=user-id]', (e) ->
  e.preventDefault()
  user_id = $(@).attr('id').replace(/user-id-/, '')
  current_user_id = $(@).attr('class').replace(/current-user-/, '')
  $.ajax
    dataType: 'json'
    method: 'GET'
    url: '/messages'
    data:
      current_user_id: current_user_id
      user_id: user_id
    success: (data) ->
      $('#conversation').html(data.conversation_html)
      conversation_function(current_user_id, user_id)

      conversation = $('#conversation').find("[data-user-id='" + user_id + "']")
      messages_list = conversation.find('#messages-list')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop(height)
