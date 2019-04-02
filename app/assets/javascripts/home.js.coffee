# $(document).on 'click', 'a[id^=user-id]', (e) ->
#   e.preventDefault()
#   user_id = $(@).attr('id').replace(/user-id-/, '')
#   conversation_id = $(@).parent().parent().parent().parent().parent().parent().find('#messages')[0]
#   console.log(conversation_id)
  # $.ajax
  #   dataType: 'json'
  #   method: 'POST'
  #   url: '/conversations'
  #   data:
  #     user_id: user_id
  #   success: (data) ->
  #     conversations = $('#conversations-list')
  #     conversation = conversations.find("[data-conversation-id='" + "#{@conversation.id}" + "']")
  #     if conversation.length != 1
  #       conversations.append(data.conversation_html)
  #       conversation = conversations.find("[data-conversation-id='" + "#{@conversation.id}" + "']")
  #     conversation.find('.panel-body').show()
  #     messages_list = conversation.find('.messages-list')
  #     height = messages_list[0].scrollHeight
  #     messages_list.scrollTop(height)
