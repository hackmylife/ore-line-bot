# coding: utf-8

# プロジェクトディレクトリへのパス
@path = File.expand_path(File.dirname($0)).sub(/vendor.*$/, '')

worker_processes 1 # CPUのコア数に揃える
working_directory @path
timeout 300
listen 8090
pid "#{@path}tmp/pids/unicorn.pid" # pidを保存するファイル
# logを保存するファイル
stderr_path "#{@path}logs/unicorn.stderr.log"
stdout_path "#{@path}logs/unicorn.stdout.log"
preload_app true
