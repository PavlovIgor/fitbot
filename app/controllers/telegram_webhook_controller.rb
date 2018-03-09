class TelegramWebhookController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  context_to_action!

  # def message(message)
  #   respond_with :message, text: 'message'
  # end

  def keyboard(value = nil, *)
    if value
      respond_with :message, text: value, reply_markup: {
        remove_keyboard: true
      }
    else
      save_context :keyboard
      respond_with :message, text: 'ok', reply_markup: {
        keyboard: [['ok', 'cancel']],
        resize_keyboard: true,
        one_time_keyboard: true,
      }
    end
  end

  def start(*)
    save_context :age
    respond_with :message, text: ObeyBotFacade.start(from)
    respond_with :message, text: ObeyBot.age_question
  end

  def age(age = nil, *)
    if (Integer(age) rescue false)
      save_context :gender
      respond_with :message, text: ObeyBotFacade.age_answer(age, update["message"]['from']['id'])
      respond_with :message, text: ObeyBot.gender_question
    else
      save_context :age
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def gender(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:man_gender_var], ObeyBot.vars[:woman_gender_var]].include? data
      save_context :skill_level
      respond_with :message, text: ObeyBotFacade.gender_answer(data, update["message"]['from']['id'])
      respond_with :message, text: ObeyBot.skill_level_question
    else
      save_context :gender
      respond_with :message, text: ObeyBot.say_error
    end
  end

  def skill_level(data = nil, *)
    data.downcase!
    if [ObeyBot.vars[:low_skill_level_var], ObeyBot.vars[:medium_skill_level_var], ObeyBot.vars[:high_skill_level_var]].include? data
      respond_with :message, text: ObeyBotFacade.skill_level_answer(data, update["message"]['from']['id'])
      respond_with :message, text: ObeyBotFacade.user_program(update["message"]['from']['id'])
    else
      save_context :skill_level
      respond_with :message, text: ObeyBot.say_error
    end
  end

end
