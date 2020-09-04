package logbackkafka

import (
	"os"
	"path/filepath"
	"time"
)

// DashOutput implents github.com/childe/gohangout/filter.Filter interface
type FileOutput struct {
	config map[interface{}]interface{}
}

// New returns a output.Output interface
func New(config map[interface{}]interface{}) interface{} {
	return &FileOutput{
		config: config,
	}
}

// Emit output '-' and new line
func (p *FileOutput) Emit(event map[string]interface{}) {
	//原始消息存放字段
	str_content := event["message"].(string)
	//日志grok字段
	appname := event["appname"].(string)
	//当天日期
	timeday := time.Now().Format("2006-01-02")
	//日志存放目录
	basedir, _ := os.Getwd()
	dir := filepath.Join(basedir, "logs", appname)
	_, err := os.Stat(dir)
	if err != nil {
		os.MkdirAll(dir, os.ModePerm)
	}
	//写文件
	fd, _ := os.OpenFile(dir+"/"+timeday+".log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0644)
	buf := []byte(str_content)
	fd.Write(buf)
}

func (p *FileOutput) Shutdown() {}
