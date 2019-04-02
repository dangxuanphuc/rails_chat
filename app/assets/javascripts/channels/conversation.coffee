jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')
  if messages.length > 0

    App.conversation = App.cable.subscriptions.create {
        channel: 'ConversationChannel'
        user_id: messages.data('user-id')
      },

      connected: ->

      disconnected: ->

      received: (data) ->
        conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']")

        if data['window'] != undefined
          conversation_visible = conversation.is(':visible')

          if conversation_visible
            messages_visible = (conversation).find('.panel-body').is(':visible')
            if !messages_visible
              conversation.removeClass('panel-default').addClass('panel-success')
            conversation.find('.messages-list').find('ul').append(data['message'])
          else
            $('#conversations-list').append(data['window'])
            conversation = $('#conversations-list').find("[data-conversation-id='" + data['conversation_id'] + "']")
            conversation.find('.panel-body').toggle()
        else
          conversation.find('ul').append(data['message'])

        messages_list = conversation.find('.messages-list')
        height = messages_list[0].scrollHeight
        messages_list.scrollTop(height)

      speak: (message, user_id) ->
        @perform 'speak', message: message, user_id: user_id

    $(document).on 'keypress', '.new_message', (e) ->
      if e.keyCode == 13
        e.preventDefault()
        values = $(this).serializeArray()
        App.conversation.speak(values)
        $(this).trigger('reset')
