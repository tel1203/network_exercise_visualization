#
# ifconfig用
#


# ifconfigの結果を格納するクラス

class IpInfo
   def initialize(device="eth0")
      @device = device           # デバイス名
      init()
   end

   def init()
      @hwaddr = ""               # MACアドレス
      @inetaddr = ""             # IPv4アドレス
      @bcast = ""                # IPv4ブロードキャストアドレス
      @mask = ""                 # IPv4サブネットマスク
      @rx = ""                   # 受信パケット数
      @tx = ""                   # 送信パケット数
   end
   
   def device
      @device
   end
   
   def device=(value)
      @device = value
   end
   
   def hwaddr
      @hwaddr
   end

   def hwaddr=(value)
      @hwaddr = value
   end
   
   def inetaddr
      @inetaddr
   end

   def inetaddr=(value)
      @inetaddr = value
   end

   def bcast
      @bcast
   end
   
   def bcast=(value)
      @bcast = value
   end
   
   def mask
      @mask
   end
   
   def mask=(value)
      @mask = value
   end
   
   def rx
      @rx
   end
   
   def rx=(value)
      @rx = value
   end
   
   def tx
      @tx
   end
   
   def tx=(value)
      @tx = value
   end
   
   # serial経由でifconfigコマンドを発行し
   # ipInfoの指定したデバイス情報を取得
   def command(serial)
      init()
      serial.write "ifconfig " + @device + "\n"     # ifconfigコマンド発行
      loop do
         begin
            sleep 0.05
            recv = serial.readline

            if recv.include?("HWaddr")                # MACアドレス
               ary = recv.scanf("%s %s %s %s %s")
               if ary.length == 5
                  @hwaddr = ary[4]
               end
            elsif recv.include?("inet addr:")         # IPv4アドレス
               ary = recv.scanf("inet addr:%s Bcast:%s Mask:%s")
               if ary.length == 3
                  @inetaddr = ary[0]
                  @bcast    = ary[1]
                  @mask     = ary[2]
               end
            elsif recv.include?("RX packets:")         # 受信パケット数
               ary = recv.scanf("RX packets:%s errors:%s dropped:%s overruns:%s frame:%s")
               if ary.length == 5
                  @rx = ary[0]
               end
            elsif recv.include?("TX packets:")         # 送信パケット数
               ary = recv.scanf("TX packets:%s errors:%s dropped:%s overruns:%s carrier:%s")
               if ary.length == 5
                  @tx = ary[0]
               end
            end

         rescue EOFError
            break
         end
      end
      printAll
   end

   def printAll
      print "***** ifconfig実行結果 *****\n"
      print "[device]      #{@device}\n"
      print "[HWaddr]      #{@hwaddr}\n"
      print "[inet addr]   #{@inetaddr}\n"
      print "[Bcast]       #{@bcast}\n"
      print "[Mask]        #{@mask}\n"
      print "[RX]          #{@rx}\n"
      print "[TX]          #{@tx}\n"
      print "\n"
   end
end



