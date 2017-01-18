#
# route用
#

# routeの結果を格納するクラス

class RouteInfo
   def initialize()
      init()
   end

   def init()
      @table = ""              # ルーティングテーブル
   end
   
   def table
      @table
   end
   
   def table=(value)
      @table = value
   end
   
   # serial経由でrouteコマンドを発行し
   # RouteInfoの指定したデバイス情報を取得
   def command(serial)
      init()
      serial.write "route\n"     # mii-toolコマンド発行
      loop do
         begin
            sleep 0.05
            recv = serial.readline
            if !recv.include?("pi@raspberrypi:~$") && !recv.include?("Kernel IP routing table")
               @table = @table + recv
            end
         rescue EOFError
            break
         end
      end
      printAll
   end

   def printAll
      print "***** route実行結果 *****\n"
      print @table
      print "\n"
   end
end



