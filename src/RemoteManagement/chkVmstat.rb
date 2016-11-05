#
# vmstat用
#
# *** vmstatコマンドの実行例 ***
# procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
# r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
# 0  0      0 233000   9596 121264    0    0    27     1  853   41  2  1 97  0  0
#


# vmstatの結果を格納するクラス

class VmInfo
   def initialize()
      init()
   end

   def init()
      @memory_free = ""               # 空きメモリ容量（KB）
      @cpu_id = ""                    # アイドル時間（CPUが何も処理せずに待っていた時間）の割合
   end
   
   def memory_free
      @memory_free
   end
   
   def memory_free=(value)
      @memory_free = value
   end

   def cpu_id
      @cpu_id
   end
   
   def cpu_id=(value)
      @cpu_id = value
   end
   
   # serial経由でvmstatコマンドを発行し
   # VmInfoの指定したデバイス情報を取得
   def command(serial)
      init()
      serial.write "vmstat\n"     # vmstatコマンド発行
      begin
         sleep 0.05
         recv = serial.readline   # コマンド名の読み飛ばし
         sleep 0.05
         recv = serial.readline   # vmstatヘッダーの読み飛ばし
         sleep 0.05
         recv = serial.readline   # vmstatヘッダーの読み飛ばし
         sleep 0.05
         recv = serial.readline   # vmstatデータの取得
         ary = recv.scanf("%s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s")
         if ary.length == 17
            @memory_free = ary[3]
            @cpu_id    = ary[14]
         end
      rescue EOFError
         
      end
      printAll
   end

   def printAll
      print "***** vmstat実行結果 *****\n"
      print "[memory free] #{@memory_free}\n"
      print "[cpu id]      #{@cpu_id}\n"
      print "\n"
   end
end



