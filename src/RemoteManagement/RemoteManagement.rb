require 'serialport'
require 'scanf'
require './prompt'
require './chkIfconfig'


ipInfo = IpInfo.new("eth0")

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

      # プロンプト受信待ち
      waitPrompt(serial)

      # コマンド送受信
      chkIfconfig(serial, ipInfo)
   end
end

