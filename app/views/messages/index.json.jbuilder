json.conversation_html render partial: 'messages/conversation', formats: [:html, :erb], locals: { messages: @messages, user: @user }
