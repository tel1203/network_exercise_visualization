require 'serialport'
require 'scanf'
require './prompt'
require './chkLink'
require './chkIfconfig'
require './chkVmstat'

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
      sleep 3
      print "*************************************************************\n"

      # プロンプト受信待ち
      waitPrompt(serial)

      # mii-toolコマンド送受信
      chkLink(serial, linkInfo)

      # ifconfigコマンド送受信
      chkIfconfig(serial, ipInfo)
      
      # vmstatコマンド送受信
      chkVmstat(serial, vmInfo)
   end
end

