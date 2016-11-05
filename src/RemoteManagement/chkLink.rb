#
# mii-tool用
#
# *** sudo mii-tool eth0 コマンドの実行例（リンクアップ）***
# eth0: negotiated 1000baseT-HD flow-control, link ok
#
# *** sudo mii-tool eth0 コマンドの実行例（リンクダウン）***
# eth0: no link
#

# mii-toolの結果を格納するクラス

class LinkInfo
   def initialize()
      init()
   end

   def init()
      @link = 0              # リンクアップ 1、リンクダウン 0
   end
   
   def link
      @link
   end
   
   def link=(value)
      @link = value
   end
   
   # serial経由でmii-toolコマンドを発行し
   # LinkInfoの指定したデバイス情報を取得
   def command(serial)
      init()
      serial.write "sudo mii-tool eth0\n"     # mii-toolコマンド発行
      loop do
         begin
            sleep 0.05
            recv = serial.readline
            if recv.include?("link ok")
               @link = 1
               break
            else
               @link = 0
            end
         rescue EOFError
            break
         end
      end
      printAll
   end

   def printAll
      print "***** mii-tool実行結果 *****\n"
      print "[link]        #{@link}\n"
      print "\n"
   end
end



