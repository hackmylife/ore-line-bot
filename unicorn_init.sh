#!/bin/sh
# chkconfig: 345 90 20
# description: Rails application sample
# processname: unicorn_sample
 
PROJECT_ENV=production
SERVICE=ore-line-bot

PROJECT_ROOT_DIR=`dirname $[0]`

PID=${PROJECT_ROOT_DIR}/tmp/pids/unicorn.pid
UNICORN_CONF=${PROJECT_ROOT_DIR}/unicorn.rb
 
UNICORN_ALIVE=`ps aux|grep '${UNICORN_CONF}'|grep -v grep|wc -l`

start()
{
  if [ $UNICORN_ALIVE = 0 ]; then
    rm -f $PID
  fi
  if [ -e ${PID} ]; then
    echo "${SERVICE} already started"
    exit 1
  fi
  echo "start ${SERVICE}"
  bundle exec unicorn -c unicorn.rb -E ${PROJECT_ENV} -D
}
 
stop()
{
  if [ ! -e ${PID} ]; then
    echo "${SERVICE} not started"
    exit 1
  fi
  echo "stop ${SERVICE}"
  kill -QUIT `cat ${PID}`
}
 
force_stop()
{
  if [ ! -e ${PID} ]; then
    echo "${SERVICE} not started"
    exit 1
  fi
  echo "stop ${SERVICE}"
  kill -INT `cat ${PID}`
}
 
reload()
{
  if [ ! -e ${PID} ]; then
    echo "${SERVICE} not started"
    start
    exit 0
  fi
  echo "reload ${SERVICE}"
  kill -USR2 `cat ${PID}`
}
 
restart()
{
  if [ -e ${PID} ]; then
    stop
    sleep 3
  fi
  start
}
 
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  force-stop)
    force_stop
    ;;
  reload)
    reload
    ;;
  restart)
    restart
    ;;
  *)
    echo "Syntax Error: release [start|stop|force-stop|reload|restart]"
    ;;
esac
