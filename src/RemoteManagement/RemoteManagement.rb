require 'serialport'
require 'scanf'
require '/home/pi/RemoteManagement/prompt'
require '/home/pi/RemoteManagement/chkLink'
require '/home/pi/RemoteManagement/chkIfconfig'
require '/home/pi/RemoteManagement/chkVmstat'
require '/home/pi/RemoteManagement/chkRoute'
require 'net/http'

hostname = `hostname`.strip
linkInfo0 = LinkInfo.new("eth0")
linkInfo1 = LinkInfo.new("eth1")
ipInfo0 = IpInfo.new("eth0")
ipInfo1 = IpInfo.new("eth1")
vmInfo = VmInfo.new()
routeInfo = RouteInfo.new()

if ARGV.length.zero?
   $stderr.puts "COMポートの番号を指定してください"
   $stderr.puts "Usage : ruby RemoteManagement.rb /dev/ttyAMA0"
   exit
end

port = ARGV.first
puts "COMポート: #{port}"

Signal.trap(:INT) { exit }

puts "シリアル接続開始..."

SerialPort.open(port, 115200, 8, 1, SerialPort::NONE) do |serial|
   serial.read_timeout = -1
   puts "シリアル接続成功"

   # ログイン処理
   login(serial)

   # コマンド送受信 
   loop do
      sleep 5
      print "*************************" +  hostname + "*************************\n"

      # プロンプト受信待ち
      waitPrompt(serial)

      # mii-toolコマンド送受信
      linkInfo0.command(serial)
      linkInfo1.command(serial)

      # ifconfigコマンド送受信
      ipInfo0.command(serial)
      ipInfo1.command(serial)
      
      # vmstatコマンド送受信
      vmInfo.command(serial)
      
      # routeコマンド送受信
      routeInfo.command(serial)
      
      # 管理サーバへデータ転送
      Net::HTTP.version_1_2
      url = URI.parse('http://192.168.12.1/insert.php')
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data({'Hostname'=>hostname,  'Device0'=>ipInfo0.device, 'link0'=>linkInfo0.link, 'HWaddr0'=>ipInfo0.hwaddr, 'inet_addr0'=>ipInfo0.inetaddr, 'Bcast0'=>ipInfo0.bcast, 'Mask0'=>ipInfo0.mask, 'Rx0'=>ipInfo0.rx, 'Tx0'=>ipInfo0.tx, 'Device1'=>ipInfo1.device, 'link1'=>linkInfo1.link, 'HWaddr1'=>ipInfo1.hwaddr, 'inet_addr1'=>ipInfo1.inetaddr, 'Bcast1'=>ipInfo1.bcast, 'Mask1'=>ipInfo1.mask, 'Rx1'=>ipInfo1.rx, 'Tx1'=>ipInfo1.tx, 'Route'=>routeInfo.table, 'memory_free'=>vmInfo.memory_free, 'cpu_id'=>vmInfo.cpu_id})
      res = Net::HTTP::start(url.host, url.port) { |http|
         http.request(req)
      }
   end
end

