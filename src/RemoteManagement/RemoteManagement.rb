require 'serialport'
require 'scanf'
require './prompt'
require './chkLink'
require './chkIfconfig'
require './chkVmstat'
require 'net/http'

linkInfo = LinkInfo.new()
ipInfo = IpInfo.new("eth0")
vmInfo = VmInfo.new()

if ARGV.length.zero?
   $stderr.puts "COMポートの番号を指定してください"
   $stderr.puts "Usage : ruby RemoteManagement.rb /dev/ttyAMA0"
   exit
end

port = ARGV.first
puts "COMポート: #{port}"

Signal.trap(:INT) { exit }

SerialPort.open(port, 115200, 8, 1, SerialPort::NONE) do |serial|
   serial.read_timeout = -1

   # ログイン処理
   login(serial)

   # コマンド送受信 
   loop do
      sleep 5
      print "*************************************************************\n"

      # プロンプト受信待ち
      waitPrompt(serial)

      # mii-toolコマンド送受信
      chkLink(serial, linkInfo)

      # ifconfigコマンド送受信
      chkIfconfig(serial, ipInfo)
      
      # vmstatコマンド送受信
      chkVmstat(serial, vmInfo)
      
      # 管理サーバへデータ転送
      Net::HTTP.version_1_2
      url = URI.parse('http://192.168.1.113/insert.php')
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data({'link'=>linkInfo.link, 'Device'=>ipInfo.device, 'HWaddr'=>ipInfo.hwaddr, 'inet_addr'=>ipInfo.inetaddr, 'Bcast'=>ipInfo.bcast, 'Mask'=>ipInfo.mask, 'memory_free'=>vmInfo.memory_free, 'cpu_id'=>vmInfo.cpu_id})
      res = Net::HTTP::start(url.host, url.port) { |http|
         http.request(req)
      }
   end
end

