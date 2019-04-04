jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if messages.length > 0

    App.conversation = App.cable.subscriptions.create {
        channel: 'ConversationChannel'
        sender_id: messages.data('user-id')
        recipient_id: 
      },

      connected: ->

      disconnected: ->

      received: (data) ->
        console.log(data['message'])

      speak: (message, sender_id, recipient_id) ->
        @perform 'speak', message: message, sender_id: sender_id, recipient_id: recipient_id

    $(document).on 'keypress', '#new_message', (e) ->
      if e.keyCode == 13
        e.preventDefault()
        values = $(this).serializeArray()
        App.conversation.speak(values)
        $(this).trigger('reset')
