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
      @link = false              # リンクアップ true、リンクダウン false
   end
   
   def link=(value)
      @link = value
   end

   def printAll
      print "***** mii-tool実行結果 *****\n"
      print "[link]        #{@link}\n"
      print "\n"
   end
end


# serial経由でmii-toolコマンドを発行し
# LinkInfoの指定したデバイス情報を取得

def chkLink(serial, linkInfo)
   linkInfo.init()
   serial.write "sudo mii-tool eth0\n"     # mii-toolコマンド発行
   loop do
      begin
         sleep 0.05
         recv = serial.readline
         if recv.include?("link ok")
            linkInfo.link = true
            break
         else
            linkInfo.link = false
         end
      rescue EOFError
         break
      end
   end
   linkInfo.printAll
end
