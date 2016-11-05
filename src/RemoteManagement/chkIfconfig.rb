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

   def printAll
      print "***** ifconfig実行結果 *****\n"
      print "[device]      #{@device}\n"
      print "[HWaddr]      #{@hwaddr}\n"
      print "[inet addr]   #{@inetaddr}\n"
      print "[Bcast]       #{@bcast}\n"
      print "[Mask]        #{@mask}\n"
      print "\n"
   end
end


# serial経由でifconfigコマンドを発行し
# ipInfoの指定したデバイス情報を取得

def chkIfconfig(serial, ipInfo)
   ipInfo.init()
   serial.write "ifconfig " + ipInfo.device + "\n"     # ifconfigコマンド発行
   loop do
      begin
         sleep 0.05
         recv = serial.readline

         if recv.include?("HWaddr")                # MACアドレス
            ary = recv.scanf("%s %s %s %s %s")
            if ary.length == 5
               ipInfo.hwaddr = ary[4]
            end
         elsif recv.include?("inet addr:")         # IPv4アドレス
            ary = recv.scanf("inet addr:%s Bcast:%s Mask:%s")
            if ary.length == 3
               ipInfo.inetaddr = ary[0]
               ipInfo.bcast    = ary[1]
               ipInfo.mask     = ary[2]
            end
         end
      rescue EOFError
         break
      end
   end
   ipInfo.printAll
end
