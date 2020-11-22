package main

import (
	"flag"
	model "github.com/HFO4/cloudreve/models"
	"github.com/HFO4/cloudreve/pkg/conf"
	"github.com/HFO4/cloudreve/pkg/util"
	"os"
	"strconv"
)

var isPro bool

func init()  {
	flag.BoolVar(&isPro, "pro", false, "是否为pro版本")
	flag.Parse()
}

func main(){
	conf.Init(util.RelativePath("conf.ini"))
	model.Init()
	newPolicyID,err := strconv.ParseUint(os.Args[2],10,0)
	if err != nil{
		util.Log().Panic("发生错误: %s",err)
	}
	util.Log().Info("开始转换")
	model.DB.Model(&model.File{}).
		Where("policy_id = ?",os.Args[1]).
		Updates(model.File{PolicyID:uint(newPolicyID)})
	if isPro {
		model.DB.Model(&model.Folder{}).
			Where("policy_id = ?",os.Args[1]).
			Update("policy_id",newPolicyID)
	}
}
