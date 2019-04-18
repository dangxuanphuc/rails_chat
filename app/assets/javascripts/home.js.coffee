App.conversation = {}
conversation_function = (current_user_id, user_id) ->
  App.conversation["#{user_id}"] = App.cable.subscriptions.create {
      channel: 'ConversationChannel'
      current_user_id: current_user_id
      user_id: user_id
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      conversation = $('#conversation').find("[data-user-id='" + user_id + "']")
      conversation_visible = conversation.is(':visible')
      if conversation_visible
        conversation.find('#messages-list').find('ul').append(data['message'])
        message_id = data['message_id']
        if data['sender_id'] == parseInt(current_user_id)
          $("#message-#{message_id}").addClass('message-sent')
        else
          $("#message-#{message_id}").addClass('message-received')

        messages_list = conversation.find('#messages-list')
        height = messages_list[0].scrollHeight
        messages_list.scrollTop(height)
      else
        count_message = $('#count-message').is(':visible')
        val_div = parseInt($('#count-message').text())
        if !count_message
          $('#count-message').css('display', 'inline-block')
          $('#count-message').text(val_div + 1)
        else
          val_div += 1
          $('#count-message').text(val_div)

    speak: (message, user_id) ->
      @perform 'speak', message: message, user_id: user_id

$(document).on 'keypress', '.new_message', (e) ->
  if e.keyCode == 13 and App.conversation
    e.preventDefault()
    user_id = $(this).find("input").val()
    message = $(this).find("textarea").val()
    App.conversation["#{user_id}"].speak(message, user_id)
    $(this).trigger('reset')

send_message = (current_user_id, user_id) ->
  $.ajax
    dataType: 'json'
    method: 'GET'
    url: '/messages'
    data:
      current_user_id: current_user_id
      user_id: user_id
    success: (data) ->
      $('#conversation').html(data.conversation_html)
      if App.conversation["#{user_id}"] is undefined
        conversation_function(current_user_id, user_id)
      current_active = $('.active')
      if current_active.length > 0
        current_active.removeClass('active')
      $("#user-id-#{user_id}").addClass('active')
      $('#count-message').css('display', 'none')
      $('#count-message').text(0)

      conversation = $('#conversation').find("[data-user-id='" + user_id + "']")
      messages_list = conversation.find('#messages-list')
      height = messages_list[0].scrollHeight
      messages_list.scrollTop(height)

$(document).on 'click', 'li[id^=user-id]', (e) ->
  e.preventDefault()
  $this = $(@)
  user_id = $this.attr('id').replace(/user-id-/, '')
  current_user_id = $this.find('.about a').attr('class').replace(/current-user-/, '')
  send_message(current_user_id, user_id)

$(document).on 'turbolinks:load', (e) ->
  e.preventDefault()
  $this = $(@)
  user_id = $this.find('#messages').data('user-id')
  current_user_id = $this.find('#messages').data('current-user')
  send_message(current_user_id, user_id)
