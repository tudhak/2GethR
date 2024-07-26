class OpenaiAutopilot
  def initialize(chatroom)
    @chatroom = chatroom
  end

  def get_gpt_answer(chat_history)
    client = OpenAI::Client.new
    response = client.chat(parameters: {
      model: "gpt-3.5-turbo",
      messages: chat_history
    })
    return response["choices"][0]["message"]["content"]
  end

end
