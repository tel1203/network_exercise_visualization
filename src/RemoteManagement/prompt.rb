#
# プロンプト処理用
#

# ログイン処理

def login(serial)
   puts "ログイン中..."
   serial.write "\n"
   loginFlag = false
   while !loginFlag do
      sleep 1
      recv = ""
      loop do
         begin
            recv = recv + serial.readline
            if recv.include?("raspberrypi login:")       # ユーザ名
               serial.write "pi\n"
               break
            elsif recv.include?("Password:")             # パスワード
               serial.write "raspberry\n"
               loginFlag = true
               break
            elsif recv.include?("pi@raspberrypi:~$")     # ログイン済み（プロンプト受信）
               loginFlag = true
               break
            end
         rescue EOFError
            # readlineのエラー処理
         end
      end
   end
   puts "ログイン完了"
end


# プロンプト受信待ち

def waitPrompt(serial)
   serial.write "\n"
   recv = ""
   loop do
      begin
         recv = recv + serial.readline
         if recv.include?("pi@raspberrypi:~$")     # プロンプトを受信
            break 
         end
      rescue EOFError
         # readlineのエラー処理
      end
   end
end

