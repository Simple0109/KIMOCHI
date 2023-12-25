namespace :push_request do
  desc "LINEBOT:リクエストのtake期日の通知"
  task :push_line_message_request => :environment do
    client = Line::Bot::Client.new { |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token = ENV['LINE_CHANNEL_TOKEN']
    }

    start_of_day = Date.today.beginning_of_day
    end_of_day = Date.today.end_of_day
    limit_requests = Request.where(execution_date: start_of_day..end_of_day)

    limit_requests.each do |r|
      message = {
        type: "text",
        text: "今日は「#{r.take}」をの実行日です"
      }
      response = client.push_message(r.user_uid, message)
    end
  end
end
